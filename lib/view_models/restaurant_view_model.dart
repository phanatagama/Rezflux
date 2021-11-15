import 'package:get/get.dart';
import 'package:rezflux_app/models/detail_restaurant_model.dart';
import 'package:rezflux_app/models/list_restaurant_model.dart';

class ApiProvider extends GetConnect {
  String apiUrl = 'https://restaurant-api.dicoding.dev';
  Future fetchListRestaurants() async {
    final response = await get('$apiUrl/list');
    if (response.status.hasError) {
      print("error status " + response.statusCode.toString());
      print("error text " + response.statusText.toString());
      return Future.error(response.statusText.toString());
    } else {
      ListResponse data = ListResponse.fromJson(response.body);
      return data.restaurants;
    }
  }

  Future fetchDetailRestaurants(String parameter) async {
    final response = await get('$apiUrl/detail/$parameter');
    if (response.status.hasError) {
      print("error status " + response.statusCode.toString());
      print("error status " + response.statusText.toString());
      return Future.error(response.statusText.toString());
    } else {
      DetailResponse data = DetailResponse.fromJson(response.body);
      return [data.restaurant];
    }
  }
}
