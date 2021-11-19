import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rezflux_app/controller/restaurant_controller.dart';
import 'package:rezflux_app/views/widgets/home_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State {
  final RestaurantController controller =
      Get.put<RestaurantController>(RestaurantController());
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text("RezFlux");
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
                  hintText: 'Cari Restaurant',
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
          ],
        ),
        body: Obx(() {
          if (controller.restaurantList.isEmpty) {
            if (_connectionStatus == ConnectivityResult.wifi ||
                _connectionStatus == ConnectivityResult.mobile) {
              return Center(
                child: Lottie.network(
                    'https://assets7.lottiefiles.com/packages/lf20_scgyykem.json'),
              );
            } else {
              return Center(child: Text("No Internet Connection!"));
            }
          } else {
            if (_connectionStatus == ConnectivityResult.wifi ||
                _connectionStatus == ConnectivityResult.mobile) {
              return HomePage(data: [...controller.restaurantList]);
            } else {
              return Center(child: Text("No Internet Connection!"));
            }
          }
        }));
  }
}
