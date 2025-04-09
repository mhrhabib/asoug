import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../core/common/widgets/custom_checkbox_button.dart';
import '../../../core/common/widgets/custom_elevated_button.dart';
import '../../../core/common/widgets/custom_snackbar.dart';
import '../../../core/common/widgets/custom_text_form_field.dart';
import '../../../core/common/widgets/validation_function.dart';
import '../controller/auth_controller.dart';

class CustomerRegisterForm extends StatefulWidget {
  CustomerRegisterForm({super.key});

  @override
  State<CustomerRegisterForm> createState() => _CustomerRegisterFormState();
}

class _CustomerRegisterFormState extends State<CustomerRegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final authController = Get.put(AuthController());

  // final globalController = Get.put(GlobalController());

  String? selectedValue;

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
                controller: authController.email,
                hintText: "email".tr,
                suffix: Icon(Icons.email_outlined),
              ),
            ),
          ),
          // Container(
          //   margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
          //   child: Obx(
          //     () => globalController.countyLoader.value
          //         ? SpinKitCircle(
          //             color: Theme.of(context).primaryColor,
          //           )
          //         : CustomDropdown(
          //             onChanged: (value) {
          //               var country = globalController.countryList.firstWhere((element) => (isLocaleEng ? element.name! : element.nameAr) == value);
          //               authController.country.value = country.id!;
          //             },
          //             labelText: "country".tr,
          //             hintText: 'country'.tr,
          //             value: selectedValue,
          //             items: globalController.countryList.map((element) => isLocaleEng ? element.name! : element.nameAr!).toList(),
          //           ),
          //   ),
          // ),
          _buildPassword(),
          _buildConfirmPassword(),
          Container(
            padding: EdgeInsets.only(left: 12, right: 12),
            child: Column(
              children: [
                _buildCheck(),
                Gap(12),
                CustomElevatedButton(
                  buttonStyle: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Theme.of(context).primaryColor),
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (authController.type.value != '') {
                        if (authController.isAgree.value == true) {
                          authController.signup();
                        } else {
                          CustomSnackBar.showCustomErrorToast(title: "Error", message: 'error_agree_terms'.tr);
                        }
                      } else {
                        CustomSnackBar.showCustomErrorToast(title: "Error", message: 'error_select_account_type'.tr);
                      }
                    }
                  },
                  text: 'register'.tr,
                  buttonTextStyle: const TextStyle(color: Colors.white),
                  width: MediaQuery.of(context).size.width * .80,
                ),
                Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('already_have_an_account'.tr),
                    Gap(8),
                    InkWell(
                      onTap: () {
                        //Get.toNamed(AppRoutes.signIn);
                      },
                      child: Text(
                        'sign_in'.tr,
                        style: TextStyle(
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
            if (authController.isAgree.value == true) {
              authController.agreedText.value = "yes";
            } else {
              authController.agreedText.value = 'no';
            }
          }),
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
            onTap: () {
              authController.visibilityCheck1();
              print(authController.isVisible1.value);
            },
            child: Icon(
              authController.isVisible1.value ? Icons.visibility_off_outlined : Icons.visibility,
            ),
          ),
          validator: (value) {
            if (value == null || (!isValidPassword(value, isRequired: true))) {
              return "err_msg_please_enter_valid_password".tr;
            }
            return null;
          },
          obscureText: authController.isVisible1.value ? true : false,
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
          obscureText: authController.isVisible2.value ? true : false,
          suffix: InkWell(
            onTap: () {
              authController.visibilityCheck2();
              print(authController.isVisible.value);
            },
            child: Icon(
              authController.isVisible2.value ? Icons.visibility_off_outlined : Icons.visibility,
            ),
          ),
          validator: (value) {
            if (value == null || (!isValidPassword(value, isRequired: true))) {
              return "err_msg_please_enter_valid_password".tr;
            }
            return null;
          },
        ),
      ),
    );
  }
}
