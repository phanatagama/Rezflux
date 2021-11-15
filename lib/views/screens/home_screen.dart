import 'dart:async';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rezflux_app/controller/restaurant_controller.dart';
import 'package:rezflux_app/views/config/theme_config.dart';
import 'package:rezflux_app/views/widgets/home_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State {
  final RestaurantController controller =
      Get.put<RestaurantController>(RestaurantController());
  bool isDark = Get.isDarkMode;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text("RezFlux");
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  Widget _searchBar() {
    return IconButton(
      onPressed: () {
        setState(() {
          if (customIcon.icon == Icons.search) {
            // Perform set of instructions.
            customIcon = const Icon(Icons.cancel);
            customSearchBar = ListTile(
              leading: Icon(
                Icons.search,
                color: Colors.white,
                size: 28,
              ),
              title: TextField(
                controller: controller.searchController,
                onChanged: (query) {
                  controller.restaurantNameSearch(query);
                },
                decoration: InputDecoration(
                  hintText: 'Cari Restoran',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          } else {
            customIcon = const Icon(Icons.search);
            customSearchBar = const Text("RezFlux");
          }
        });
      },
      icon: customIcon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: customSearchBar,
          actions: [
            _searchBar(),
            Switch(
                value: isDark,
                onChanged: (bool value) {
                  setState(() {
                    isDark = value;
                    Get.changeThemeMode(
                        value ? ThemeMode.dark : ThemeMode.light);
                    ThemeService().switchTheme();
                  });
                })
          ],
        ),
        body: Obx(() {
          if (controller.restaurantList.isEmpty) {
            if (_connectionStatus == 'ConnectivityResult.wifi' || _connectionStatus == 'ConnectivityResult.mobile'){
              return Center(
                child: Lottie.network(
                    'https://assets7.lottiefiles.com/packages/lf20_scgyykem.json'),
              );
            } else {
              return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 16,
                      ),
                      Text("Check Your Connection!")
                    ],
                  ));
            }
          } else {
            return HomePage(data: [...controller.restaurantList]);
          }
        }));
  }
}
