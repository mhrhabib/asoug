import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../core/common/widgets/custom_text_form_field.dart';

class ReturnSubmitScreen extends StatefulWidget {
  const ReturnSubmitScreen({super.key});

  @override
  State<ReturnSubmitScreen> createState() => _ReturnSubmitScreenState();
}

class _ReturnSubmitScreenState extends State<ReturnSubmitScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Return Submit'),
        actions: [
          SvgPicture.asset('assets/icons/settings.svg'),
          Gap(12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12.0, right: 12),
        child: Column(
          spacing: 12,
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
                      Text('Completed',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.green,
                          )),
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
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Return Reason'),
                Row(
                  children: [
                    Text('Select'),
                    Icon(Icons.arrow_forward_ios_outlined),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Refund To'),
                Row(
                  children: [
                    Text('Select'),
                    Icon(Icons.arrow_forward_ios_outlined),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Refund amount'),
                Row(
                  children: [
                    Text('SAR 20.00'),
                    Icon(Icons.arrow_forward_ios_outlined),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Return location'),
                Row(
                  children: [
                    Text('Select'),
                    Icon(Icons.arrow_forward_ios_outlined),
                  ],
                )
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Details:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CustomTextFormField(
              hintText: 'comments',
              filled: true,
              fillColor: Colors.white,
              borderDecoration: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              maxLines: 4,
            ),
            Gap(12),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [Icon(Icons.camera_alt_outlined), Text('Upload')],
                ),
              ),
            ),
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
                'Submit',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
