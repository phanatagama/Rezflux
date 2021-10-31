// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:rezflux_app/controller/detail.dart';
import 'package:rezflux_app/controller/home.dart';

import 'package:rezflux_app/main.dart';

void main(){
  group('Testing Home Controller', () {
    final HomeController controller = Get.put(HomeController());

    test('Response status should be no error', () {
      expect(controller.status.isError, false);
    });
  });
  group('Testing Detail Controller', () {
    final DetailController controller =
    Get.put(DetailController('rqdv5juczeskfw1e867'));

    test('Response status should be no error', () {
      expect(controller.status.isError, false);
    });
  });
}

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(MyApp());
//
//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);
//
//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();
//
//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }
