import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rezflux_app/views/themes/theme.dart';
import 'package:rezflux_app/views/widgets/restcard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RezFlux"),
        actions: [
          Switch(
              value: Get.isDarkMode,
              onChanged: (bool value) {
                Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
                ThemeService().switchTheme();
              })
        ],
      ),
      body: GridView(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            children: <Widget>[
              RestCard(mode: context.theme.backgroundColor),
              RestCard(mode: context.theme.backgroundColor),
              RestCard(mode: context.theme.backgroundColor),
              RestCard(mode: context.theme.backgroundColor),
            ],
          ),
    );
  }
}
