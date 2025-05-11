import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../address/address_screen.dart';
import '../help&support/help_support_screen.dart';
import '../orders/all_orders_screen.dart';
import '../orders/controllers/order_controller.dart';
import '../orders/models/order_model.dart';
import '../products/cancelation/cancelation_products_list_screen.dart';
import '../products/return/return_products_screen.dart';
import '../profile/controller/profile_controller.dart';
import '../profile/profile_screen.dart';
import '../queries/queries_screen.dart';
import '../wishList/wish_list_screen.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  final profileController = Get.put(ProfileController());

  final orderController = Get.put(OrderController());

  final orderNameList = [
    'All',
    'confirm',
    'Processing',
    'On the way',
    'Completed',
    'On hold',
    'Canceled',
  ];

  final menuItems = [
    {
      'name': 'My Profile',
      'icon': 'assets/icons/mynaui_user.svg',
      'route': () => Get.to(() => ProfileScreen()),
    },
    {
      'name': 'Address',
      'icon': 'assets/icons/address.svg',
      'route': () => Get.to(() => AddressScreen()),
    },
    {
      'name': 'Order',
      'icon': 'assets/icons/shopping_bag.svg',
      'route': () => Get.to(() => AllOrdersScreen()),
    },
    {
      'name': 'Return',
      'icon': 'assets/icons/cancel.svg',
      'route': () => Get.to(() => ReturnProductsScreen()),
    },
    {
      'name': 'Cancelation',
      'icon': 'assets/icons/return.svg',
      'route': () => Get.to(() => CancellationListScreen()),
    },
    {
      'name': 'Wishlist',
      'icon': 'assets/icons/fav_icon.svg',
      'route': () => Get.to(() => WishListScreen()),
    },
    {
      'name': 'Queries',
      'icon': 'assets/icons/queries.svg',
      'route': () => Get.to(() => QueriesScreen()),
    },
    {
      'name': 'Help & Support',
      'icon': 'assets/icons/help_line.svg',
      'route': () => Get.to(() => HelpSupportScreen()),
    },
    {
      'name': 'Log out',
      'icon': 'assets/icons/logout.svg',
      'route': () {}, // Add your logout logic here
    },
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 360;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header with user info
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    Obx(
                      () => profileController.profile.value.avatarUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                profileController.profile.value.avatarUrl!,
                                width: 30 * 2,
                                height: 30 * 2,
                                fit: BoxFit.cover,
                              ),
                            )
                          : CircleAvatar(
                              radius: isSmallScreen ? 22 : 26,
                              backgroundColor: Colors.grey[200],
                              child: Image.asset(
                                'assets/image (1).png',
                                width: isSmallScreen ? 24 : 28,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    const Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome,',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        Obx(() {
                          if (profileController.isLoading.value) {
                            return const CircularProgressIndicator();
                          } else {
                            return Text(
                              profileController.profile.value.name ?? 'User',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 16 : 18,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          }
                        }),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      icon: SvgPicture.asset(
                        'assets/icons/settings.svg',
                        width: isSmallScreen ? 20 : 24,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            // My Orders section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Order',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => AllOrdersScreen()),
                      child: Text(
                        'view all orders',
                        style: TextStyle(
                          fontSize: isSmallScreen ? 12 : 14,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Order status tabs
            SliverToBoxAdapter(
              child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 149, 6, 196),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    itemCount: orderNameList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final status = orderNameList[index];
                      final isSelected = orderController.selectedStatus.value == status;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            orderController.selectedStatus.value = status;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              color: isSelected ? Colors.purple : Colors.white,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  )),
            ),

            const SliverToBoxAdapter(child: Gap(12)),

            // Order items list
            SliverToBoxAdapter(
              child: Obx(() {
                final filtered = orderController.filteredOrders;
                if (orderController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (filtered.isEmpty) {
                  return const Center(child: Text('No orders found.'));
                }
                return Column(
                  children: List.generate(filtered.length, (index) {
                    final order = filtered[index];
                    return _buildOrderItem(order);
                  }),
                );
              }),
            ),

            const SliverToBoxAdapter(child: Gap(16)),

            // Menu grid
            SliverToBoxAdapter(
              child: _buildMenuGrid(context),
            ),

            const SliverToBoxAdapter(child: Gap(16)),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(Orders order) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text('Order #: ${order.orderNumber ?? "N/A"}'),
        subtitle: Text('Status: ${order.status ?? "Pending"}\nDate: ${order.createdAt ?? ""}'),
        trailing: Text('SAR ${order.totalAmount?.toStringAsFixed(2) ?? "0.00"}'),
      ),
    );
  }

  Widget _buildMenuGrid(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 400 ? 3 : 4;
    final itemSize = screenWidth / crossAxisCount;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 0.9,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];
          return InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: item['route'] as void Function()?,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    item['icon'] as String,
                    width: itemSize * 0.3,
                    colorFilter: const ColorFilter.mode(
                      Colors.deepPurple,
                      BlendMode.srcIn,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    item['name'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: itemSize * 0.10,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
