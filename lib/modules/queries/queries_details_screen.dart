import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'controllers/queries_controller.dart';
import 'create_new_queries_screen.dart';

class QueriesDetailsScreen extends StatelessWidget {
  final QueriesController controller = Get.find();
  final TextEditingController _replyController = TextEditingController();

  QueriesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final queryId = Get.arguments as int?;
    if (queryId != null) {
      controller.fetchQueryDetails(queryId);
    }
    print(queryId);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Queries Details'),
        actions: [
          SvgPicture.asset('assets/icons/settings.svg'),
          const Gap(12),
        ],
      ),
      body: Obx(() {
        final query = controller.queryDetails.value;
        final isLoading = controller.isLoadingDetails.value;

        if (isLoading && query == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.detailsError.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.detailsError.value),
                ElevatedButton(
                  onPressed: () => controller.fetchQueryDetails(queryId!),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (query == null) {
          return const Center(child: Text('No query details available'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Query',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Gap(12),
                        Expanded(
                          child: Text(': ${query.data!.customerQuery!.customerQuery ?? 'N/A'}'),
                        ),
                      ],
                    ),
                    const Gap(12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Description',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Gap(12),
                        Expanded(
                          child: Text(': ${query.data!.customerQuery!.description ?? 'N/A'}'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 40,
                      child: Icon(Icons.person, size: 40),
                    ),
                    const Gap(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'You',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(query.data!.customerQuery!.createdAt ?? 'Unknown date'),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(12),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.7,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(query.data!.customerQuery!.description ?? 'No description'),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      query.data!.customerQuery!.isSeen == '1' ? 'Seen' : 'Not Seen',
                      style: const TextStyle(color: Colors.blue),
                    ),
                    const Icon(
                      Icons.done_all_outlined,
                      color: Colors.blue,
                    ),
                    const Gap(12),
                  ],
                ),
              ),
              const Gap(12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _replyController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Type your reply',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const Gap(12),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Obx(() {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: controller.isSubmitting.value
                          ? null
                          : () {
                              // Implement reply functionality
                              Get.snackbar(
                                'Success',
                                'Reply sent successfully',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green,
                                colorText: Colors.white,
                              );
                              _replyController.clear();
                            },
                      child: controller.isSubmitting.value ? const CircularProgressIndicator(color: Colors.white) : const Text('Send'),
                    );
                  }),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Get.to(() => CreateNewQueriesScreen(
                            companyId: query.data!.customerQuery!.companyId,
                          ));
                    },
                    child: Text('Create Support Ticket'),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Obx(() {
                    return ElevatedButton.icon(
                      icon: const Icon(Icons.delete),
                      label: controller.isSubmitting.value
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('Delete Query'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      onPressed: controller.isSubmitting.value
                          ? null
                          : () async {
                              final confirm = await Get.dialog<bool>(
                                AlertDialog(
                                  title: const Text('Confirm Deletion'),
                                  content: const Text('Are you sure you want to delete this query?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(result: false),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () => Get.back(result: true),
                                      child: const Text('Delete', style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                await controller.deleteQuery(queryId!);
                                if (controller.submissionError.isEmpty) {
                                  Get.back(); // Navigate back on success
                                  Get.snackbar(
                                    'Deleted',
                                    'Query deleted successfully',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                } else {
                                  Get.snackbar(
                                    'Error',
                                    controller.submissionError.value,
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                }
                              }
                            },
                    );
                  }),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
