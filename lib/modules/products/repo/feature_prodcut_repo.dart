import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../core/network/base_client.dart';
import '../../../core/network/urls.dart' as network;
import '../models/product_model.dart';

class FeaturedProductRepository {
  Future<ProductModel?> getFeaturedProducts({
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
      final Map<String, dynamic> queryParams = {
        'featured': true, // Ensure the featured flag is always present
      };

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

      print("Featured queryParams: $queryParams");

      final response = await BaseClient.get(
        url: network.Urls.getFeaturedProductsUrl,
        payload: queryParams,
      );

      if (response is Response) {
        if (response.data != null) {
          return ProductModel.fromJson(response.data);
        }
      } else if (response is Map<String, dynamic>) {
        return ProductModel.fromJson(response);
      }

      return null;
    } on DioException catch (e) {
      debugPrint('Dio Error (Featured): ${e.message}');
      if (e.response != null) {
        debugPrint('Status code: ${e.response?.statusCode}');
        debugPrint('Response data: ${e.response?.data}');
      }
      return null;
    } catch (e) {
      debugPrint('Unexpected error (Featured): $e');
      return null;
    }
  }
}
