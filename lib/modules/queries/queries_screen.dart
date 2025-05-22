import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../help&support/create_ticket_screen.dart';
import 'controllers/queries_controller.dart';
import 'queries_details_screen.dart';

class QueriesScreen extends StatelessWidget {
  final QueriesController controller = Get.put(QueriesController());

  QueriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Queries'),
        actions: [
          SvgPicture.asset('assets/icons/settings.svg'),
          const Gap(12),
        ],
      ),
      body: Obx(() {
        if (controller.isLoadingQueries.value && controller.queriesList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.queriesError.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.queriesError.value),
                ElevatedButton(
                  onPressed: controller.fetchQueries,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
                child: Text(
                  'You can send query by visiting the seller contact page',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F9FF),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Row(
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
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Container(
                      height: 1,
                      margin: const EdgeInsets.only(left: 12),
                      width: MediaQuery.sizeOf(context).width * .9,
                      color: Colors.grey.shade300,
                    );
                  },
                  itemCount: controller.queriesList.length,
                  itemBuilder: (context, index) {
                    final query = controller.queriesList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text('${index + 1}'),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .60,
                            child: Text(
                              query.customerQuery ?? 'No query text',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print(query.id);
                              Get.to(
                                () => QueriesDetailsScreen(),
                                arguments: query.id,
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'View',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
