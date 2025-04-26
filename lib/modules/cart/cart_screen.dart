import 'package:asoug/modules/cart/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          Icon(Icons.menu),
          Gap(12),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFFF6606),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Cart (2 items)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: buildShoppingItem(),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFFF6606),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'Summary',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Gap(12),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Row(
                spacing: 12,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text('Sub-Total'),
                      Text('Shipping cost'),
                      Text('Tax'),
                      Text('Discount'),
                      Container(
                        height: 1,
                        margin: EdgeInsets.only(left: 12),
                        width: MediaQuery.sizeOf(context).width * .4,
                        color: Colors.grey.shade300,
                      ),
                      Text('Total'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8,
                    children: [
                      Text(':SAR. 40.00'),
                      Text(':SAR. 30.00'),
                      Text(':SAR. 00.00'),
                      Text(':SAR. 00.00'),
                      Container(
                        height: 1,
                        margin: EdgeInsets.only(left: 12),
                        width: MediaQuery.sizeOf(context).width * .4,
                        color: Colors.grey.shade300,
                      ),
                      Text('SAR. 40.00'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Gap(12),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: CouponSection(),
            ),
          ),
          SliverToBoxAdapter(
            child: InkWell(
              onTap: () {
                Get.to(() => CheckoutScreen());
              },
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.symmetric(horizontal: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFF340F6A),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Go To Checkout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShoppingItem() {
    return Column(
      children: [
        Container(
          height: 150,
          padding: EdgeInsets.all(12),
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
                  Icon(Icons.more_vert_outlined),
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
                              padding: const EdgeInsets.only(right: 2.0),
                              child: Row(
                                spacing: 8,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey.shade400,
                                    radius: 16,
                                    child: Icon(Icons.remove),
                                  ),
                                  Text('02'),
                                  CircleAvatar(
                                    backgroundColor: Colors.grey.shade400,
                                    radius: 16,
                                    child: Icon(Icons.add),
                                  ),
                                ],
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
          height: 150,
          padding: EdgeInsets.all(12),
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
                  Icon(Icons.more_vert_outlined),
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
                              padding: const EdgeInsets.only(right: 2.0),
                              child: Row(
                                spacing: 8,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.grey.shade400,
                                    radius: 16,
                                    child: Icon(Icons.remove),
                                  ),
                                  Text('02'),
                                  CircleAvatar(
                                    backgroundColor: Colors.grey.shade400,
                                    radius: 16,
                                    child: Icon(Icons.add),
                                  ),
                                ],
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

class CouponSection extends StatelessWidget {
  final TextEditingController couponController = TextEditingController();

  CouponSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              controller: couponController,
              decoration: InputDecoration(
                hintText: 'Enter coupon code',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF6606),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                minimumSize: Size(30, 53),
              ),
              onPressed: () {
                // Apply coupon logic here
                final coupon = couponController.text;
                print('Applying coupon: $coupon');
              },
              child: Text(
                'Apply',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
