import 'package:asoug/modules/dashboard/dashboard_screen.dart';
import 'package:asoug/modules/help&support/help_support_screen.dart';
import 'package:asoug/modules/main/main_screen.dart';
import 'package:asoug/modules/mediaCenter/media_center_screen.dart';
import 'package:asoug/modules/ourTeam/our_team_screen.dart';
import 'package:asoug/modules/products/featured_product_screen.dart';
import 'package:asoug/modules/products/product_list_screen.dart';
import 'package:asoug/modules/supplier/supplier_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/common/global/general_settings_controller.dart';
import '../../../core/helper/logout_helper.dart';
import '../../about/about_screen.dart';

class HomeScreenWithDrawer extends StatelessWidget {
  HomeScreenWithDrawer({super.key});
  final settingsController = Get.put(GeneralSettingsController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // Drawer Header with Logo
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/logo.png', // Replace with your logo
                    width: 100,
                    height: 90,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10),
                  Obx(() {
                    if (settingsController.isLoading.value) {
                      return CircularProgressIndicator();
                    } else {
                      return Text(
                        settingsController.settings.value.data?.appName ?? 'No App Name',
                        style: TextStyle(color: Colors.white),
                      );
                    }
                  })
                ],
              ),
            ),
          ),

          // Navigation Tiles
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerTile(
                  context,
                  icon: Icons.home,
                  title: 'Home',
                  onTap: () {
                    Get.to(() => MainScreen());
                    // Navigate to home if needed
                  },
                ),
                _buildDrawerTile(
                  context,
                  icon: Icons.dashboard_customize,
                  title: 'User Dashboad',
                  onTap: () {
                    Get.to(() => UserDashboardScreen());
                    // Navigate to products
                  },
                ),
                _buildDrawerTile(
                  context,
                  icon: Icons.shopping_cart_outlined,
                  title: 'Products',
                  onTap: () {
                    Get.to(() => ProductListScreen());
                    // Navigate to products
                  },
                ),
                _buildDrawerTile(
                  context,
                  icon: Icons.category,
                  title: 'Suppliers',
                  onTap: () {
                    Get.to(() => SupplierListScreen());
                    // Navigate to categories
                  },
                ),
                _buildDrawerTile(
                  context,
                  icon: Icons.favorite,
                  title: 'Favorites',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to favorites
                  },
                ),
                _buildDrawerTile(
                  context,
                  icon: Icons.person,
                  title: 'Profile',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to profile
                  },
                ),
                _buildDrawerTile(
                  context,
                  icon: Icons.featured_video_sharp,
                  title: 'Feature Products',
                  onTap: () {
                    Get.to(() => FeaturedProductScreen());
                    // Navigate to products
                  },
                ),
                const Divider(),
                _buildDrawerTile(
                  context,
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to settings
                  },
                ),
                _buildDrawerTile(
                  context,
                  icon: Icons.group_add_sharp,
                  title: 'Our Team',
                  onTap: () {
                    Get.to(() => OurTeamScreen());
                    // Navigate to help
                  },
                ),
                _buildDrawerTile(
                  context,
                  icon: Icons.perm_media_outlined,
                  title: 'Media Center',
                  onTap: () {
                    Get.to(() => MediaCenterScreen());
                    // Navigate to help
                  },
                ),
                _buildDrawerTile(
                  context,
                  icon: Icons.info_outline,
                  title: 'About Us',
                  onTap: () {
                    Get.to(() => AboutScreen());
                    // Navigate to help
                  },
                ),
                _buildDrawerTile(
                  context,
                  icon: Icons.help,
                  title: 'hlp & support',
                  onTap: () {
                    Get.to(() => HelpSupportScreen());
                    // Navigate to help
                  },
                ),
                _buildDrawerTile(
                  context,
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () => LogoutHelper.logout(context),
                ),
              ],
            ),
          ),

          // Footer with version info
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Obx(() {
                if (settingsController.isLoading.value) {
                  return CircularProgressIndicator();
                } else {
                  return Text(
                    "App Version ${settingsController.settings.value.data?.appVersion}",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  );
                }
              })),
        ],
      ),
    );
  }

  Widget _buildDrawerTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(title),
      onTap: onTap,
    );
  }
}
