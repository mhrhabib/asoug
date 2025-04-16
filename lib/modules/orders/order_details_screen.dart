import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order details'),
        actions: [
          SvgPicture.asset('assets/icons/settings.svg'),
          Gap(12),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue.shade200,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Current Status:'),
                      Row(
                        spacing: 12,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {},
                            child: Text('Pending'),
                          ),
                          Icon(
                            Icons.print_outlined,
                            size: 32,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('Order Date:'), Text('24 Jul 2025'), Text('12.15 PM')],
                  ),
                ],
              ),
            ),
            _buildShippingInfo(),
            _buildBillingInfo(),
            _buildPaymentInfo(),
            Gap(12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              margin: EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.blue.shade200,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Image',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'Product Name',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Gap(12)
                ],
              ),
            ),
            Gap(12),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  DecoratedBox(
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade400)),
                    child: Image.asset(
                      'assets/image (1).png',
                      fit: BoxFit.contain,
                      width: MediaQuery.sizeOf(context).width * .30,
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .60,
                    child: Text('Energizer Alkaline Power AAA Batteries 32 Count (Pack of 1), Long-Lasting Triple A Batteries'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    'Company name',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Gap(12),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .450,
                    child: Text('Asoug express'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      'Price',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Gap(12),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .450,
                    child: Text('SAR 20.00'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      'Quantity',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Gap(12),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .450,
                    child: Text('1'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      'Total',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Gap(12),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .450,
                    child: Text('SAR 20.00'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      'Sub-total',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Gap(12),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .450,
                    child: Text('SAR 20.00'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      'TAX',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Gap(12),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .450,
                    child: Text('SAR 20.00'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      'Discount',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Gap(12),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .450,
                    child: Text('SAR 20.00'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildShippingInfo() {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            'Shipping Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue),
          ),
          Row(
            spacing: 30,
            children: [
              Text('Contact Name', style: TextStyle(fontSize: 18)),
              Text('Russel crow'),
            ],
          ),
          Row(
            spacing: 30,
            children: [
              Text('Phone', style: TextStyle(fontSize: 18)),
              Text('0198834848533'),
            ],
          ),
          Row(
            spacing: 30,
            children: [
              Text('Address', style: TextStyle(fontSize: 18)),
              Text('Dhaka Bangladesh 1200'),
            ],
          ),
        ],
      ),
    );
  }

  _buildBillingInfo() {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            'Billing Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue),
          ),
          Row(
            spacing: 30,
            children: [
              Text('Contact Name', style: TextStyle(fontSize: 18)),
              Text('Russel crow'),
            ],
          ),
          Row(
            spacing: 30,
            children: [
              Text('Phone', style: TextStyle(fontSize: 18)),
              Text('0198834848533'),
            ],
          ),
          Row(
            spacing: 30,
            children: [
              Text('Address', style: TextStyle(fontSize: 18)),
              Text('Dhaka Bangladesh 1200'),
            ],
          ),
        ],
      ),
    );
  }

  _buildPaymentInfo() {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            'Payment Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.blue),
          ),
          Row(
            spacing: 30,
            children: [
              Text('Payment Method', style: TextStyle(fontSize: 18)),
              Text('VISA Card'),
            ],
          ),
          Row(
            spacing: 30,
            children: [
              Text('Payment Status', style: TextStyle(fontSize: 18)),
              Text(
                'Unpaid',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
