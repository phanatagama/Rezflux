import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rezflux_app/views/config/theme_config.dart';

void main() async{
  await GetStorage.init();
  group('Testing Theme Mode', () {
    test('Theme mode should be change', () {
      ThemeService().switchTheme();
      expect(ThemeService().theme, ThemeMode.dark);
      ThemeService().switchTheme();
      expect(ThemeService().theme, ThemeMode.light);
    });
  });
}