import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rezflux_app/views/config/favorite_config.dart';

class Favorite extends StatefulWidget {
  final String id;
  Favorite({required this.id});

  @override
  _FavoriteState createState() => _FavoriteState(id: id);
}

class _FavoriteState extends State {
  final String id;

  _FavoriteState({required this.id});

  bool _checkFavorite(String id){
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
        _checkFavorite(id) ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
        color: Colors.red,
        size: _checkFavorite(id) ? 24 : 16,
        semanticLabel: 'Fav Logo',
      ),
      onPressed: () {
        setState(() {
          FavoriteService().changeFavorite(id);
        });
      },
    );
  }

}