
import 'dart:io';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rezflux_app/utils/background_service.dart';
import 'package:rezflux_app/utils/notification_helper.dart';
import 'package:rezflux_app/views/screens/detail_screen.dart';
import 'package:rezflux_app/views/screens/home_screen.dart';
import 'package:rezflux_app/views/screens/splash_screen.dart';
import 'package:rezflux_app/views/config/theme_config.dart';

import 'common/navigation.dart';

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port) {
//         String _localPem = 'CERTIFICATE_STRING';
//         if (_localPem == cert.pem)
//           return true;
//         else
//           return false;
//       };
//   }
// }
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  // HttpOverrides.global = new MyHttpOverrides();
  await GetStorage.init();
  runApp(GetMaterialApp(
    navigatorKey: navigatorKey,
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
