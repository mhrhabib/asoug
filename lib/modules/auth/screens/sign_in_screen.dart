import 'package:asoug/modules/auth/forgotPassword/forgot_password_screen.dart';
import 'package:asoug/modules/auth/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/common/widgets/custom_elevated_button.dart';
import '../../../core/common/widgets/custom_image_view.dart';
import '../../../core/common/widgets/custom_text_form_field.dart';
import '../../../core/utils/image_constant.dart';
import '../controller/auth_controller.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final AuthController controller = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 56),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 23),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: InkWell(onTap: () => Get.back(), child: Icon(Icons.arrow_back)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: CustomImageView(
                        imagePath: ImageConstant.logo,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0.1, 35),
                    child: Text(
                      'Login into Asoug Platform'.tr,
                      style: GoogleFonts.getFont(
                        'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: const Color(0xFF390056),
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
                        hintText: 'username_email'.tr,
                        controller: controller.email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "username_empty_error".tr;
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
                      child: Obx(
                        () => CustomTextFormField(
                          hintText: "password".tr,
                          obscureText: controller.isVisible.value ? true : false,
                          controller: controller.password,
                          suffix: InkWell(
                            onTap: () {
                              controller.toggleVisibility();
                              print(controller.isVisible.value);
                            },
                            child: Icon(
                              controller.isVisible.value ? Icons.visibility_off_outlined : Icons.visibility,
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "password_empty_error".tr;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(16, 0, 16, 27),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Checkbox(value: true, onChanged: (val) {}),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 0.5, 0, 0.5),
                            child: Text(
                              'remember_password'.tr,
                              style: GoogleFonts.getFont(
                                'Inter',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: const Color(0xFF2A2424),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(
                    () => CustomElevatedButton(
                      buttonStyle: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(Theme.of(context).primaryColor),
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                      ),
                      text: controller.isLoading.value ? 'loading.....'.tr : 'login'.tr,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          controller.login();
                        }
                      },
                      buttonTextStyle: const TextStyle(color: Colors.white),
                      width: MediaQuery.of(context).size.width * .80,
                    ),
                  ),
                  Gap(12),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: InkWell(
                      onTap: () {
                        Get.to(() => ForgotPasswordScreen());
                      },
                      child: Text(
                        'forget_password'.tr,
                        style: GoogleFonts.getFont(
                          'Inter',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          color: const Color(0xFF2A2424),
                          decorationColor: const Color(0xFF2A2424),
                        ),
                      ),
                    ),
                  ),
                  OutlinedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStatePropertyAll<Size>(Size(MediaQuery.of(context).size.width * .80, 55)),
                        shape: WidgetStatePropertyAll<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )),
                      ),
                      onPressed: () {
                        Get.to(() => SignUpScreen());
                      },
                      child: Text('sign_up'.tr)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
