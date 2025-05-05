import 'package:asoug/core/network/base_client.dart';
import 'package:asoug/core/network/urls.dart';

import '../models/services_model.dart';

class ServicesRepository {
  Future<ServicesModel> getServices({int page = 1}) async {
    try {
      final response = await BaseClient.get(url: Urls.getServicesUrl);

      if (response.statusCode == 200) {
        return ServicesModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      throw Exception('Failed to fetch services: $e');
    }
  }

  Future<Data> getServiceDetails(int id) async {
    try {
      final response = await BaseClient.get(
        url: Urls.getServicesUrl + '/$id',
      );

      if (response.statusCode == 200) {
        return Data.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load service details');
      }
    } catch (e) {
      throw Exception('Failed to fetch service details: $e');
    }
  }
}
