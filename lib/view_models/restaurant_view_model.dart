import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rezflux_app/models/restaurant_model.dart';


class ApiProvider extends GetConnect {
  // late var dataRestaurant;
  Future fetchRestaurants() async {
    final response = await rootBundle.loadString('assets/restaurants.json');
    if (response == null) {
      print("error status ");
      return Future.error("404");
    } else {
      Welcome data = Welcome.fromJson(jsonDecode(response));
      // dataRestaurant = data.restaurants;
      return data.restaurants;
    }
  }

  // search(String id){
  //   return dataRestaurant.where((restaurant) => restaurant.id == id).toList();
  // }
}