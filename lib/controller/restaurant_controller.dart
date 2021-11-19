import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rezflux_app/utils/background_service.dart';
import 'package:rezflux_app/utils/datetime_helper.dart';
import 'package:rezflux_app/view_models/restaurant_view_model.dart';
import 'package:rezflux_app/views/config/favorite_config.dart';

class RestaurantController extends GetxController with StateMixin {
  ApiProvider _apiProvider = ApiProvider();
  TextEditingController searchController = TextEditingController();
  var restaurantList = [].obs;
  var restaurantTempList = [];
  var restaurantDetail = [].obs;
  var restaurantFav = [].obs;
  RxBool isLoading = true.obs;
  RxBool isScheduled = false.obs;

  @override
  void onInit() async {
    super.onInit();
    try {
      restaurantTempList = await _apiProvider.fetchListRestaurants();
    } catch (_) {
      restaurantTempList = [];
    }
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
    try {
      restaurantDetail.value = await _apiProvider.fetchDetailRestaurants(id);
      isLoading.value = false;
    } catch (_) {
      restaurantDetail.value = [];
    }
  }

  favoriteFilter() {
    List userFav = FavoriteService().favorite;
    List dataFav = [];
    for (final restaurant in restaurantTempList) {
      if (userFav.contains(restaurant.id)) {
        dataFav.add(restaurant);
      }
    }
    restaurantFav.value = dataFav;
  }

  Future<bool> scheduledNews(bool value) async {
    isScheduled.value = value;
    if (isScheduled.value) {
      print('Scheduling Activated');
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Canceled');
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
