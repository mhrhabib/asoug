import 'package:asoug/modules/orders/order_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  final orderNameList = [
    'All',
    'confirm',
    'Processing',
    'On the way',
    'Completed',
    'On hold',
    'Canceled',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Order'),
        actions: [
          SvgPicture.asset('assets/icons/settings.svg'),
          Gap(12),
        ],
      ),
      body: CustomScrollView(
        slivers: [
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
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: buildShoppingItem(),
          ),
          SliverToBoxAdapter(
            child: buildShoppingItem(),
          ),
        ],
      ),
    );
  }

  Widget buildShoppingItem() {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => OrderDetailsScreen());
          },
          child: Container(
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
                    'assets/image (1).png',
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
}
