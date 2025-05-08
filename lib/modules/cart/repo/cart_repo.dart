import 'package:dio/dio.dart';
import '../../../core/network/base_client.dart';
import '../../../core/network/urls.dart' as network;
import '../models/cart_models.dart';
import 'package:dio/dio.dart' as dio;

class CartRepository {
  Future<CartModel> getCart() async {
    try {
      final response = await BaseClient.get(
        url: network.Urls.getCartUrl,
      );

      if (response is Response) {
        return CartModel.fromJson(response.data);
      }
      throw Exception('Failed to get cart');
    } catch (e) {
      rethrow;
    }
  }

// In your cart_repository.dart
  Future<CartModel> addToCart({
    required int productId,
    required int quantity,
    int? variationId,
    int? shippingMethod,
    String? temporaryId,
  }) async {
    try {
      final payload = {
        'product_id': productId,
        'quantity': quantity,
        if (variationId != null) 'variation_id': variationId,
        if (shippingMethod != null) 'shipping_method': shippingMethod,
        if (temporaryId != null) 'temporary_id': temporaryId,
      };
      print(payload);

      dio.Response response = await BaseClient.post(
        url: network.Urls.addCartUrl,
        payload: payload,
      );

      print(response);
      print(response.statusCode);
      print(response.statusMessage);

      if (response is Response) {
        return CartModel.fromJson(response.data);
      }
      throw Exception('Failed to add to cart');
    } catch (e) {
      rethrow;
    }
  }

  Future<CartModel> updateCartItem(int cartId, Map<String, dynamic> cartData) async {
    try {
      final response = await BaseClient.put(
        url: '${network.Urls.addCartUrl}$cartId',
        payload: cartData,
      );

      if (response is Response) {
        return CartModel.fromJson(response.data);
      }
      throw Exception('Failed to update cart item');
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> removeFromCart(int cartId) async {
    try {
      final response = await BaseClient.delete(
        url: '${network.Urls.addCartUrl}$cartId',
      );
      return response is Response && response.statusCode == 200;
    } catch (e) {
      rethrow;
    }
  }

  Future<CartModel> getCartSummary() async {
    try {
      final response = await BaseClient.get(
        url: network.Urls.cartSummeryUrl,
      );

      if (response is Response) {
        return CartModel.fromJson(response.data);
      }
      throw Exception('Failed to get cart summary');
    } catch (e) {
      rethrow;
    }
  }
}
