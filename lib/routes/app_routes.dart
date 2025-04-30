import 'package:get/get.dart';

import '../modules/auth/bindings/auth_bindings.dart';
import '../modules/auth/screens/sign_in_screen.dart';
import '../modules/splash/splash_screen.dart';

class AppRoutes {
  static const String initialRoutes = '/';
  static const String homeScreen = '/home-screen';
  static const String onBoardScreenOne = '/onboared-screen-one';
  static const String onBoardScreenTwo = '/onboared-screen-two';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String about = '/about-screen';
  static const String contactUs = '/contact-us-screen';
  static const String availableTruck = '/available-truck-screen';
  static const String blogScreen = '/blog-screen';
  static const String blogDetailsScreen = '/blog-details-screen';
  static const String profileScreen = '/profile-screen';
  static const String profileSettingScreen = '/profile-setting-screen';
  static const String serviceOrderScreen = '/Service-order-screen';
  static const String otpSendScreen = '/otp-send-screen';
  static const String verifyOtpScreen = '/verify-otp-screen';
  static const String equipmentScreen = '/equipment-screen';

  static List<GetPage> pages = [
    GetPage(
      name: initialRoutes,
      page: () => const SplashScreen(),
      bindings: [],
    ),
    GetPage(
      name: signIn,
      page: () => SignInScreen(),
      binding: AuthBinding(),
    ),
  ];
}
