import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'return_submit_screen.dart';

class ReturnProductsScreen extends StatefulWidget {
  const ReturnProductsScreen({super.key});

  @override
  State<ReturnProductsScreen> createState() => _ReturnProductsScreenState();
}

class _ReturnProductsScreenState extends State<ReturnProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Return list'),
        actions: [
          InkWell(
              onTap: () {
                Get.to(() => ReturnSubmitScreen());
              },
              child: SvgPicture.asset('assets/icons/settings.svg')),
          Gap(12),
        ],
      ),
      body: Column(
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
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  'Select Problem',
                  style: TextStyle(fontSize: 16),
                ),
              )),
          Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              spacing: 12,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    SvgPicture.asset('assets/icons/Box.svg'),
                    Text(
                      'Problem with items received',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text('Select this if you received a damaged/defective item, wrong item, item not as advertised, missing accessories/freebies, counterfeit item or a change of mind'),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              spacing: 12,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    SvgPicture.asset('assets/icons/Box.svg'),
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width * .80,
                      child: Text(
                        'Did not received the items or received expired items',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text('Select this if you received a damaged/defective item, wrong item, item not as advertised, missing accessories/freebies, counterfeit item or a change of mind'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
