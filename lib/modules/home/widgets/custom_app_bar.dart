import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.skey});

  final GlobalKey<ScaffoldState> skey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset('assets/logo.png'),
      ),
      title: const CupertinoSearchTextField(),
      actions: [
        InkWell(
            onTap: () {
              skey.currentState!.openDrawer();
            },
            child: Icon(Icons.menu)),
        Gap(12),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
