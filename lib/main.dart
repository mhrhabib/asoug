import 'package:asoug/core/utils/storage.dart';
import 'package:asoug/localization/app_localization.dart';
import 'package:asoug/modules/splash/splash_screen.dart';
import 'package:asoug/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add this import
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Set status bar color for the entire app
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.purple, // Use your theme's primary color
      statusBarIconBrightness: Brightness.light, // For dark status bar background
      // OR use Brightness.dark for light status bar background
    ),
  );
  await LocalSettings().initialize();
  print('LocalSettings initialized');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.light,
      translations: AppLocalization(),
      locale: storage.read('local') != null && storage.read('local') == 1 ? const Locale('en', 'US') : const Locale('ar', 'AR'), //for setting localization strings
      fallbackLocale: const Locale('ar', 'AR'),
      home: SplashScreen(),
    );
  }
}
