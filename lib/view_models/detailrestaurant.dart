import 'package:get/get.dart';
import 'package:rezflux_app/models/detail.dart';

class ApiProvider extends GetConnect {

  Future fetchDetailRestaurants(String parameter) async {
    final response = await get(
        'https://restaurant-api.dicoding.dev/detail/$parameter');
    if (response.status.hasError) {
      print("error status " + response.statusCode.toString());
      return Future.error(response.statusText.toString());
    } else {
      Welcome data = Welcome.fromJson(response.body);
      return data.restaurant;
    }
  }
}