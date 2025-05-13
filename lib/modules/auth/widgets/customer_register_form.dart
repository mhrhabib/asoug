import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../core/common/widgets/custom_checkbox_button.dart';
import '../../../core/common/widgets/custom_elevated_button.dart';
import '../../../core/common/widgets/custom_text_form_field.dart';
import '../controller/auth_controller.dart';

class CustomerRegisterForm extends StatelessWidget {
  CustomerRegisterForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomTextFormField(
                controller: authController.name,
                hintText: 'username'.tr,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomTextFormField(
                controller: authController.phone,
                hintText: 'mobile_number'.tr,
                textInputType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                    return 'Please enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 25),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF2F2F7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CustomTextFormField(
                controller: authController.regEmail,
                hintText: "email".tr,
                textInputType: TextInputType.emailAddress,
                suffix: const Icon(Icons.email_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
            ),
          ),
          _buildPassword(),
          _buildConfirmPassword(),
          Container(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Column(
              children: [
                _buildCheck(),
                const Gap(12),
                Obx(
                  () => CustomElevatedButton(
                    buttonStyle: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Theme.of(context).primaryColor),
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onPressed: authController.isLoading.value
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              if (authController.accountType.value.isNotEmpty) {
                                if (authController.isAgree.value) {
                                  authController.register();
                                } else {
                                  Get.snackbar(
                                    'Error',
                                    'Please agree to the terms and conditions',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white,
                                  );
                                }
                              } else {
                                Get.snackbar(
                                  'Error',
                                  'Please select an account type',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                              }
                            }
                          },
                    text: authController.isLoading.value ? 'Processing...' : 'register'.tr,
                    buttonTextStyle: const TextStyle(color: Colors.white),
                    width: MediaQuery.of(context).size.width * .80,
                  ),
                ),
                const Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('already_have_an_account'.tr),
                    const Gap(8),
                    InkWell(
                      onTap: () => Get.back(),
                      child: Text(
                        'sign_in'.tr,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          decorationColor: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCheck() {
    return Obx(
      () => CustomCheckboxButton(
        text: "msg_by_signing_up_you_re".tr,
        isExpandedText: false,
        value: authController.isAgree.value,
        onChange: (value) {
          authController.isAgree.value = value;
        },
      ),
    );
  }

  Widget _buildPassword() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 25),
        child: CustomTextFormField(
          controller: authController.password1,
          hintText: "password".tr,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          suffix: InkWell(
            onTap: authController.visibilityCheck1,
            child: Icon(
              authController.isVisible1.value ? Icons.visibility_off_outlined : Icons.visibility,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
          obscureText: authController.isVisible1.value,
        ),
      ),
    );
  }

  Widget _buildConfirmPassword() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 25),
        child: CustomTextFormField(
          controller: authController.confirmPassword,
          hintText: "confirm_password".tr,
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          obscureText: authController.isVisible2.value,
          suffix: InkWell(
            onTap: authController.visibilityCheck2,
            child: Icon(
              authController.isVisible2.value ? Icons.visibility_off_outlined : Icons.visibility,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != authController.password1.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
      ),
    );
  }
}
