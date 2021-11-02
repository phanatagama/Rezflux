// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rezflux_app/views/screens/detail_screen.dart';
import 'package:rezflux_app/views/screens/home_screen.dart';
import 'package:rezflux_app/views/screens/splash_screen.dart';
import 'package:rezflux_app/views/config/theme_config.dart';

void main() async {
  await GetStorage.init();
  runApp(GetMaterialApp(
    initialRoute: '/home',
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
    // theme: ThemeData(textTheme: GoogleFonts.nunitoTextTheme()),
    theme: Themes.light,
    darkTheme: Themes.dark,
    themeMode: ThemeService().theme,
    debugShowCheckedModeBanner: false,
  ));
}
