// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:rezflux_app/controller/restaurant_controller.dart';

void main(){
  group('Testing Home Controller', () {
    final RestaurantController controller = Get.put(RestaurantController());

    test('Response status should be no error', () {
      expect(controller.status.isError, false);
    });
  });
}
