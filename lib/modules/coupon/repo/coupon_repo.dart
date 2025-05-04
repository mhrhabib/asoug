import 'package:dio/dio.dart';
import '../../../core/network/base_client.dart';
import '../../../core/network/urls.dart' as network;

class CouponRepository {
  Future<dynamic> applyCoupon(String couponCode) async {
    try {
      final response = await BaseClient.post(
        url: network.Urls.getCouponsUrl,
        payload: {'coupon_code': couponCode},
      );

      if (response is Response) {
        return response.data;
      }
      throw Exception('Failed to apply coupon');
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> removeCoupon() async {
    try {
      final response = await BaseClient.post(
        url: network.Urls.removeCouponsUrl,
      );

      if (response is Response) {
        return response.data;
      }
      throw Exception('Failed to remove coupon');
    } catch (e) {
      rethrow;
    }
  }
}
