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
            if (controller.restaurantTempList.isNotEmpty){
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
