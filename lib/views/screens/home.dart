import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rezflux_app/controller/home.dart';
import 'package:rezflux_app/views/config/theme.dart';
import 'package:rezflux_app/views/widgets/restcard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State {
  final HomeController controller = Get.put(HomeController());
  bool isDark = Get.isDarkMode;

  int _cardConstraint(num maxWidth){
    if (maxWidth < 900) {
      return 2;
    } else if (maxWidth < 1200){
      return 3;
    } else {
      return 5;
    }
  }
  
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
                    Get.changeThemeMode(
                        value ? ThemeMode.dark : ThemeMode.light);
                    ThemeService().switchTheme();
                  });
                })
          ],
        ),
        body: controller.obx(
          (data) => LayoutBuilder(builder: (context, constraints) {
            return GridView.builder(
              itemCount: data.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: _cardConstraint(constraints.maxWidth)),
              itemBuilder: (context, index) {
                var details = data[index];
                return RestCard(
                    mode: context.theme.backgroundColor, restaurant: details);
              },
            );
          }),
          onEmpty: const Text("empty"),
          onLoading: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}
