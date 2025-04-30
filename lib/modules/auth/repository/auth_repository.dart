import 'package:dio/dio.dart';
import '../../../core/network/base_client.dart';
import '../../../core/network/urls.dart';

class AuthRepository {
  Future<dynamic> login(String email, String password) async {
    try {
      var data = {
        'email': email,
        'password': password,
      };
      print(data);
      final response = await BaseClient.post(
        url: Urls.loginUrl,
        payload: data,
      );

      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<dynamic> register(Map<String, dynamic> payload) async {
    try {
      final response = await BaseClient.post(
        url: Urls.registerUrl,
        payload: payload,
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<dynamic> forgotPassword(String email) async {
    try {
      final response = await BaseClient.post(
        url: Urls.forgotPasswordUrl,
        payload: {'email': email},
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<dynamic> logout() async {
    try {
      final response = await BaseClient.post(
        url: Urls.logoutUrl,
      );
      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }
}
