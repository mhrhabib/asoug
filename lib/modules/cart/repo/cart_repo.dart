import 'package:dio/dio.dart';
import '../../../core/network/base_client.dart';
import '../../../core/network/urls.dart' as network;
import '../models/cart_models.dart';

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

  Future<CartModel> addToCart(Map<String, dynamic> cartData) async {
    try {
      final response = await BaseClient.post(
        url: network.Urls.addCartUrl,
        payload: cartData,
      );

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
