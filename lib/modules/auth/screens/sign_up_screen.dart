import 'package:asoug/core/utils/storage.dart';
import 'package:asoug/modules/home/controllers/service_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/common/widgets/custom_image_view.dart';
import '../../../core/utils/image_constant.dart';
import '../controller/auth_controller.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final registrationAccountList = const ['Buyer', 'Seller', 'Both'];
  final authController = Get.put(AuthController());
  final servicesController = Get.put(ServicesController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                // Back button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FloatingActionButton(
                      heroTag: 'signUpBackButton',
                      onPressed: () => Get.back(),
                      elevation: 0,
                      backgroundColor: theme.colorScheme.surface,
                      mini: true,
                      child: Icon(
                        Icons.arrow_back_rounded,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Get.theme.colorScheme.primary,
                        side: BorderSide(
                          color: Get.theme.colorScheme.primary,
                          width: 0.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        isLocaleEng ? 'English' : 'عربي',
                        style: TextStyle(
                          color: Get.theme.colorScheme.primary,
                          fontSize: 16,
                        ),
                      ),
                      onPressed: () => servicesController.buildDialog(context),
                    ),
                  ],
                ),
                const Gap(12),

                // Logo
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: theme.colorScheme.surface,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: CustomImageView(
                        imagePath: ImageConstant.logo,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const Gap(12),

                // Title
                Column(
                  children: [
                    Text(
                      'Create Account',
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      'Join our platform today',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                const Gap(12),

                // Account Type Selector
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "I'm".tr,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                const Gap(12),

                // Neumorphic Account Type Selector
                Container(
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: theme.colorScheme.surface,
                    boxShadow: [
                      BoxShadow(
                        color: isDark ? Colors.black.withValues(alpha: 0.6) : Colors.white.withValues(alpha: 0.8),
                        offset: const Offset(-4, -4),
                        blurRadius: 8,
                      ),
                      BoxShadow(
                        color: isDark ? Colors.grey.shade900 : Colors.grey.shade500,
                        offset: const Offset(4, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Obx(
                    () => SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: registrationAccountList.map((accountType) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: ChoiceChip(
                              label: Text(
                                accountType.tr,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: authController.accountType.value == accountType ? Colors.white : theme.colorScheme.onSurface,
                                ),
                              ),
                              selected: authController.accountType.value == accountType,
                              onSelected: (selected) {
                                authController.accountType.value = accountType;
                              },
                              selectedColor: theme.colorScheme.primary,
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              showCheckmark: false,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const Gap(32),

                // Registration Form
                NeumorphicRegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NeumorphicRegisterForm extends StatelessWidget {
  NeumorphicRegisterForm({super.key});

  final _formKey = GlobalKey<FormState>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Username Field
          _buildLabel('Username'),
          const Gap(8),
          _buildTextField(
            controller: authController.name,
            hintText: 'lbl_username'.tr,
            prefixIcon: Icons.person_outline_rounded,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter your name';
              return null;
            },
          ),
          const Gap(12),

          // Phone Field
          _buildLabel('Mobile Number'),
          const Gap(8),
          _buildTextField(
            controller: authController.phone,
            hintText: 'lbl_mobile'.tr,
            prefixIcon: Icons.phone_rounded,
            keyboardType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter your phone';
              if (!RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                return 'Please enter a valid 10-digit number';
              }
              return null;
            },
          ),
          const Gap(12),

          // Email Field
          _buildLabel('Email'),
          const Gap(8),
          _buildTextField(
            controller: authController.regEmail,
            hintText: 'lbl_email'.tr,
            prefixIcon: Icons.email_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter your email';
              if (!GetUtils.isEmail(value)) return 'Please enter a valid email';
              return null;
            },
          ),
          const Gap(12),

          // Password Field
          _buildLabel('Password'),
          const Gap(8),
          _buildPasswordField(
            controller: authController.password1,
            isVisible: authController.isVisible1.value,
            onToggleVisibility: authController.visibilityCheck1,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please enter password';
              if (value.length < 6) return 'Must be at least 6 characters';
              return null;
            },
          ),
          const Gap(12),

          // Confirm Password Field
          _buildLabel('Confirm Password'),
          const Gap(8),
          _buildPasswordField(
            controller: authController.confirmPassword,
            isVisible: authController.isVisible2.value,
            onToggleVisibility: authController.visibilityCheck2,
            validator: (value) {
              if (value == null || value.isEmpty) return 'Please confirm password';
              if (value != authController.password1.text) return 'Passwords don\'t match';
              return null;
            },
          ),
          const Gap(12),

          // Terms Checkbox
          _buildTermsCheckbox(),
          const Gap(16),

          // Register Button
          _buildRegisterButton(context),
          const Gap(12),

          // Already have account
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'msg_already_have_an'.tr,
                style: GoogleFonts.poppins(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const Gap(8),
              TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  'lbl_sign_in'.tr,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: Theme.of(Get.context!).colorScheme.onSurface.withValues(alpha: 0.8),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    required FormFieldValidator<String> validator,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Theme.of(Get.context!).colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            color: Theme.of(Get.context!).colorScheme.onSurface.withValues(alpha: 0.4),
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Theme.of(Get.context!).colorScheme.primary,
          ),
          filled: true,
          fillColor: Theme.of(Get.context!).colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
    required FormFieldValidator<String> validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: !isVisible,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Theme.of(Get.context!).colorScheme.onSurface,
        ),
        decoration: InputDecoration(
          hintText: '••••••••',
          hintStyle: GoogleFonts.poppins(
            color: Theme.of(Get.context!).colorScheme.onSurface.withValues(alpha: 0.4),
            letterSpacing: 2,
          ),
          prefixIcon: Icon(
            Icons.lock_rounded,
            color: Theme.of(Get.context!).colorScheme.primary,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              isVisible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
              color: Theme.of(Get.context!).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            onPressed: onToggleVisibility,
          ),
          filled: true,
          fillColor: Theme.of(Get.context!).colorScheme.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildTermsCheckbox() {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Theme.of(Get.context!).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 6,
                  offset: const Offset(2, 2),
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: 0.8),
                  blurRadius: 6,
                  offset: const Offset(-2, -2),
                ),
              ],
            ),
            child: Checkbox(
              value: authController.isAgree.value,
              onChanged: (value) => authController.isAgree.value = value ?? false,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              activeColor: Theme.of(Get.context!).colorScheme.primary,
              side: BorderSide(
                color: Theme.of(Get.context!).colorScheme.onSurface.withValues(alpha: 0.2),
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                  color: Theme.of(Get.context!).colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                children: [
                  const TextSpan(text: 'By signing up, you agree to our '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      color: Theme.of(Get.context!).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      color: Theme.of(Get.context!).colorScheme.primary,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
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
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            shadowColor: Colors.transparent,
          ),
          child: authController.isLoading.value
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text(
                  'Create Account',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
