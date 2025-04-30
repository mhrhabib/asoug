import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/auth/controller/auth_controller.dart';

class LogoutHelper {
  static Future<void> logout(BuildContext context) async {
    final authController = Get.put(AuthController());

    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Logout'.tr),
        content: Text('Are you sure you want to logout?'.tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'.tr),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              'Logout'.tr,
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      // Perform logout
      await authController.logout();

      // Dismiss loading indicator (if still mounted)
      if (context.mounted) {
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    }
  }
}
