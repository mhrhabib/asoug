import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.skey});

  final GlobalKey<ScaffoldState> skey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: theme.primaryColor,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: theme.primaryColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      leading: Padding(
        padding: const EdgeInsets.only(left: 4.0, right: 0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.9),
                Colors.white.withValues(alpha: 0.8),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      title: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: CupertinoSearchTextField(
          placeholderStyle: TextStyle(
            color: Colors.white.withValues(alpha: 0.7),
          ),
          style: TextStyle(color: Colors.white),
          prefixIcon: Icon(
            CupertinoIcons.search,
            color: Colors.white.withValues(alpha: 0.7),
          ),
          suffixIcon: Icon(
            CupertinoIcons.xmark_circle_fill,
            color: Colors.white.withValues(alpha: 0.7),
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.transparent),
          ),
        ),
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.primaryColor.withValues(alpha: 0.4),
                theme.primaryColor.withValues(alpha: 0.8),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => skey.currentState!.openDrawer(),
          ),
        ),
        const Gap(12),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10); // Slightly taller
}
