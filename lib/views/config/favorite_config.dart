import 'package:get_storage/get_storage.dart';

class FavoriteService {
  final _box = GetStorage();
  final _key = 'isFavorite';

  List get favorite => _loadFavFromBox();

  List _loadFavFromBox() => _box.read(_key) ?? [];

  _saveFavToBox(List favorite) => _box.write(_key, favorite);

  void changeFavorite(String id) {
    List newFavorite = _loadFavFromBox();
    if (newFavorite.contains(id)) {
      newFavorite.remove(id);
    } else {
      newFavorite.add(id);
    }
    _saveFavToBox(newFavorite);
  }
}
