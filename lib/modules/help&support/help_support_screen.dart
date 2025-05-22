import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'controllers/support_ticket_controller.dart';
import 'create_ticket_screen.dart';
import 'support_ticket_details_screen.dart';

class HelpSupportScreen extends StatelessWidget {
  final SupportTicketController controller = Get.put(SupportTicketController());

  HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        actions: [
          SvgPicture.asset('assets/icons/settings.svg'),
          const Gap(12),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => CreateTicketScreen()),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Obx(() {
        if (controller.isLoadingTickets.value && controller.supportTicketsList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.ticketsError.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.ticketsError.value),
                ElevatedButton(
                  onPressed: controller.fetchSupportTickets,
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
                height: 28,
                child: Text(
                  'You can create support tickets for any issues you encounter',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const Gap(12),
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
                      'Ticket #',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Status',
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
                child: RefreshIndicator(
                  onRefresh: () => controller.fetchSupportTickets(),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(height: 1),
                    itemCount: controller.supportTicketsList.length,
                    itemBuilder: (context, index) {
                      final ticket = controller.supportTicketsList[index];
                      return ListTile(
                        leading: Text('${index + 1}'),
                        title: Text(
                          ticket.issue ?? 'No issue specified',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(ticket.status),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                ticket.status?.toUpperCase() ?? 'UNKNOWN',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.chevron_right),
                              onPressed: () {
                                Get.to(
                                  () => SupportTicketDetailsScreen(),
                                  arguments: ticket.id,
                                );
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          Get.to(
                            () => SupportTicketDetailsScreen(),
                            arguments: ticket.id,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'open':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'closed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
