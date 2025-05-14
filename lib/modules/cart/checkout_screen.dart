import 'package:asoug/modules/home/screens/home_screens.dart';
import 'package:asoug/modules/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../address/add_new_address_screen.dart';
import '../address/controllers/address_controller.dart';
import '../address/models/address_model.dart';
import '../orders/controllers/order_controller.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final OrderController orderController = Get.put(OrderController());
  final AddressController addressController = Get.put(AddressController());

  String _selectedPaymentMethod = 'credit_card';
  bool _showCardDetails = true;
  int? _selectedShippingAddressId;
  int? _selectedBillingAddressId;

  @override
  void initState() {
    super.initState();
    // Set default addresses if available
    if (addressController.addressModel.isNotEmpty) {
      final defaultAddress = addressController.addressModel.firstWhere(
        (address) => address.isDefault == 1,
        orElse: () => addressController.addressModel.first,
      );
      _selectedShippingAddressId = defaultAddress.id;
      _selectedBillingAddressId = defaultAddress.id;
    }
  }

  void _placeOrder() async {
    if (_selectedShippingAddressId == null || _selectedBillingAddressId == null) {
      Get.snackbar('Error', 'Please select shipping and billing addresses');
      return;
    }

    try {
      // Map payment method selection to the expected ID
      int paymentMethodId;
      switch (_selectedPaymentMethod) {
        case 'cash_on_delivery':
          paymentMethodId = 1;
          break;
        case 'credit_card':
          paymentMethodId = 2;
          break;
        case 'bank_transfer':
          paymentMethodId = 3;
          break;
        default:
          paymentMethodId = 1;
      }

      await orderController.createOrder(
        shippingAddress: _selectedShippingAddressId!,
        billingAddress: _selectedBillingAddressId!,
        paymentMethod: paymentMethodId,
        shippingMethod: 1, // Assuming standard shipping
        couponCode: '', // Add coupon logic if needed
      );

      Get.offAll(() => OrderConfirmationScreen());
    } catch (e) {
      Get.snackbar('Error', 'Failed to place order: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final buttonWidth = screenWidth * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            // Delivery Address Section
            _buildSectionHeader(
              title: 'Deliver to',
              actionText: 'New Address',
              onAction: () => Get.to(() => const AddNewAddressScreen()),
            ),
            const Gap(8),
            // Replace your hardcoded address cards with this:
            Obx(() {
              if (addressController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (addressController.errorMessage.value.isNotEmpty) {
                return Center(
                  child: Text(addressController.errorMessage.value),
                );
              }

              if (addressController.addressModel.isEmpty) {
                return const Center(child: Text('No addresses found'));
              }

              return Column(
                children: [
                  ...addressController.addressModel.map(
                    (address) => Column(
                      children: [
                        _buildAddressCard(
                          address: address,
                          isDefault: address.isDefault == 1,
                        ),
                        const Gap(8),
                      ],
                    ),
                  ),
                ],
              );
            }),
            const Gap(16),

            // Payment Method Section
            _buildSectionHeader(title: 'Payment Method'),
            const Gap(8),
            _buildPaymentMethodSelector(),
            if (_showCardDetails) ...[
              const Gap(16),
              _buildCardDetailsForm(),
            ],
            const Gap(16),

            // Cart Summary Section
            _buildSectionHeader(title: 'Cart Summary', backgroundColor: const Color(0xFFFF6606)),
            const Gap(12),
            _buildCartSummary(),
            const Gap(24),

            // Place Order Button
            // Modify your Place Order button:
            Obx(() {
              if (orderController.isCreatingOrder.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return SizedBox(
                width: buttonWidth,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6606),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  onPressed: _placeOrder,
                  child: Text(
                    'Place Order',
                    style: TextStyle(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
            const Gap(24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader({
    required String title,
    String? actionText,
    VoidCallback? onAction,
    Color backgroundColor = const Color(0xFFE8F9FF),
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (actionText != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: backgroundColor == const Color(0xFFE8F9FF) ? Colors.orange : Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAddressCard({
    required Address address,
    required bool isDefault,
  }) {
    final isSelected = _selectedShippingAddressId == address.id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedShippingAddressId = address.id;
          _selectedBillingAddressId = address.id;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.orange : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  address.name ?? 'No name',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
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
            const Gap(4),
            Text(
              '${address.address}, ${address.city}, ${address.countryName}',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Column(
      children: [
        RadioListTile<String>(
          title: const Text('Cash on Delivery'),
          value: 'cash_on_delivery',
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value!;
              _showCardDetails = false;
            });
          },
          contentPadding: EdgeInsets.zero,
        ),
        RadioListTile<String>(
          title: const Text('Credit Card'),
          value: 'credit_card',
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value!;
              _showCardDetails = true;
            });
          },
          contentPadding: EdgeInsets.zero,
        ),
        RadioListTile<String>(
          title: const Text('Bank Transfer'),
          value: 'bank_transfer',
          groupValue: _selectedPaymentMethod,
          onChanged: (value) {
            setState(() {
              _selectedPaymentMethod = value!;
              _showCardDetails = false;
            });
          },
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }

  Widget _buildCardDetailsForm() {
    return Column(
      children: [
        _buildLabeledTextField(
          label: 'Card Number',
          hintText: '1234 5678 9012 3456',
          keyboardType: TextInputType.number,
        ),
        const Gap(12),
        Row(
          children: [
            Expanded(
              child: _buildLabeledTextField(
                label: 'Expiry Month',
                hintText: 'MM',
                keyboardType: TextInputType.number,
              ),
            ),
            const Gap(12),
            Expanded(
              child: _buildLabeledTextField(
                label: 'Expiry Year',
                hintText: 'YYYY',
                keyboardType: TextInputType.number,
              ),
            ),
            const Gap(12),
            Expanded(
              child: _buildLabeledTextField(
                label: 'CVC',
                hintText: '123',
                keyboardType: TextInputType.number,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLabeledTextField({
    required String label,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return Column(
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
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
          keyboardType: keyboardType,
        ),
      ],
    );
  }

  Widget _buildCartSummary() {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final isSmallScreen = screenWidth < 360;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          _buildSummaryRow(label: 'Sub-Total', value: 'SAR 40.00'),
          _buildSummaryRow(label: 'Shipping cost', value: 'SAR 30.00'),
          _buildSummaryRow(label: 'Tax', value: 'SAR 0.00'),
          _buildSummaryRow(label: 'Discount', value: '-SAR 0.00'),
          Divider(
            height: 24,
            thickness: 1,
            color: Colors.grey.shade300,
          ),
          _buildSummaryRow(
            label: 'Total',
            value: 'SAR 70.00',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({
    required String label,
    required String value,
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? const Color(0xFFFF6606) : null,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 80, color: Colors.green),
            const Gap(20),
            const Text(
              'Order Placed Successfully!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: () => Get.offAll(() => const MainScreen()),
              child: const Text('Continue Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
