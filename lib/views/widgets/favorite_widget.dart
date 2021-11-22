import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rezflux_app/controller/restaurant_controller.dart';
import 'package:rezflux_app/views/config/favorite_config.dart';

class FavoriteWidget extends StatefulWidget {
  final String id;
  FavoriteWidget({required this.id});

  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState(id: id);
}

class _FavoriteWidgetState extends State {
  final String id;

  _FavoriteWidgetState({required this.id});
  RestaurantController controller = Get.find<RestaurantController>();

  bool _checkFavorite(String id) {
    List favorite = FavoriteService().favorite;
    if (favorite.contains(id)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(
        _checkFavorite(id)
            ? FontAwesomeIcons.solidHeart
            : FontAwesomeIcons.heart,
        color: Colors.red,
        size: _checkFavorite(id) ? 24 : 16,
        semanticLabel: 'Fav Logo',
      ),
      onPressed: () {
        setState(() {
          FavoriteService().changeFavorite(id);
          controller.favoriteFilter();
        });
      },
    );
  }
}
