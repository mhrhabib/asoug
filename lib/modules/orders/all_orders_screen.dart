import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'order_details_screen.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  final List<String> orderStatusList = [
    'All',
    'Confirmed',
    'Processing',
    'On the way',
    'Completed',
    'On hold',
    'Canceled',
  ];

  int _selectedStatusIndex = 0;
  final List<Map<String, dynamic>> _allOrders = [
    {
      'id': 'ORD-12345',
      'shop': 'Asoug shop',
      'image': 'assets/image (11).png',
      'title': 'Energizer Alkaline Power AAA Batteries 32 Count (Pack of 1)',
      'price': 20.00,
      'quantity': 2,
      'status': 'On the way',
      'date': '2023-05-15',
      'items': [
        {'name': 'Batteries', 'price': 20.00, 'quantity': 2}
      ],
    },
    {
      'id': 'ORD-12346',
      'shop': 'Green shop bd.',
      'image': 'assets/image (1).png',
      'title': 'Soft PU Leather Shoulder Handbag',
      'price': 35.00,
      'quantity': 1,
      'status': 'Processing',
      'date': '2023-05-10',
      'items': [
        {'name': 'Handbag', 'price': 35.00, 'quantity': 1}
      ],
    },
    {
      'id': 'ORD-12347',
      'shop': 'Tech Store',
      'image': 'assets/image (2).png',
      'title': 'Wireless Headphones',
      'price': 59.99,
      'quantity': 1,
      'status': 'Completed',
      'date': '2023-04-28',
      'items': [
        {'name': 'Headphones', 'price': 59.99, 'quantity': 1}
      ],
    },
    {
      'id': 'ORD-12348',
      'shop': 'Fashion Outlet',
      'image': 'assets/image (12).png',
      'title': 'Men\'s Running Shoes',
      'price': 45.00,
      'quantity': 1,
      'status': 'Canceled',
      'date': '2023-04-20',
      'items': [
        {'name': 'Running Shoes', 'price': 45.00, 'quantity': 1}
      ],
    },
  ];

  List<Map<String, dynamic>> get _filteredOrders {
    if (_selectedStatusIndex == 0) return _allOrders;
    return _allOrders.where((order) => order['status'].toLowerCase() == orderStatusList[_selectedStatusIndex].toLowerCase()).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Orders',
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
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Status Filter Chips
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: orderStatusList.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedStatusIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: _selectedStatusIndex == index ? const Color(0xFFFF6606) : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          orderStatusList[index],
                          style: TextStyle(
                            color: _selectedStatusIndex == index ? Colors.white : Colors.black,
                            fontSize: isSmallScreen ? 12 : 14,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Orders List
          _filteredOrders.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.receipt_long,
                          size: 60,
                          color: Colors.grey.shade400,
                        ),
                        const Gap(16),
                        Text(
                          'No ${_selectedStatusIndex == 0 ? '' : orderStatusList[_selectedStatusIndex]} orders found',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => _buildOrderItem(_filteredOrders[index]),
                    childCount: _filteredOrders.length,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> order) {
    final isSmallScreen = MediaQuery.of(context).size.width < 360;

    return InkWell(
      onTap: () => Get.to(() => OrderDetailsScreen()),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                  // Order Header
                  Row(
                    children: [
                      Text(
                        'Order #${order['id']}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        order['date'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),

                  // Shop and Status
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/shop.svg',
                        width: 16,
                      ),
                      const Gap(8),
                      Text(
                        order['shop'],
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(order['status']).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          order['status'],
                          style: TextStyle(
                            fontSize: 12,
                            color: _getStatusColor(order['status']),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(12),

                  // Product Details
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          order['image'],
                          height: isSmallScreen ? 60 : 80,
                          width: isSmallScreen ? 60 : 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order['title'],
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
                                  'SAR ${order['price'].toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Qty: ${order['quantity']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => _reorder(order),
                    child: const Text(
                      'Reorder',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  if (order['status'] == 'On the way')
                    TextButton(
                      onPressed: () => _trackOrder(order),
                      child: const Text(
                        'Track Order',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  if (order['status'] == 'Processing' || order['status'] == 'Confirmed')
                    TextButton(
                      onPressed: () => _cancelOrder(order),
                      child: const Text(
                        'Cancel Order',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'canceled':
        return Colors.red;
      case 'on the way':
        return Colors.blue;
      case 'processing':
        return Colors.orange;
      case 'confirmed':
        return Colors.purple;
      case 'on hold':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  void _reorder(Map<String, dynamic> order) {
    // Implement reorder functionality
    Get.snackbar(
      'Reorder',
      'Added items from order #${order['id']} to cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _trackOrder(Map<String, dynamic> order) {
    // Implement track order functionality
    Get.to(() => OrderTrackingScreen(order: order));
  }

  void _cancelOrder(Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Order'),
        content: const Text('Are you sure you want to cancel this order?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                // Update order status to canceled
                order['status'] = 'Canceled';
              });
              Navigator.pop(context);
              Get.snackbar(
                'Order Canceled',
                'Order #${order['id']} has been canceled',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class OrderTrackingScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const OrderTrackingScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Order #${order['id']}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_shipping, size: 60, color: Colors.blue),
            const Gap(20),
            Text(
              'Your order is ${order['status']}',
              style: const TextStyle(fontSize: 18),
            ),
            const Gap(20),
            const LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const Gap(20),
            const Text('Estimated delivery: May 20, 2023'),
          ],
        ),
      ),
    );
  }
}
