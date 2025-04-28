import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:asoug/modules/orders/order_details_screen.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  final orderNameList = [
    'All',
    'Confirm',
    'Processing',
    'On the way',
    'Completed',
    'On hold',
    'Canceled',
  ];

  String selectedOrder = 'All';

  // Dummy order list
  final List<Map<String, dynamic>> orders = [
    {
      'shopName': 'Asoug Shop',
      'status': 'Confirm',
      'image': 'assets/image (11).png',
      'title': 'Energizer Alkaline Power AAA Batteries 32 Count (Pack of 1), Long-Lasting Triple A Batteries',
      'price': 'SAR 20.00',
      'quantity': '01',
    },
    {
      'shopName': 'Green Shop BD',
      'status': 'On the way',
      'image': 'assets/image (1).png',
      'title': 'Soft PU Leather Shoulder Handbag Multi Pocket Crossbody Bag Ladies Medium Roomy Purses Fashion',
      'price': 'SAR 35.00',
      'quantity': '01',
    },
    {
      'shopName': 'Asoug Shop',
      'status': 'Completed',
      'image': 'assets/image (11).png',
      'title': 'Duracell AA Batteries Pack',
      'price': 'SAR 25.00',
      'quantity': '02',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredOrders = selectedOrder == 'All' ? orders : orders.where((order) => order['status'] == selectedOrder).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Orders'),
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/icons/settings.svg', height: 24),
            onPressed: () {},
          ),
          const Gap(12),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: orderNameList.length,
              separatorBuilder: (_, __) => const Gap(8),
              itemBuilder: (context, index) {
                final isSelected = orderNameList[index] == selectedOrder;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOrder = orderNameList[index];
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFFFF6606) : Colors.grey[200],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      orderNameList[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: filteredOrders.isEmpty
                ? const Center(child: Text('No orders found'))
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: filteredOrders.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final order = filteredOrders[index];
                      return buildOrderCard(order);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildOrderCard(Map<String, dynamic> order) {
    return InkWell(
      onTap: () {
        Get.to(() => const OrderDetailsScreen());
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/icons/shop.svg', height: 24),
                const Gap(8),
                Text(
                  order['shopName'],
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                Text(
                  order['status'],
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const Gap(12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  order['image'],
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
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
                        style: const TextStyle(fontSize: 14),
                      ),
                      const Gap(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            order['price'],
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Qty. ${order['quantity']}',
                            style: const TextStyle(fontSize: 14),
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
    );
  }
}
