import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
        actions: [
          SvgPicture.asset('assets/icons/settings.svg'),
          Gap(12),
        ],
      ),
      body: Column(
        children: [
          buildShoppingItem(),
        ],
      ),
    );
  }

  Widget buildShoppingItem() {
    return Column(
      children: [
        Container(
          height: 200,
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
                    'assets/image (1).png',
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
              Gap(12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(MediaQuery.sizeOf(context).width, 45),
                  backgroundColor: Colors.purple.shade900,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: Text(
                  'Add to cart',
                  style: TextStyle(fontSize: 20),
                ),
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
          height: 200,
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
                    'assets/image.png',
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(MediaQuery.sizeOf(context).width, 45),
                  backgroundColor: Colors.purple.shade900,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: Text(
                  'Add to cart',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                height: 1,
                margin: EdgeInsets.only(left: 12),
                width: MediaQuery.sizeOf(context).width * .9,
                color: Colors.grey.shade300,
              ),
            ],
          ),
        ),
        Container(
          height: 200,
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
                    'assets/image (2).png',
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(MediaQuery.sizeOf(context).width, 45),
                  backgroundColor: Colors.purple.shade900,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: Text(
                  'Add to cart',
                  style: TextStyle(fontSize: 20),
                ),
              ),
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
