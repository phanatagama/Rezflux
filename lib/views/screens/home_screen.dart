import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rezflux_app/controller/restaurant_controller.dart';
import 'package:rezflux_app/views/config/theme_config.dart';
import 'package:rezflux_app/views/widgets/restcard_widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State {
  final RestaurantController controller = Get.put(RestaurantController());
  bool isDark = Get.isDarkMode;
  Icon customIcon = const Icon(Icons.search);
  Widget customSearchBar = const Text("RezFlux");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: customSearchBar,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    customSearchBar = const ListTile(
                      leading: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                      title: TextField(
                        decoration: InputDecoration(
                          hintText: 'Cari Nama Restaurant',
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
            ),
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
          (data) => HomePage(data: data),
          onEmpty: const Text("empty"),
          onLoading: Center(
            child: CircularProgressIndicator(),
          ),
        ));
  }
}

class HomePage extends StatelessWidget {
  final data;
  
  HomePage({required this.data});
  
  int _cardConstraint(num maxWidth) {
    if (maxWidth < 600){
      return 1;
    } else if(maxWidth < 900) {
      return 2;
    } else if (maxWidth < 1200) {
      return 3;
    } else {
      return 5;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GridView.builder(
        itemCount: data?.length ?? 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _cardConstraint(constraints.maxWidth)),
        itemBuilder: (context, index) {
          var details = data[index];
          return RestCard(
            mode: context.theme.backgroundColor,
            restaurant: details,
          );
        },
      );
    });
  }

}
