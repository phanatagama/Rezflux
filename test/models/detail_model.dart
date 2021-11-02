import 'package:flutter_test/flutter_test.dart';
import 'package:rezflux_app/models/detail_model.dart';

var apiResponse = {
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
    "rating": 4,
    "customerReviews": [
      {
        "name": "Ahmad",
        "review": "Tidak rekomendasi untuk pelajar!",
        "date": "13 November 2019"
      }
    ]
  }
};

void main() {
  group('Testing Detail Restaurant Models', () {
    test('Detail model should be return a Map', () {
      Welcome data = Welcome.fromJson(apiResponse);
      expect(data.error, false);
      expect(data.message, "success");
    });
  });
}