import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/common/widgets/custom_image_view.dart';
import '../../../core/utils/image_constant.dart';
import '../../../core/utils/storage.dart';
import '../controller/auth_controller.dart';
import '../widgets/customer_register_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final registrationAccountList = const [
    'Wholesaler',
    'Company',
    'Both',
  ];

  String? selectedAccountType;
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    print(storage.read('local'));
    print(isLocaleEng);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: CustomImageView(
                      imagePath: ImageConstant.logo,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 0.1, 20),
                  child: Text(
                    'Welcome to Asoug Platform'.tr,
                    style: GoogleFonts.getFont(
                      'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: const Color(0xFF390056),
                    ),
                  ),
                ),
                const Gap(12),
                Align(
                  alignment: isLocaleEng ? Alignment.centerLeft : Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "I'm".tr,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const Gap(12),
                OverflowBar(
                  children: registrationAccountList.map((accountType) {
                    return RadioListTile<String>(
                      title: Text(
                        accountType.tr, // Localized account type
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: accountType,
                      groupValue: selectedAccountType,
                      onChanged: (value) {
                        setState(() {
                          selectedAccountType = value;
                          authController.type.value = selectedAccountType!;
                        });
                      },
                    );
                  }).toList(),
                ),
                const Gap(16),
                CustomerRegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
