import 'package:asoug/modules/products/models/product_details_model.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import '../../../core/network/base_client.dart';
import '../../../core/network/urls.dart' as network;
import '../models/product_model.dart';

class ProductRepository {
  Future<ProductModel?> getProducts({
    String? searchQuery,
    List<String>? categories,
    String? brand,
    List<int>? brandIds,
    double? minPrice,
    double? maxPrice,
    double? minRating,
    String? sortBy,
    int? perPage,
    int? page,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};

      if (searchQuery != null && searchQuery.isNotEmpty) {
        queryParams['q'] = searchQuery;
      }
      if (categories != null && categories.isNotEmpty) {
        queryParams['category'] = categories.join(',');
      }
      if (brand != null && brand.isNotEmpty) {
        queryParams['brand'] = brand;
      }
      if (brandIds != null && brandIds.isNotEmpty) {
        queryParams['brands'] = brandIds.join(',');
      }
      if (minPrice != null) {
        queryParams['min_price'] = minPrice;
      }
      if (maxPrice != null) {
        queryParams['max_price'] = maxPrice;
      }
      if (minRating != null) {
        queryParams['rating'] = minRating;
      }
      if (sortBy != null && sortBy.isNotEmpty) {
        queryParams['sort_by'] = sortBy;
      }
      if (perPage != null) {
        queryParams['per_page'] = perPage;
      }
      if (page != null) {
        queryParams['page'] = page;
      }

      print("queryParams: $queryParams");

      final response = await BaseClient.get(
        url: network.Urls.getProductsUrl,
        payload: queryParams, // Make sure this is queryParameters, not payload
      );

      // Check if response is Dio Response and extract data
      if (response is dio.Response) {
        if (response.data != null) {
          return ProductModel.fromJson(response.data);
        }
      }
      // Handle case where response is already the data
      else if (response is Map<String, dynamic>) {
        return ProductModel.fromJson(response);
      }

      return null;
    } on dio.DioException catch (e) {
      debugPrint('Dio Error: ${e.message}');
      if (e.response != null) {
        debugPrint('Status code: ${e.response?.statusCode}');
        debugPrint('Response data: ${e.response?.data}');
      }
      return null;
    } catch (e) {
      debugPrint('Unexpected error: $e');
      return null;
    }
  }

  Future<dynamic> getProductDetails(String slug) async {
    print('in the repo');
    print(slug);
    try {
      dio.Response response = await BaseClient.get(
        url: '${network.Urls.getProductsDetailsUrl}$slug',
      );
      print(response.statusCode);
      return ProductDetailsModel.fromJson(response.data);
    } on dio.DioException catch (e) {
      return e;
    }
  }

  Future<dynamic> getFeaturedProducts() async {
    try {
      final response = await BaseClient.get(
        url: network.Urls.getFeaturedProductsUrl,
        payload: {'featured': true},
      );
      return ProductModel.fromJson(response);
    } on dio.DioException catch (e) {
      return e.response!;
    }
  }

  Future<dynamic> getRelatedProducts(String productId) async {
    try {
      final response = await BaseClient.get(
        url: '${network.Urls.getProductsUrl}/$productId/related',
      );
      return ProductModel.fromJson(response);
    } on dio.DioException catch (e) {
      return e.response!;
    }
  }
}
