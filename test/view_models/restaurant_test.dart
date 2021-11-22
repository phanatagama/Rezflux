import 'package:flutter_test/flutter_test.dart';
import 'package:rezflux_app/models/detail_restaurant_model.dart';
import 'package:rezflux_app/models/list_restaurant_model.dart';

var listResponse = {
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

var detailResponse = {
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
  group('Testing JSON Parse', () {
    test('data.message should be success', () {
      ListResponse data = ListResponse.fromJson(listResponse);
      expect(data.error, false);
      expect(data.message, "success");
      expect(data.count, 20);
    });
    test('data.message should be success', () {
      DetailResponse data = DetailResponse.fromJson(detailResponse);
      expect(data.error, false);
      expect(data.message, "success");
    });
  });
}