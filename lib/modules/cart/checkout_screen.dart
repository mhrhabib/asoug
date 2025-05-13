import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../address/add_new_address_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String _selectedPaymentMethod = 'credit_card';
  bool _showCardDetails = true;

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
            _buildAddressCard(
              name: 'John Doe',
              address: '123 Main Street, New York, USA',
              isDefault: true,
            ),
            const Gap(8),
            _buildAddressCard(
              name: 'John Smith',
              address: '456 King Fahd Road, Riyadh, Saudi Arabia',
              isDefault: false,
            ),
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
            SizedBox(
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
            ),
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
    required String name,
    required String address,
    required bool isDefault,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle address selection
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  name,
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
              address,
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

  void _placeOrder() {
    // Handle place order logic
    Get.offAll(() => OrderConfirmationScreen()); // Navigate to confirmation screen
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
              onPressed: () => Get.offAllNamed('/home'),
              child: const Text('Continue Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
