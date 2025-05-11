import 'package:dio/dio.dart' as dio;
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
      var data = {'email': email};
      dio.Response response = await BaseClient.post(
        url: Urls.forgotPasswordUrl,
        payload: data,
      );
      print("respone ${response.data}");

      // if (response is! Map<String, dynamic>) {
      //   throw "Invalid server response";
      // }

      return response.data;
    } on DioException catch (e) {
      if (e.response != null && e.response!.data is Map<String, dynamic>) {
        return e.response!.data;
      }
      throw "Failed to process request";
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

  //reset password
  Future<dynamic> resetPassword({
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      final data = {
        'password': password,
        'password_confirmation': passwordConfirmation,
      };

      final response = await BaseClient.post(
        url: Urls.resetPasswordUrl,
        payload: data,
      );

      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<dynamic> verifyEmail({
    required String email,
    required String otp,
  }) async {
    try {
      final data = {
        'otp': otp,
      };
      print(data);

      final response = await BaseClient.post(
        url: Urls.verifyEmailUrl,
        payload: data,
      );

      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }

  Future<dynamic> resendVerificationEmail(String email) async {
    try {
      final data = {
        'email': email,
      };

      final response = await BaseClient.post(
        url: Urls.resendEmailUrl,
        payload: data,
      );

      return response;
    } on DioException catch (e) {
      return e.response!;
    }
  }
}
