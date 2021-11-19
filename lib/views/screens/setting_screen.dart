import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rezflux_app/controller/restaurant_controller.dart';
import 'package:rezflux_app/utils/notification_helper.dart';
import 'package:rezflux_app/views/config/theme_config.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rezflux_app/views/widgets/custom_dialog.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State {
  final RestaurantController controller =
      Get.find<RestaurantController>();
  bool isDark = Get.isDarkMode;
  final NotificationHelper _notificationHelper = NotificationHelper();
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _notificationHelper.configureSelectNotificationSubject();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    selectNotificationSubject.close();
    super.dispose();
  }

  /// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    /// Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print("Error : $e");
      return;
    }

    /// If the widget was removed from the tree while the asynchronous platform
    /// message was in flight, we want to discard the reply rather than calling
    /// setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Setting"),
        ),
        body: Obx(() {
            if (_connectionStatus == ConnectivityResult.wifi ||
                _connectionStatus == ConnectivityResult.mobile) {
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: EdgeInsets.all(16),
                      child: Text("Theme"),),Switch(
                        value: isDark,
                        onChanged: (bool value) {
                          setState(() {
                            isDark = value;
                            Get.changeThemeMode(
                                value ? ThemeMode.dark : ThemeMode.light);
                            ThemeService().switchTheme();
                          });
                        })],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(padding: EdgeInsets.all(16),
                        child: Text("Notification"),),Switch(
                          value: controller.isScheduled.value,
                          onChanged: (value) async {
                            if (Platform.isIOS) {
                              customDialog(context);
                            } else {
                              controller.scheduledNews(value);
                            }
                          })],
                  ),
                ],
              );
              // return Center(child:Text("Ini Setting"));
            } else {
              return Center(child: Text("No Internet Connection!"));
            }
        }));
  }
}
