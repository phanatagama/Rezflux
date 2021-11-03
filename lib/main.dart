// @dart=2.9
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rezflux_app/views/screens/detail_screen.dart';
import 'package:rezflux_app/views/screens/home_screen.dart';
import 'package:rezflux_app/views/screens/splash_screen.dart';
import 'package:rezflux_app/views/config/theme_config.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        // Load the local file
        String _localPem = 'CERTIFICATE_STRING';
        // Check the certificate
        if (_localPem == cert.pem)
          return true;
        else
          return false;
      };
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new MyHttpOverrides();
  await GetStorage.init();
  runApp(GetMaterialApp(
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => SplashPage()),
      GetPage(
        name: '/home',
        page: () => Home(),
        transition: Transition.zoom,
      ),
      GetPage(
        name: '/detail/:id',
        page: () => Detail(),
        transition: Transition.rightToLeftWithFade,
      )
    ],
    theme: Themes.light,
    darkTheme: Themes.dark,
    themeMode: ThemeService().theme,
    debugShowCheckedModeBanner: false,
  ));
}
