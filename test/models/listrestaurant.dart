import 'package:flutter_test/flutter_test.dart';
import 'package:rezflux_app/models/listrestaurant.dart';

var apiResponse = {
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
"rating": 4.0
}
]
};

void main() {
  group('Testing List Restaurant Models', () {
    test('Restaurant model should be return a Map', () {
      Restaurant data = Restaurant.fromJson(apiResponse);
      expect(data.error, false);
      expect(data.message, "success");
      expect(data.count, 20);
    });
  });
}