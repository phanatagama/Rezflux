import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rezflux_app/controller/restaurant_controller.dart';
import 'package:rezflux_app/views/widgets/restcard_widget.dart';

class HomePage extends GetView<RestaurantController> {
  final data;

  HomePage({required this.data});

  int _cardConstraint(num maxWidth) {
    if (maxWidth < 600) {
      return 1;
    } else if (maxWidth < 900) {
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
