import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:rezflux_app/common/navigation.dart';
import 'package:rezflux_app/models/list_restaurant_model.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();
Random random = new Random();

class NotificationHelper {
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      List<Restaurants> resto) async {
    int randInt = random.nextInt(resto.length);
    var _channelId = "1";
    var _channelName = "channel_01";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    var titleNotification = "<b>Coba Restaurant Ini</b>";
    var titleNotif = resto[randInt].name;

    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleNotif, platformChannelSpecifics,
        payload: json.encode(resto[randInt].toJson()));
  }

  void configureSelectNotificationSubject() {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = Restaurants.fromJson(json.decode(payload));
        Navigation.intentWithData(
            '/detail/${data.id}', Get.isDarkMode ? Colors.black : Colors.white);
      },
    );
  }
}
