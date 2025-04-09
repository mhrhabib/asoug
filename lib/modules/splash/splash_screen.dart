import 'package:asoug/modules/auth/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xffE8D2FF),
              Color(0xffE3ECFF),
            ],
          ),
        ),
        child: Center(
          child: InkWell(
            onTap: () {
              Get.to(() => SignInScreen());
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(
                  flex: 2,
                ),
                Image.asset('assets/logo.png'),
                Spacer(
                  flex: 2,
                ),
                Container(
                  height: 6,
                  width: MediaQuery.of(context).size.width * .80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xff670097),
                        Color(0xff50C0FF),
                      ],
                    ),
                  ),
                ),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
