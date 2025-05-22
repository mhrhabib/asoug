import 'package:get/get.dart';
import '../models/support_model.dart';
import '../repo/support_ticket_repo.dart';

class SupportTicketController extends GetxController {
  final SupportTicketRepository _repository = SupportTicketRepository();

  // All support tickets list
  final supportTicketsList = <Support>[].obs;
  final isLoadingTickets = false.obs;
  final ticketsError = ''.obs;

  var attachmentImagePath = ''.obs;

  // Single ticket details
  final ticketDetails = Rxn<Support>();
  final isLoadingDetails = false.obs;
  final detailsError = ''.obs;

  // Create/Update state
  final isSubmitting = false.obs;
  final submissionError = ''.obs;
  final isSuccess = false.obs;

  void resetForm() {
    attachmentImagePath.value = '';
    isSuccess(false);
    submissionError('');
  }

  @override
  void onInit() {
    fetchSupportTickets();
    super.onInit();
  }

  Future<void> fetchSupportTickets() async {
    try {
      isLoadingTickets(true);
      ticketsError('');
      final data = await _repository.getSupportTickets();
      supportTicketsList.assignAll(data.data ?? []);
    } catch (e) {
      ticketsError('Failed to load support tickets: ${e.toString()}');
      supportTicketsList.clear();
    } finally {
      isLoadingTickets(false);
    }
  }

  Future<void> fetchTicketDetails(int ticketId) async {
    try {
      isLoadingDetails(true);
      detailsError('');
      final data = await _repository.getSupportTicketDetails(ticketId);
      ticketDetails(data);
    } catch (e) {
      detailsError('Failed to load ticket details: ${e.toString()}');
      ticketDetails(null);
    } finally {
      isLoadingDetails(false);
    }
  }

  Future<void> createNewTicket({
    required String issue,
    required String description,
    String? attachmentPath,
  }) async {
    try {
      isSubmitting(true);
      submissionError('');
      isSuccess(false);
      await _repository.createSupportTicket(
        issue: issue,
        description: description,
        attachmentPath: attachmentPath,
      );
      isSuccess(true);
      fetchSupportTickets(); // Refresh the list
    } catch (e) {
      submissionError('Failed to create ticket: ${e.toString()}');
    } finally {
      isSubmitting(false);
    }
  }

  Future<void> updateExistingTicket({
    required int ticketId,
    required String issue,
    required String description,
    String? attachmentPath,
  }) async {
    try {
      isSubmitting(true);
      submissionError('');
      isSuccess(false);
      await _repository.updateSupportTicket(
        ticketId: ticketId,
        issue: issue,
        description: description,
        attachmentPath: attachmentPath,
      );
      isSuccess(true);
      fetchSupportTickets(); // Refresh the list
    } catch (e) {
      submissionError('Failed to update ticket: ${e.toString()}');
    } finally {
      isSubmitting(false);
    }
  }

  Future<void> deleteTicket(int ticketId) async {
    try {
      isSubmitting(true);
      submissionError('');
      await _repository.deleteSupportTicket(ticketId);
      fetchSupportTickets(); // Refresh the list
    } catch (e) {
      submissionError('Failed to delete ticket: ${e.toString()}');
    } finally {
      isSubmitting(false);
    }
  }
}
