import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common/widgets/custom_elevated_button.dart';
import '../../../core/common/widgets/custom_text_form_field.dart';
import '../controller/auth_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String email;
  final String token;

  ResetPasswordScreen({
    super.key,
    required this.email,
    required this.token,
  });

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                'Reset Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Set the new password for your account so you can login and access all the features.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              Obx(() => CustomTextFormField(
                    controller: controller.newPasswordController,
                    hintText: 'New Password',
                    obscureText: controller.obscureNewPassword.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                    suffix: IconButton(
                      icon: Icon(
                        controller.obscureNewPassword.value ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: controller.toggleNewPasswordVisibility,
                    ),
                  )),
              const SizedBox(height: 16),
              Obx(() => CustomTextFormField(
                    controller: controller.confirmPasswordController,
                    hintText: 'Confirm Password',
                    obscureText: controller.obscureConfirmPassword.value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != controller.newPasswordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    suffix: IconButton(
                      icon: Icon(
                        controller.obscureConfirmPassword.value ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: controller.toggleConfirmPasswordVisibility,
                    ),
                  )),
              const SizedBox(height: 32),
              Obx(() => SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.resetPassword(
                                email: email,
                                token: token,
                              ),
                      buttonStyle: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                          Theme.of(context).primaryColor,
                        ),
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      text: controller.isLoading.value ? 'Processing...' : 'Reset Password',
                      buttonTextStyle: const TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
