import 'package:get_storage/get_storage.dart';

class FavoriteService {
  final _box = GetStorage();
  final _key = 'isFavorite';

  /// Get isDarkMode info from local storage and return ThemeMode
  List get favorite => _loadFavFromBox();

  /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  List _loadFavFromBox() => _box.read(_key) ?? [];

  /// Save isDarkMode to local storage
  _saveThemeToBox(List favorite) => _box.write(_key, favorite);

  /// Switch theme and save to local storage
  void changeFavorite(String id) {
    List newFavorite = _loadFavFromBox();
    if (newFavorite.contains(id)) {
      newFavorite.remove(id);
    } else {
      newFavorite.add(id);
    }
    _saveThemeToBox(newFavorite);
  }
}