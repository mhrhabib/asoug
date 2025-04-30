import 'package:asoug/modules/dashboard/dashboard_screen.dart';
import 'package:asoug/modules/home/screens/home_landing_screen.dart';
import 'package:asoug/modules/mediaCenter/media_center_screen.dart';
import 'package:asoug/modules/ourTeam/our_team_screen.dart';
import 'package:asoug/modules/supplier/supplier_list_screen.dart';
import 'package:asoug/modules/supplier/suppliers_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/helper/logout_helper.dart';

class HomeScreenWithDrawer extends StatelessWidget {
  const HomeScreenWithDrawer({super.key});

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
                  const Text(
                    'Soug Express',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
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
                    Get.to(() => HomeLandingScreen());
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
                  icon: Icons.help,
                  title: 'Help & Support',
                  onTap: () {
                    Navigator.pop(context);
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
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ),
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
