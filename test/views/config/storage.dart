import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rezflux_app/views/config/favorite.dart';
import 'package:rezflux_app/views/config/theme.dart';

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
  group('Testing Favorite Storage', () {
    test('Favorite storage should be change', () {
      FavoriteService().changeFavorite('rqdv5juczeskfw1e867');
      expect(FavoriteService().favorite.isNotEmpty, true);
      FavoriteService().changeFavorite('rqdv5juczeskfw1e867');
      expect(FavoriteService().favorite.isEmpty, true);
    });
  });
}