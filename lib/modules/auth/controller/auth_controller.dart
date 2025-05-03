import 'package:asoug/core/common/widgets/toast.dart';
import 'package:asoug/modules/auth/models/login_model.dart';
import 'package:asoug/modules/auth/screens/sign_in_screen.dart';
import 'package:asoug/modules/home/screens/home_landing_screen.dart';
import 'package:asoug/modules/home/screens/home_screens.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../core/utils/storage.dart';
import '../../../routes/app_routes.dart';
import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepository();

  // Text editing controllers
  final TextEditingController email = TextEditingController();
  final TextEditingController emailreset = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController username = TextEditingController();

  // Observables
  final RxBool isVisible = true.obs;
  final RxBool isLoading = false.obs;
  final RxBool rememberMe = false.obs;

  // Toggle password visibility
  void toggleVisibility() {
    isVisible.value = !isVisible.value;
  }

  // Login function
  Future<void> login() async {
    try {
      isLoading.value = true;

      final response = await _authRepository.login(
        email.text.trim(),
        password.text.trim(),
      );

      if (response.statusCode == 200) {
        var loginData = LoginModel.fromJson(response.data);
        // Save token to storage
        await storage.write('token', loginData.data.token);
        print(">>>>>>> TOKEN >>>>>>>${storage.read('token')}");
        toast("Login successful", bgColor: Colors.green);
        // Navigate to home screen
        Get.offAll(() => HomeLandingScreen());
      } else {
        Get.snackbar(
          'Error',
          response.data['message'] ?? 'Login failed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred during login',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Add these new TextEditingControllers
  final TextEditingController name = TextEditingController();
  final TextEditingController regEmail = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password1 = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  // For account type selection
  final RxString accountType = ''.obs;
  final RxBool isAgree = false.obs;

  // For password visibility
  final RxBool isVisible1 = true.obs;
  final RxBool isVisible2 = true.obs;

  // Toggle password visibility
  void visibilityCheck1() => isVisible1.value = !isVisible1.value;
  void visibilityCheck2() => isVisible2.value = !isVisible2.value;

  // Register function
  Future<void> register() async {
    try {
      if (password1.text != confirmPassword.text) {
        throw "Passwords do not match";
      }

      isLoading.value = true;

      final Map<String, dynamic> payload = {
        "name": name.text.trim(),
        "email": regEmail.text.trim(),
        "password": password1.text.trim(),
        "password_confirmation": confirmPassword.text.trim(),
        "role": accountType.value.toLowerCase(), // Convert to lowercase to match API
        "phone": phone.text.trim(),
      };

      final response = await _authRepository.register(payload);
      print(response);
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        Get.snackbar(
          'Success',
          'Registration successful. Please login.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Navigator.of(Get.context!).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SignInScreen()),
          (Route<dynamic> route) => false,
        );
      } else {
        throw response.data['message'] ?? 'Registration failed';
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Forgot password function
  Future<void> forgotPassword(String email) async {
    try {
      isLoading.value = true;

      final response = await _authRepository.forgotPassword(email);

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Password reset link sent to your email',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.back(); // Go back to login screen
      } else {
        Get.snackbar(
          'Error',
          response.data['message'] ?? 'Failed to send reset link',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An error occurred while processing your request',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      // Call logout API
      final response = await _authRepository.logout();

      if (response.statusCode == 200) {
        // Clear local storage
        await storage.remove('token');
        await storage.remove('user');
        Fluttertoast.showToast(msg: "Logout successful", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.green, textColor: Colors.white, fontSize: 16.0);
        // Navigate to login screen and clear all routes
        Get.offAll(() => SignInScreen());
      } else {
        throw response.data['message'] ?? 'Logout failed';
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // email.dispose();
    // password.dispose();
    // name.dispose();
    // phone.dispose();
    // password1.dispose();
    // confirmPassword.dispose();

    super.onClose();
  }
}
