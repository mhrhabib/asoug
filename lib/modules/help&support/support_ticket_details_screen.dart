import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'controllers/support_ticket_controller.dart';
import 'create_ticket_screen.dart';

class SupportTicketDetailsScreen extends StatelessWidget {
  final SupportTicketController controller = Get.find();

  SupportTicketDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ticketId = Get.arguments as int?;
    if (ticketId != null) {
      controller.fetchTicketDetails(ticketId);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket Details'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Edit Ticket'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete Ticket'),
              ),
            ],
            onSelected: (value) {
              if (value == 'edit') {
                _editTicket();
              } else if (value == 'delete') {
                _deleteTicket();
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        final ticket = controller.ticketDetails.value;
        final isLoading = controller.isLoadingDetails.value;

        if (isLoading && ticket == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.detailsError.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.detailsError.value),
                ElevatedButton(
                  onPressed: () => controller.fetchTicketDetails(ticketId!),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        if (ticket == null) {
          return const Center(child: Text('No ticket details available'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ticket Info Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Ticket #${ticket.ticket}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Chip(
                            backgroundColor: _getStatusColor(ticket.status),
                            label: Text(
                              ticket.status?.toUpperCase() ?? 'N/A',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const Gap(16),
                      Text(
                        ticket.issue ?? 'No issue specified',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const Gap(8),
                      Text(ticket.description ?? 'No description'),
                      const Gap(16),
                      if (ticket.attachmentUrl != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Attachment:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Gap(4),
                            Image.network(ticket.attachmentUrl!),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              const Gap(16),
              const Text(
                'Replies:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const Gap(8),
              if (ticket.replies?.isEmpty ?? true) const Text('No replies yet'),
              if (ticket.replies != null)
                ...ticket.replies!.map((reply) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reply.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(4),
                            Text(reply.description),
                            if (reply.imageUrl.isNotEmpty) ...[
                              const Gap(8),
                              Image.network(reply.imageUrl),
                            ],
                          ],
                        ),
                      ),
                    )),
            ],
          ),
        );
      }),
    );
  }

  void _editTicket() {
    final ticket = controller.ticketDetails.value;
    if (ticket != null) {
      Get.to(
        () => CreateTicketScreen(),
        arguments: {
          'isEdit': true,
          'ticketId': ticket.id,
          'issue': ticket.issue,
          'description': ticket.description,
        },
      );
    }
  }

  void _deleteTicket() async {
    final ticket = controller.ticketDetails.value;
    if (ticket != null) {
      final confirm = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Delete Ticket'),
          content: const Text('Are you sure you want to delete this ticket?'),
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
        await controller.deleteTicket(ticket.id!);
        if (controller.isSuccess.value) {
          Get.back(); // Return to list screen
          Get.snackbar(
            'Success',
            'Ticket deleted successfully',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else if (controller.submissionError.isNotEmpty) {
          Get.snackbar(
            'Error',
            controller.submissionError.value,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    }
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
