import 'package:get/get.dart';
import 'package:rezflux_app/models/detail_restaurant_model.dart';
import 'package:rezflux_app/models/list_restaurant_model.dart';

var dummy ={
  "error": false,
  "message": "success",
  "count": 20,
  "restaurants": [
    {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2
    },
    {
      "id": "s1knt6za9kkfw1e867",
      "name": "Kafe Kita",
      "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
      "pictureId": "25",
      "city": "Gorontalo",
      "rating": 4
    }
  ]
};
var detail = {
  "error": false,
  "message": "success",
  "restaurant": {
    "id": "rqdv5juczeskfw1e867",
    "name": "Melting Pot",
    "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
    "city": "Medan",
    "address": "Jln. Pandeglang no 19",
    "pictureId": "14",
    "categories": [
      {
        "name": "Italia"
      },
      {
        "name": "Modern"
      }
    ],
    "menus": {
      "foods": [
        {
          "name": "Paket rosemary"
        },
        {
          "name": "Toastie salmon"
        }
      ],
      "drinks": [
        {
          "name": "Es krim"
        },
        {
          "name": "Sirup"
        }
      ]
    },
    "rating": 4.2,
    "customerReviews": [
      {
        "name": "Ahmad",
        "review": "Tidak rekomendasi untuk pelajar!",
        "date": "13 November 2019"
      }
    ]
  }
};
class ApiProvider extends GetConnect {
  String apiUrl = 'https://restaurant-api.dicoding.dev';
  Future fetchListRestaurants() async {
  //   final response = await get('$apiUrl/list');
  //   if (response.status.hasError) {
  //     print("error status " + response.statusCode.toString());
  //     return Future.error(response.statusText.toString());
  //   } else {
  //     ListResponse data = ListResponse.fromJson(response.body);
  //     return data.restaurants;
  //   }
    ListResponse data = ListResponse.fromJson(dummy);
    return data.restaurants;
  }
  Future fetchListRestaurants2() async {
    // final response = await get('$apiUrl/list');
    // if (response.status.hasError) {
    //   print("error status " + response.statusCode.toString());
    //   return Future.error(response.statusText.toString());
    // } else {
    //   ListResponse data = ListResponse.fromJson(dummy);
    //   return data;
    // }
    ListResponse data = ListResponse.fromJson(dummy);
    return data;
  }

  Future fetchDetailRestaurants(String parameter) async {
    // final response = await get('$apiUrl/detail/$parameter');
    // if (response.status.hasError) {
    //   print("error status " + response.statusCode.toString());
    //   return Future.error(response.statusText.toString());
    // } else {
    //   DetailResponse data = DetailResponse.fromJson(response.body);
    //   return [data.restaurant];
    // }
    DetailResponse data = DetailResponse.fromJson(detail);
    return [data.restaurant];
  }
}
