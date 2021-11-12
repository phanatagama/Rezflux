import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rezflux_app/controller/restaurant_controller.dart';
import 'package:rezflux_app/models/detail_restaurant_model.dart';
import 'package:rezflux_app/views/widgets/detail_widget.dart';

class Detail extends GetView<RestaurantController> {
  @override
  Widget build(BuildContext context) {
    controller
        .restaurantGetDetail(Get.parameters['id'] ?? 'rqdv5juczeskfw1e867');
    return Scaffold(
        body: Obx(() {
          if (controller.isLoading.value) {
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
          } else {
            return DetailPage(
                dataRestaurant: controller.restaurantDetail[0] as Restaurant);
          }
        }),
        appBar: null);
  }
}
