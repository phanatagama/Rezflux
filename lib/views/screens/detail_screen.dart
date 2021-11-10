
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rezflux_app/controller/restaurant_controller.dart';
import 'package:rezflux_app/views/widgets/detail_widget.dart';

class Detail extends StatelessWidget {
  RestaurantController controller  = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: controller.obx(
          (data) => DetailPage(data: data, id: Get.parameters['id'] ?? 'rqdv5juczeskfw1e867'),
          onEmpty: const Text("empty"),
          onLoading: Center(
            child: CircularProgressIndicator(),
          ),
          onError: (error) => Text("Error $error"),
        ),
        appBar: null);
  }
}
