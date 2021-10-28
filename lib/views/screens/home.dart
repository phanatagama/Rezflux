import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rezflux_app/view_models/listrestaurant.dart';
import 'package:rezflux_app/views/themes/theme.dart';
import 'package:rezflux_app/views/widgets/restcard.dart';

class HomeController extends GetxController with StateMixin {
  ApiProvider _apiProvider = ApiProvider();
  @override
  void onInit() {
    super.onInit();
    _apiProvider.fetchRestaurants().then((response) {
      change(response, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }
}

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State {
  final HomeController controller = Get.put(HomeController());
  bool isDark = Get.isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("RezFlux"),
          actions: [
            Switch(
                value: isDark,
                onChanged: (bool value) {
                  setState(() {
                    isDark = value;
                    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                    ThemeService().switchTheme();
                  });
                })
          ],
        ),
        body: controller.obx(
              (data) => GridView.builder(
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  var details = data[index];
                  return RestCard(
                      mode: context.theme.backgroundColor, restaurant: details);
                },
              ),
              onEmpty: const Text("empty"),
              onLoading: Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }
}


