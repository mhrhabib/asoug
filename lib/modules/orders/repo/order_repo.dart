import 'package:dio/dio.dart';
import '../../../core/network/base_client.dart';
import '../../../core/network/urls.dart' as network;
import '../models/order_model.dart';

class OrderRepository {
  // For endpoints that require buyer role
  static const Map<String, String> buyerHeaders = {'x-role': 'buyer'};

  Future<OrderModel> getOrders() async {
    try {
      final response = await BaseClient.get(
        url: network.Urls.getOrdersUrl,
        headers: buyerHeaders, // Only add buyer header where needed
      );

      if (response is Response) {
        return OrderModel.fromJson(response.data);
      }
      throw Exception('Failed to get orders');
    } catch (e) {
      rethrow;
    }
  }

  Future<OrderModel> getBuyerOrders() async {
    try {
      final response = await BaseClient.get(
        url: network.Urls.getOrderBuyerUrl,
        headers: buyerHeaders,
      );

      if (response is Response) {
        return OrderModel.fromJson(response.data);
      }
      throw Exception('Failed to get buyer orders');
    } catch (e) {
      rethrow;
    }
  }

  Future<OrderModel> createOrder({
    required int shippingAddress,
    required int billingAddress,
    required int paymentMethod,
    required int shippingMethod,
    String couponCode = '',
  }) async {
    try {
      final response = await BaseClient.post(
        url: network.Urls.getOrdersUrl,
        payload: {
          'shipping_address': shippingAddress,
          'billing_address': billingAddress,
          'payment_method': paymentMethod,
          'shipping_method': shippingMethod,
          'coupon_code': couponCode,
        },
        // headers: buyerHeaders,
      );

      if (response is Response) {
        return OrderModel.fromJson(response.data);
      }
      throw Exception('Failed to create order');
    } catch (e) {
      rethrow;
    }
  }
}
