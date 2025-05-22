import 'package:asoug/core/utils/storage.dart';
import 'package:asoug/modules/auth/screens/sign_in_screen.dart';
import 'package:asoug/modules/home/screens/home_landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.microtask(() {
      // Simulate a delay for the splash screen
      if (storage.read('token') != null) {
        // If the user is already logged in, navigate to the home screen
        print('token: ${storage.read('token')}');
        Get.off((() => const HomeLandingScreen()));
      } else {
        // If the user is not logged in, navigate to the sign-in screen
        Get.offAll(() => SignInScreen());
      }
    });
    super.initState();
  }

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(
                    color: Color(0xff670097),
                    backgroundColor: Color(0xff50C0FF),
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                // Container(
                //   height: 6,
                //   width: MediaQuery.of(context).size.width * .80,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(12),
                //     gradient: LinearGradient(
                //       begin: Alignment.centerLeft,
                //       end: Alignment.centerRight,
                //       colors: [
                //         Color(0xff670097),
                //         Color(0xff50C0FF),
                //       ],
                //     ),
                //   ),
                // ),
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
