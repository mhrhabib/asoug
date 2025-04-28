import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> cartItems = [
    {
      'shop': 'Asoug shop',
      'image': 'assets/image (11).png',
      'title': 'Energizer Alkaline Power AAA Batteries 32 Count (Pack of 1), Long-Lasting Triple A Batteries',
      'price': 20.00,
      'quantity': 2,
    },
    {
      'shop': 'Green shop bd.',
      'image': 'assets/image (12).png',
      'title': 'Soft PU Leather Shoulder Handbag Multi Pocket Crossbody Bag Ladies Medium Roomy Purses Fashion',
      'price': 20.00,
      'quantity': 2,
    },
  ];

  double get subtotal => cartItems.fold(0, (sum, item) => sum + (item['price'] * item['quantity']));
  double get shipping => 30.00;
  double get tax => 0.00;
  double get discount => 0.00;
  double get total => subtotal + shipping + tax - discount;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // final isSmallScreen = screenWidth < 360;
    final buttonWidth = screenWidth * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Cart Header
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6606),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  'Cart (${cartItems.length} items)',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // Cart Items
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _buildCartItem(context, index),
              childCount: cartItems.length,
            ),
          ),

          // Summary Header
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFFF6606),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          // Summary Details
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  _buildSummaryRow('Sub-Total', 'SAR ${subtotal.toStringAsFixed(2)}'),
                  _buildSummaryRow('Shipping cost', 'SAR ${shipping.toStringAsFixed(2)}'),
                  _buildSummaryRow('Tax', 'SAR ${tax.toStringAsFixed(2)}'),
                  _buildSummaryRow('Discount', '-SAR ${discount.toStringAsFixed(2)}'),
                  Divider(
                    height: 24,
                    thickness: 1,
                    color: Colors.grey.shade300,
                  ),
                  _buildSummaryRow(
                    'Total',
                    'SAR ${total.toStringAsFixed(2)}',
                    isTotal: true,
                  ),
                ],
              ),
            ),
          ),

          // Coupon Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: CouponSection(),
            ),
          ),

          // Checkout Button
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SizedBox(
                width: buttonWidth,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF340F6A),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => Get.to(() => const CheckoutScreen()),
                  child: const Text(
                    'Go To Checkout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: Gap(16)),
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, int index) {
    final item = cartItems[index];
    final isSmallScreen = MediaQuery.of(context).size.width < 360;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/shop.svg',
                      width: 20,
                    ),
                    const Gap(8),
                    Text(
                      item['shop'],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.more_vert_outlined),
                      onPressed: () => _showItemOptions(context, index),
                    ),
                  ],
                ),
                const Gap(8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        item['image'],
                        height: isSmallScreen ? 70 : 80,
                        width: isSmallScreen ? 70 : 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Gap(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['title'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const Gap(8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'SAR ${item['price'].toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              _buildQuantitySelector(index),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(int index) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, size: 18),
            onPressed: () {
              setState(() {
                if (cartItems[index]['quantity'] > 1) {
                  cartItems[index]['quantity']--;
                }
              });
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              cartItems[index]['quantity'].toString(),
              style: const TextStyle(fontSize: 14),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, size: 18),
            onPressed: () {
              setState(() {
                cartItems[index]['quantity']++;
              });
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? const Color(0xFFFF6606) : null,
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

  void _showItemOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Remove from cart'),
            onTap: () {
              Navigator.pop(context);
              setState(() {
                cartItems.removeAt(index);
              });
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border),
            title: const Text('Move to wishlist'),
            onTap: () {
              Navigator.pop(context);
              // Implement move to wishlist
            },
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text('Cancel'),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}

class CouponSection extends StatelessWidget {
  final TextEditingController couponController = TextEditingController();

  CouponSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 360;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: couponController,
              decoration: InputDecoration(
                hintText: 'Enter coupon code',
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
              style: TextStyle(
                fontSize: isSmallScreen ? 14 : 16,
              ),
            ),
          ),
          const Gap(8),
          SizedBox(
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF6606),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Apply coupon logic here
                final coupon = couponController.text;
                print('Applying coupon: $coupon');
              },
              child: Text(
                'Apply',
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
