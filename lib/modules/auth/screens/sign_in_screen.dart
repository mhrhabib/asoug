import 'package:asoug/core/common/widgets/custom_image_view.dart';
import 'package:asoug/core/utils/image_constant.dart';
import 'package:asoug/core/utils/storage.dart';
import 'package:asoug/modules/home/controllers/service_controller.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/auth_controller.dart';
import '../forgotPassword/forgot_password_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final AuthController controller = Get.put(AuthController());
  final ServicesController servicesController = Get.put(ServicesController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Header with back button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildBackButton(context),
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
                  _buildLogo(context),
                  const Gap(16),

                  // Title
                  _buildTitle(context),
                  const Gap(16),

                  // Form Fields
                  _buildEmailField(context),
                  const Gap(16),
                  _buildPasswordField(context),
                  const Gap(8),

                  // Remember me & Forgot password
                  _buildRememberForgotRow(context),
                  const Gap(8),

                  // Login Button
                  _buildLoginButton(context),
                  const Gap(16),

                  TextButton(
                    onPressed: () => Get.to(() => ForgotPasswordScreen()),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      'Forgot Password?',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),

                  // Divider
                  _buildOrDivider(context),
                  const Gap(16),

                  // Sign Up Button
                  _buildSignUpButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'backButton',
      onPressed: () => Get.back(),
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.surface,
      mini: true,
      child: Icon(
        Icons.arrow_back_rounded,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Container(
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
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: CustomImageView(
            imagePath: ImageConstant.logo,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome Back',
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const Gap(8),
        Text(
          'Sign in to continue',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email Address',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        const Gap(8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller.email,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            decoration: InputDecoration(
              hintText: 'your@email.com',
              hintStyle: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
              ),
              prefixIcon: Icon(
                Icons.email_rounded,
                color: Theme.of(context).colorScheme.primary,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            ),
            validator: (value) {
              if (value!.isEmpty) return "Please enter your email";
              if (!GetUtils.isEmail(value)) return "Please enter a valid email";
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
          ),
        ),
        const Gap(8),
        Obx(() => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextFormField(
                controller: controller.password,
                obscureText: !controller.isVisible.value,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: '••••••••',
                  hintStyle: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                    letterSpacing: 2,
                  ),
                  prefixIcon: Icon(
                    Icons.lock_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isVisible.value ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
                    ),
                    onPressed: controller.toggleVisibility,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                ),
                validator: (value) {
                  if (value!.isEmpty) return "Please enter your password";
                  if (value.length < 6) return "Password must be at least 6 characters";
                  return null;
                },
              ),
            )),
      ],
    );
  }

  Widget _buildRememberForgotRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Transform.scale(
              scale: 0.9,
              child: Checkbox(
                value: true,
                onChanged: (val) {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.2),
                ),
                activeColor: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Gap(4),
            Text(
              'Remember me',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return Obx(() => SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: controller.isLoading.value
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      controller.login();
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
            child: controller.isLoading.value
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    'Sign In',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ));
  }

  Widget _buildOrDivider(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OR',
            style: GoogleFonts.poppins(
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton(
        onPressed: () => Get.to(() => SignUpScreen()),
        style: OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary,
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          'Create New Account',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
