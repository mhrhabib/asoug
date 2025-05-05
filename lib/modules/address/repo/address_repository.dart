import 'package:dio/dio.dart';
import '../../../core/network/base_client.dart';
import '../../../core/network/urls.dart' as network;
import '../models/address_model.dart';

class AddressRepository {
  Future<List<Address>> getAddresses() async {
    try {
      final response = await BaseClient.get(
        url: network.Urls.addressUrl,
      );

      if (response is Response) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((json) => Address.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  Future<AddressModel> addAddress(Map<String, dynamic> addressData) async {
    try {
      final response = await BaseClient.post(
        url: network.Urls.addressUrl,
        payload: addressData,
      );

      if (response is Response) {
        return AddressModel.fromJson(response.data['data']);
      }
      throw Exception('Failed to add address');
    } catch (e) {
      rethrow;
    }
  }

  Future<AddressModel> updateAddress(int id, Map<String, dynamic> addressData) async {
    try {
      final response = await BaseClient.put(
        url: '${network.Urls.addressUrl}/$id',
        payload: addressData,
      );

      if (response is Response) {
        return AddressModel.fromJson(response.data['data']);
      }
      throw Exception('Failed to update address');
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteAddress(int id) async {
    try {
      final response = await BaseClient.delete(
        url: '${network.Urls.addressUrl}/$id',
      );
      return response is Response && response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> setDefaultAddress(int id) async {
    try {
      var data = {
        'is_default': id,
      };
      final response = await BaseClient.put(url: network.Urls.addDefaultAddressUrl, payload: data);
      return response is Response && response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }
}
