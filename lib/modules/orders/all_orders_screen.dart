import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'controllers/order_controller.dart';
import 'models/order_model.dart';
import 'order_details_screen.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  final OrderController _orderController = Get.put(OrderController());
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

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      _orderController.fetchOrders();
    });
  }

  List<Orders> get _filteredOrders {
    if (_selectedStatusIndex == 0) return _orderController.orders.value?.data ?? [];
    return _orderController.orders.value?.data?.where((order) => order.status == _selectedStatusIndex).toList() ?? [];
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
      body: Obx(() {
        if (_orderController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_orderController.errorMessage.value.isNotEmpty) {
          return Center(
            child: Text(
              _orderController.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        return CustomScrollView(
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
                      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                      ]),
                    ),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildOrderItem(_filteredOrders[index]),
                      childCount: _filteredOrders.length,
                    ),
                  ),
          ],
        );
      }),
    );
  }

  Widget _buildOrderItem(Orders order) {
    final isSmallScreen = MediaQuery.of(context).size.width < 360;
    final firstCompany = order.companies?.firstOrNull;
    final firstProduct = firstCompany?.products?.firstOrNull;

    return InkWell(
      onTap: () => Get.to(() => OrderDetailsScreen(order: order)),
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
                        'Order #${order.orderId}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Date here', // You might want to add date to your model
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
                        firstCompany?.companyName ?? 'No company',
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
                          color: _getStatusColor(_getStatusString(order.status ?? 0)).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _getStatusString(order.status ?? 0),
                          style: TextStyle(
                            fontSize: 12,
                            color: _getStatusColor(_getStatusString(order.status ?? 0)),
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
                        child: firstCompany?.companyLogoPath != null
                            ? Image.network(
                                firstCompany!.companyLogoPath!,
                                height: isSmallScreen ? 60 : 80,
                                width: isSmallScreen ? 60 : 80,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(
                                  height: isSmallScreen ? 60 : 80,
                                  width: isSmallScreen ? 60 : 80,
                                  color: Colors.grey.shade200,
                                  child: const Icon(Icons.image_not_supported),
                                ),
                              )
                            : Container(
                                height: isSmallScreen ? 60 : 80,
                                width: isSmallScreen ? 60 : 80,
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.store),
                              ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              firstProduct?.name ?? 'No product name',
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
                                  'SAR ${firstProduct?.price ?? '0.00'}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Qty: ${firstProduct?.quantity ?? 0}',
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
                  if (order.status == 3) // On the way
                    TextButton(
                      onPressed: () => _trackOrder(order),
                      child: const Text(
                        'Track Order',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  if (order.status == 1 || order.status == 2) // Processing or Confirmed
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

  String _getStatusString(int status) {
    switch (status) {
      case 1:
        return 'Confirmed';
      case 2:
        return 'Processing';
      case 3:
        return 'On the way';
      case 4:
        return 'Completed';
      case 5:
        return 'On hold';
      case 6:
        return 'Canceled';
      default:
        return 'Unknown';
    }
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

  void _reorder(Orders order) {
    // Implement reorder functionality
    Get.snackbar(
      'Reorder',
      'Added items from order #${order.orderId} to cart',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _trackOrder(Orders order) {
    // Implement track order functionality
    Get.to(() => OrderTrackingScreen(order: order));
  }

  void _cancelOrder(Orders order) {
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
              // Update order status to canceled (status 6)
              // You might want to add an API call to update the status
              Get.back();
              Get.snackbar(
                'Order Canceled',
                'Order #${order.orderId} has been canceled',
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
  final Orders order;

  const OrderTrackingScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Order #${order.orderId}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.local_shipping, size: 60, color: Colors.blue),
            const Gap(20),
            Text(
              'Your order is ${_getStatusString(order.status ?? 0)}',
              style: const TextStyle(fontSize: 18),
            ),
            const Gap(20),
            const LinearProgressIndicator(
              value: 0.6,
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            const Gap(20),
            const Text('Estimated delivery: Soon'), // Add actual delivery date
          ],
        ),
      ),
    );
  }

  String _getStatusString(int status) {
    switch (status) {
      case 1:
        return 'Confirmed';
      case 2:
        return 'Processing';
      case 3:
        return 'On the way';
      case 4:
        return 'Completed';
      case 5:
        return 'On hold';
      case 6:
        return 'Canceled';
      default:
        return 'Unknown';
    }
  }
}
