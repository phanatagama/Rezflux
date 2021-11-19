import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rezflux_app/controller/restaurant_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rezflux_app/views/widgets/home_widget.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State {
  final RestaurantController controller =
  Get.find<RestaurantController>();
  bool isDark = Get.isDarkMode;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
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

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print("Error : $e");
      return;
    }

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
    controller.favoriteFilter();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Favorite"),
        ),
        body: Obx(() {
          if (controller.restaurantFav.isEmpty) {
            if (_connectionStatus == ConnectivityResult.wifi ||
                _connectionStatus == ConnectivityResult.mobile) {
              return Center(
                child: Lottie.network(
                    'https://assets3.lottiefiles.com/packages/lf20_fp7svyno.json'),
              );
            } else {
              return Center(child: Text("No Internet Connection!"));
            }
          } else {
            if (_connectionStatus == ConnectivityResult.wifi ||
                _connectionStatus == ConnectivityResult.mobile) {
              return HomePage(data: controller.restaurantFav);
            } else {
              return Center(child: Text("No Internet Connection!"));
            }
          }
        }));
  }
}
