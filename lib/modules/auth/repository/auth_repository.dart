import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import '../../../core/common/widgets/custom_snackbar.dart';
import '../../../core/network/base_client.dart';
import '../../../core/network/urls.dart';
import '../controller/auth_controller.dart';
import '../models/register_model.dart';
import '../models/sign_in_model.dart';

class AuthRepository {
  Future<SignInModel> signIn({required String email, required String password}) async {
    var data = {
      "username": email,
      "password": password,
    };
    print(data);
    try {
      dio.Response response = await BaseClient.post(url: Urls.loginUrl, payload: data);
      if (response.statusCode == 200) {
        return SignInModel.fromJson(response.data);
      } else if (response.statusCode == 500) {
        CustomSnackBar.showCustomErrorToast(message: "Server Error");
        Get.find<AuthController>().isLoading.value = false;
      } else {
        Get.find<AuthController>().isLoading.value = false;
        CustomSnackBar.showCustomErrorToast(message: '${response.data['error']}');
      }
      throw "${response.statusCode}";
    } on dio.DioException catch (err) {
      throw CustomSnackBar.showCustomErrorToast(message: '${err}');
    } catch (e) {
      rethrow;
    }
  }

  static Future signUpApiCall({
    required String name,
    required String type,
    required String phone,
    required String email,
    required String countryId,
    required String password,
    required String confirmPassword,
    required String agree,
  }) async {
    var data = {
      "type": type,
      "username": name,
      "mobile": phone,
      "agree": agree,
      "country": countryId,
      "email": email,
      "password": password,
      'password_confirmation': confirmPassword,
    };
    print(data);
    try {
      dio.Response response = await BaseClient.post(url: Urls.registerUrl, payload: data);
    } on Exception catch (e) {}
  }

  //verify email
  static Future verifyEmail({String? code}) async {
    var data = {
      "code": code,
    };
    print(data);
    try {
      dio.Response response = await BaseClient.post(url: '', payload: data);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        Get.find<AuthController>().verifyIsLoading.value = false;
        CustomSnackBar.showCustomToast(message: response.data['error'].toString());
        print(response);
      }
      throw "${response.statusMessage}";
    } catch (e) {
      rethrow;
    }
  }
}
