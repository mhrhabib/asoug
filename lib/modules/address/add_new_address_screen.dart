import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'controllers/address_controller.dart';

class AddNewAddressScreen extends StatefulWidget {
  final Map<String, String>? address; // For editing existing address

  const AddNewAddressScreen({super.key, this.address});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _address1Controller;
  late TextEditingController _address2Controller;
  late TextEditingController _countryController;
  late TextEditingController _stateController;
  late TextEditingController _cityController;
  late TextEditingController _zipController;
  bool _isDefault = false;

  @override
  void initState() {
    super.initState();
    final address = widget.address;
    _nameController = TextEditingController(text: address?['name'] ?? '');
    _emailController = TextEditingController(text: address?['email'] ?? '');
    _phoneController = TextEditingController(text: address?['phone'] ?? '');
    _address1Controller = TextEditingController(text: address?['address1'] ?? '');
    _address2Controller = TextEditingController(text: address?['address2'] ?? '');
    _countryController = TextEditingController(text: address?['country'] ?? '');
    _stateController = TextEditingController(text: address?['state'] ?? '');
    _cityController = TextEditingController(text: address?['city'] ?? '');
    _zipController = TextEditingController(text: address?['zip'] ?? '');
    _isDefault = address?['isDefault'] == 'true';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _countryController.dispose();
    _stateController.dispose();
    _cityController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final buttonWidth = screenWidth * 0.9;
    final isEditing = widget.address != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? 'Edit Address' : 'Add New Address',
          style: const TextStyle(fontWeight: FontWeight.bold),
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildLabeledTextField(
                label: 'Full Name',
                controller: _nameController,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter your name' : null,
                textInputAction: TextInputAction.next,
              ),
              _buildLabeledTextField(
                label: 'Email',
                controller: _emailController,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Please enter your email';
                  if (!value!.contains('@')) return 'Please enter a valid email';
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              _buildLabeledTextField(
                label: 'Phone Number',
                controller: _phoneController,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter your phone' : null,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
              ),
              _buildLabeledTextField(
                label: 'Address Line 1',
                controller: _address1Controller,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter your address' : null,
                textInputAction: TextInputAction.next,
              ),
              _buildLabeledTextField(
                label: 'Address Line 2 (Optional)',
                controller: _address2Controller,
                textInputAction: TextInputAction.next,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildLabeledTextField(
                      label: 'Country',
                      controller: _countryController,
                      validator: (value) => value?.isEmpty ?? true ? 'Please enter country' : null,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: _buildLabeledTextField(
                      label: 'State',
                      controller: _stateController,
                      validator: (value) => value?.isEmpty ?? true ? 'Please enter state' : null,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildLabeledTextField(
                      label: 'City',
                      controller: _cityController,
                      validator: (value) => value?.isEmpty ?? true ? 'Please enter city' : null,
                      textInputAction: TextInputAction.next,
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: _buildLabeledTextField(
                      label: 'ZIP Code',
                      controller: _zipController,
                      validator: (value) => value?.isEmpty ?? true ? 'Please enter ZIP code' : null,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ],
              ),
              const Gap(12),
              SwitchListTile(
                title: const Text('Set as default address'),
                value: _isDefault,
                onChanged: (value) {
                  setState(() {
                    _isDefault = value;
                  });
                },
                activeColor: Theme.of(context).primaryColor,
              ),
              const Gap(24),
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
                  onPressed: _submitAddress,
                  icon: const Icon(Icons.check, size: 20),
                  label: Text(
                    isEditing ? 'Update Address' : 'Save Address',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabeledTextField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const Gap(4),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            decoration: InputDecoration(
              hintText: 'Enter $label',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
            validator: validator,
          ),
        ],
      ),
    );
  }

  void _submitAddress() {
    if (_formKey.currentState?.validate() ?? false) {
      final addressData = {
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
        'address1': _address1Controller.text,
        'address2': _address2Controller.text,
        'country': _countryController.text,
        'state': _stateController.text,
        'city': _cityController.text,
        'zip': _zipController.text,
        'isDefault': _isDefault.toString(),
      };

      final addressController = Get.find<AddressController>();

      if (widget.address != null) {
        // Editing existing address - you'll need to have the address ID
        final addressId = int.tryParse(widget.address?['id'] ?? '0') ?? 0;
        addressController.updateAddress(addressId, addressData);
      } else {
        // Adding new address
        addressController.addAddress(addressData);
      }
    }
  }
}
