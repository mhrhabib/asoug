import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../return/return_products_screen.dart';

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

  final menuIteam = [
    {
      'name': 'My Profile',
      'icon': 'assets/icons/mynaui_user.svg',
    },
    {
      'name': 'Address',
      'icon': 'assets/icons/address.svg',
    },
    {
      'name': 'Order',
      'icon': 'assets/icons/shopping_bag.svg',
    },
    {
      'name': 'Return',
      'icon': 'assets/icons/cancel.svg',
    },
    {
      'name': 'Cancelation',
      'icon': 'assets/icons/return.svg',
    },
    {
      'name': 'Wishlist',
      'icon': 'assets/icons/fav_icon.svg',
    },
    {
      'name': 'Queries',
      'icon': 'assets/icons/queries.svg',
    },
    {
      'name': 'Help & Support',
      'icon': 'assets/icons/help_line.svg',
    },
    {
      'name': 'Log out',
      'icon': 'assets/icons/logout.svg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: CircleAvatar(
                      radius: 26,
                      child: SvgPicture.asset('assets/icons/mynaui_user.svg'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome,'),
                      Text(
                        'Abu Taleb',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: SvgPicture.asset('assets/icons/settings.svg'),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 18),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  spacing: 12,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'My Order',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                    Text(
                      'view all orders',
                      style: TextStyle(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 8),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFFFF6606),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: ListView.builder(
                    itemCount: orderNameList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            orderNameList[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      );
                    }),
              ),
            ),
            SliverToBoxAdapter(
              child: buildShoppingItem(),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 12),
            ),
            SliverToBoxAdapter(
              child: buildMenuIteam(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShoppingItem() {
    return Column(
      children: [
        Container(
          height: 140,
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                spacing: 12,
                children: [
                  SvgPicture.asset('assets/icons/shop.svg'),
                  Text(
                    'Asoug shop',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Text('To shipped', style: TextStyle(fontSize: 12)),
                ],
              ),
              Gap(8),
              Row(
                spacing: 12,
                children: [
                  Image.asset(
                    'assets/image (11).png',
                    height: 80,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width * .60, child: Text('Energizer Alkaline Power AAA Batteries 32 Count (Pack of 1), Long-Lasting Triple A Batteries')),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 12,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                'SAR 20.00',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                'Qty. 01',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 1,
          margin: EdgeInsets.only(left: 12),
          width: MediaQuery.sizeOf(context).width * .9,
          color: Colors.grey.shade300,
        ),
        Container(
          height: 140,
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                spacing: 12,
                children: [
                  SvgPicture.asset('assets/icons/shop.svg'),
                  Text(
                    'Green shop bd.',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  Text('To shipped', style: TextStyle(fontSize: 12)),
                ],
              ),
              Gap(8),
              Row(
                spacing: 12,
                children: [
                  Image.asset(
                    'assets/image (12).png',
                    height: 80,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(height: 40, width: MediaQuery.of(context).size.width * .60, child: Text('Soft PU Leather Shoulder Handbag Multi Pocket Crossbody Bag Ladies Medium Roomy Purses Fashion')),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          spacing: 12,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                'SAR 20.00',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                'Qty. 01',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              Gap(8),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 12),
                width: MediaQuery.sizeOf(context).width * .9,
                color: Colors.grey.shade300,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildMenuIteam() {
    return Container(
      height: 240,
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemCount: menuIteam.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // if (index == 0) {
              //   Get.to(() => ProfileScreen());
              // }
              // if (index == 1) {
              //   Get.to(() => AddressScreen());
              // }
              // if (index == 2) {
              //   Get.to(() => AllOrdersScreen());
              // }
              // if (index == 5) {
              //   Get.to(() => WishListScreen());
              // }
              if (index == 3) {
                Get.to(() => ReturnProductsScreen());
              }
            },
            child: Container(
              padding: EdgeInsets.all(4),
              child: Column(
                spacing: 4,
                children: [
                  SvgPicture.asset(
                    "${menuIteam[index]['icon']}",
                    colorFilter: ColorFilter.mode(Colors.deepPurple, BlendMode.dstIn),
                  ),
                  FittedBox(child: Text(menuIteam[index]['name']!)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
