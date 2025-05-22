import 'package:asoug/core/network/base_client.dart';
import 'package:asoug/core/network/urls.dart';
import '../models/queries_model.dart';

class QueriesRepository {
  // Get all queries
  Future<QueriesModel> getQueries() async {
    try {
      final response = await BaseClient.get(
        url: Urls.getQueriesUrl,
        headers: {'x-role': 'buyer'},
      );
      if (response.statusCode == 200) {
        return QueriesModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load queries');
      }
    } catch (e) {
      throw Exception('Failed to fetch queries: $e');
    }
  }

  // Create new query
  Future<dynamic> createQuery({
    required String customerQuery,
    required String description,
    required String companyId,
  }) async {
    try {
      final response = await BaseClient.post(
        url: Urls.postQueriesUrl,
        payload: {
          'customer_query': customerQuery,
          'description': description,
          'company_id': companyId,
        },
        headers: {'x-role': 'buyer'},
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create query: $e');
    }
  }

  // Get single query details
  Future<Query> getQueryDetails(int queryId) async {
    try {
      final response = await BaseClient.get(
        url: '${Urls.showQueriesDataUrl}$queryId',
        headers: {'x-role': 'buyer'},
      );
      if (response.statusCode == 200) {
        return Query.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load query details');
      }
    } catch (e) {
      throw Exception('Failed to fetch query details: $e');
    }
  }

  // Update query
  Future<dynamic> updateQuery({
    required int queryId,
    required String customerQuery,
    required String description,
  }) async {
    try {
      final response = await BaseClient.post(
        url: '${Urls.updateQueriesDataUrl}$queryId',
        payload: {
          'customer_query': customerQuery,
          'description': description,
        },
        headers: {'x-role': 'buyer'},
      );
      return response;
    } catch (e) {
      throw Exception('Failed to update query: $e');
    }
  }

  // Delete query
  Future<dynamic> deleteQuery(int queryId) async {
    try {
      final response = await BaseClient.get(
        url: '${Urls.deleteQueriesDataUrl}$queryId',
        headers: {'x-role': 'buyer'},
      );

      return response;
    } catch (e) {
      throw Exception('Failed to delete query: $e');
    }
  }
}
