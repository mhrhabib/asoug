import 'package:asoug/core/common/widgets/custom_elevated_button.dart';
import 'package:asoug/core/common/widgets/custom_text_form_field.dart';
import 'package:asoug/modules/auth/forgotPassword/verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final authController = Get.put(AuthController());

  @override
  void dispose() {
    authController.email.dispose();
    super.dispose();
  }

  Future<void> _sendVerificationCode() async {
    if (_formKey.currentState!.validate()) {
      try {
        await authController.forgotPassword(authController.emailreset.text.trim());

        // Navigate to verification screen only if API call succeeds
        Get.to(() => VerificationScreen(email: authController.emailreset.text.trim()));
      } catch (e) {
        // Error handling is already done in the controller
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'.tr),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter your email for the verification process. We will send a 4-digit code to your email.'.tr,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              CustomTextFormField(
                controller: authController.emailreset,
                hintText: 'Email'.tr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email'.tr;
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email'.tr;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Obx(() => SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      buttonStyle: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(Theme.of(context).primaryColor),
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                      ),
                      text: authController.isLoading.value ? 'Sending...'.tr : 'Send Code'.tr,
                      onPressed: authController.isLoading.value ? null : _sendVerificationCode,
                      buttonTextStyle: TextStyle(color: Colors.white),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
