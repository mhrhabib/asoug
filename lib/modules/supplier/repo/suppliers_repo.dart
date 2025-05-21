import 'package:asoug/core/network/base_client.dart';
import 'package:asoug/core/network/urls.dart';
import 'package:asoug/modules/supplier/models/suppliers_details_model.dart';
import '../models/supplier_product_model.dart';
import '../models/suppliers_model.dart';

class SupplierRepository {
  Future<SuppliersModel> getSuppliers({int page = 1}) async {
    try {
      final response = await BaseClient.get(
        url: '${Urls.getSuppliersUrl}?page=$page',
      );

      if (response.statusCode == 200) {
        return SuppliersModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load suppliers');
      }
    } catch (e) {
      throw Exception('Failed to fetch suppliers: $e');
    }
  }

  Future<SupplierDetailsModel> getSupplierDetails(String slug) async {
    try {
      final response = await BaseClient.get(
        url: '${Urls.getSupplierDetailsUrl}/$slug',
      );

      if (response.statusCode == 200) {
        return SupplierDetailsModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load supplier details');
      }
    } catch (e) {
      throw Exception('Failed to fetch supplier details: $e');
    }
  }

  Future<SupplierProductModel> getSupplierProducts(String slug, {int page = 1}) async {
    try {
      final response = await BaseClient.get(
        url: '${Urls.getSupplierProductsUrl}$slug?page=$page',
      );

      if (response.statusCode == 200) {
        return SupplierProductModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load supplier products');
      }
    } catch (e) {
      throw Exception('Failed to fetch supplier products: $e');
    }
  }
}
