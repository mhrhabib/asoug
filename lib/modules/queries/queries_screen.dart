import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'queries_details_screen.dart';

class QueriesScreen extends StatefulWidget {
  const QueriesScreen({super.key});

  @override
  State<QueriesScreen> createState() => _QueriesScreenState();
}

class _QueriesScreenState extends State<QueriesScreen> {
  final queryList = [
    'Office ipsum you must be muted. Including another first...',
    'Contrary to popular belief, Lorem Ipsum is not simply ...',
    'It is a long established fact that a reader will be distracted ...',
    'Office ipsum you must be muted. Including another first...',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Queries'),
        actions: [
          SvgPicture.asset('assets/icons/settings.svg'),
          Gap(12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Text(
                'You can send query by visiting the seller contact page',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              // margin: EdgeInsets.symmetric(horizontal: 12),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFE8F9FF),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'S.No Query',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'Action',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            ListView.separated(
                separatorBuilder: (context, index) {
                  return Container(
                    height: 1,
                    margin: EdgeInsets.only(left: 12),
                    width: MediaQuery.sizeOf(context).width * .9,
                    color: Colors.grey.shade300,
                  );
                },
                itemCount: queryList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('${index + 1}'),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .60,
                          child: Text(queryList[index]),
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => QueriesDetailsScreen());
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'View',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
