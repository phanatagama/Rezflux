import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rezflux_app/view_models/restaurant_view_model.dart';

class RestaurantController extends GetxController with StateMixin {
  ApiProvider _apiProvider = ApiProvider();
  TextEditingController searchController = TextEditingController();
  var restaurantList = [].obs;
  var restaurantTempList = [];
  var restaurantDetail = [].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();
    restaurantTempList = await _apiProvider.fetchListRestaurants();
    restaurantList.value = restaurantTempList;
  }

  restaurantNameSearch(String name) {
    if (name.isEmpty) {
      restaurantList.value = restaurantTempList;
    } else {
      restaurantList.value = restaurantTempList
          .where((element) =>
              element.name.toLowerCase().contains(name.toLowerCase()))
          .toList();
    }
  }

  restaurantGetDetail(String id) async {
    isLoading.value = true;
    restaurantDetail.value = await _apiProvider.fetchDetailRestaurants(id);
    isLoading.value = false;
  }
}
