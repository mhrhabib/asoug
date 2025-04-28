import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../address/address_screen.dart';
import '../help&support/help_support_screen.dart';
import '../orders/all_orders_screen.dart';
import '../products/cancelation/cancelation_products_list_screen.dart';
import '../products/return/return_products_screen.dart';
import '../profile/profile_screen.dart';
import '../queries/queries_screen.dart';
import '../wishList/wish_list_screen.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
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
                    CircleAvatar(
                      radius: isSmallScreen ? 22 : 26,
                      backgroundColor: Colors.grey[200],
                      child: Image.asset(
                        'assets/image (1).png',
                        width: isSmallScreen ? 24 : 28,
                        fit: BoxFit.cover,
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
                        Text(
                          'Abu Taleb',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 16 : 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
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
                    return Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          orderNameList[index],
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SliverToBoxAdapter(child: Gap(12)),

            // Order items list
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildOrderItem(context, index),
                childCount: 2, // Replace with your actual order count
              ),
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

  Widget _buildOrderItem(BuildContext context, int index) {
    final isSmallScreen = MediaQuery.of(context).size.width < 360;
    final products = [
      {
        'shop': 'Asoug shop',
        'status': 'To shipped',
        'image': 'assets/image (11).png',
        'title': 'Energizer Alkaline Power AAA Batteries 32 Count (Pack of 1), Long-Lasting Triple A Batteries',
        'price': 'SAR 20.00',
        'qty': '01',
      },
      {
        'shop': 'Green shop bd.',
        'status': 'To shipped',
        'image': 'assets/image (12).png',
        'title': 'Soft PU Leather Shoulder Handbag Multi Pocket Crossbody Bag Ladies Medium Roomy Purses Fashion',
        'price': 'SAR 20.00',
        'qty': '01',
      },
    ];

    final product = products[index];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/shop.svg',
                    width: isSmallScreen ? 16 : 20,
                  ),
                  const Gap(8),
                  Text(
                    product['shop']!,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 14 : 16,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    product['status']!,
                    style: TextStyle(
                      fontSize: isSmallScreen ? 12 : 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const Gap(12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    product['image']!,
                    height: isSmallScreen ? 70 : 80,
                    width: isSmallScreen ? 70 : 80,
                    fit: BoxFit.cover,
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product['title']!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: isSmallScreen ? 12 : 14,
                          ),
                        ),
                        const Gap(8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product['price']!,
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Qty. ${product['qty']!}',
                              style: TextStyle(
                                fontSize: isSmallScreen ? 14 : 16,
                                fontWeight: FontWeight.w600,
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
          indent: 12,
          endIndent: 12,
        ),
      ],
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
