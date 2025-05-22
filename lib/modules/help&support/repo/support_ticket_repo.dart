import 'package:asoug/core/network/base_client.dart';
import 'package:asoug/core/network/urls.dart';
import 'package:asoug/modules/help&support/models/post_support_model.dart';
import 'package:dio/dio.dart';

import '../models/support_model.dart';

class SupportTicketRepository {
  // Get all support tickets
  Future<SupportsModel> getSupportTickets() async {
    try {
      final response = await BaseClient.get(
        url: Urls.getSupportsTicketUrl,
        headers: {'x-role': 'buyer'},
      );
      if (response.statusCode == 200) {
        return SupportsModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load support tickets');
      }
    } catch (e) {
      throw Exception('Failed to fetch support tickets: $e');
    }
  }

  // Create new support ticket
  Future<PostSupportsModel> createSupportTicket({
    required String issue,
    required String description,
    String? attachmentPath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'issue': issue,
        'description': description,
        if (attachmentPath != null) 'attachment': await MultipartFile.fromFile(attachmentPath),
      });

      final response = await BaseClient.post(
        url: Urls.postSupportsTicketUrl,
        payload: formData,
        headers: {'x-role': 'buyer'},
      );
      return PostSupportsModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create support ticket: $e');
    }
  }

  // Get single support ticket details
  Future<Support> getSupportTicketDetails(int ticketId) async {
    try {
      final response = await BaseClient.get(
        url: '${Urls.showSupportsTicketUrl}$ticketId',
        headers: {'x-role': 'buyer'},
      );
      if (response.statusCode == 200) {
        return Support.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load ticket details');
      }
    } catch (e) {
      throw Exception('Failed to fetch ticket details: $e');
    }
  }

  // Update support ticket
  Future<Response> updateSupportTicket({
    required int ticketId,
    required String issue,
    required String description,
    String? attachmentPath,
  }) async {
    try {
      final formData = FormData.fromMap({
        'issue': issue,
        'description': description,
        if (attachmentPath != null) 'attachment': await MultipartFile.fromFile(attachmentPath),
      });

      final response = await BaseClient.put(
        url: '${Urls.updateSupportsTicketUrl}$ticketId',
        payload: formData,
        headers: {'x-role': 'buyer'},
      );
      return response;
    } catch (e) {
      throw Exception('Failed to update ticket: $e');
    }
  }

  // Delete support ticket
  Future<Response> deleteSupportTicket(int ticketId) async {
    try {
      final response = await BaseClient.delete(
        url: '${Urls.deleteSupportsTicketUrl}$ticketId',
        headers: {'x-role': 'buyer'},
      );
      return response;
    } catch (e) {
      throw Exception('Failed to delete ticket: $e');
    }
  }
}
