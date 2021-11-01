import 'package:get/get.dart';
import 'package:rezflux_app/models/list_restaurant_model.dart';

class ApiProvider extends GetConnect {

  Future fetchRestaurants() async {
    final response = await get(
        'https://restaurant-api.dicoding.dev/list');
    if (response.status.hasError) {
      print("error status " + response.statusCode.toString());
      return Future.error(response.statusText.toString());
    } else {
      Restaurant data = Restaurant.fromJson(response.body);
      return data.restaurants;
    }
  }
}