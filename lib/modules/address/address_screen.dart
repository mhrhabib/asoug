import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'add_new_address_screen.dart';
import 'controllers/address_controller.dart';
import 'models/address_model.dart';

class AddressScreen extends StatelessWidget {
  final AddressController _controller = Get.put(AddressController());

  AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final buttonWidth = screenWidth * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Address',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/settings.svg',
              width: 24,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (_controller.isLoading.value && _controller.addressModel.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_controller.errorMessage.value),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _controller.fetchAddresses,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 12.0 : 16.0,
            vertical: 8.0,
          ),
          child: Column(
            children: [
              Text(
                'You can manage your shipping address here',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(16),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _controller.fetchAddresses,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: _controller.addressModel.length,
                    itemBuilder: (context, index) {
                      final address = _controller.addressModel[index];
                      return AddressCard(
                        address: address,
                        onEdit: () => _editAddress(address),
                        onDelete: () => _deleteAddress(address.id!),
                        onSetDefault: () => _setDefaultAddress(address.id!),
                      );
                    },
                  ),
                ),
              ),
              const Gap(16),
              SizedBox(
                width: buttonWidth,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => Get.to(
                    () => AddNewAddressScreen(),
                    arguments: {'mode': 'add'},
                  ),
                  icon: const Icon(Icons.add, size: 20),
                  label: Text(
                    'Add New Address',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Gap(16),
            ],
          ),
        );
      }),
    );
  }

  void _editAddress(Address address) {
    Get.to(
      () => AddNewAddressScreen(),
      arguments: {'mode': 'edit', 'address': address},
    );
  }

  void _deleteAddress(int id) {
    Get.defaultDialog(
      title: 'Delete Address',
      middleText: 'Are you sure you want to delete this address?',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        _controller.deleteAddress(id);
        Get.back();
      },
      onCancel: () {},
    );
  }

  void _setDefaultAddress(int id) {
    _controller.setDefaultAddress(id);
  }
}

class AddressCard extends StatelessWidget {
  final Address address;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onSetDefault;

  const AddressCard({
    super.key,
    required this.address,
    required this.onEdit,
    required this.onDelete,
    required this.onSetDefault,
  });

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 360;
    final isDefault = address.isDefault == 1;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).primaryColor,
                  size: isSmallScreen ? 24 : 28,
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    address.name ?? 'No name',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (isDefault)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.green),
                    ),
                    child: Text(
                      'Default',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green[800],
                      ),
                    ),
                  ),
              ],
            ),
            const Gap(8),
            Padding(
              padding: const EdgeInsets.only(left: 36.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${address.address}, ${address.address2 ?? ''}',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                  ),
                  Text(
                    '${address.city}, ${address.stateName}, ${address.countryName}',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 13 : 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    'Phone: ${address.phone}',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 13 : 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const Gap(8),
                  Row(
                    children: [
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: onEdit,
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      const Gap(8),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(50, 30),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: onDelete,
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      const Spacer(),
                      if (!isDefault)
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(50, 30),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: onSetDefault,
                          child: Text(
                            'Set as Default',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
