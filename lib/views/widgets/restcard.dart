import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RestCard extends StatelessWidget {
  final Color mode;

  RestCard({required this.mode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: mode,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(children: [
        Expanded(
            flex: 4,
            child: Stack(children: [
              Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          "https://restaurant-api.dicoding.dev/images/small/14"),
                      fit: BoxFit.fitWidth),
                ),
                child: Opacity(
                    opacity: 0.3,
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment(0.8, 0.0),
                              colors: [
                                const Color(0xFFFFFFEE),
                                const Color(0xFF999999)
                              ],
                              tileMode: TileMode.repeated,
                            )))),
              ),
              Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    "D'Copiz",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800),
                  ))
            ])),
        Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.yellow,
                    size: 16,
                    semanticLabel: "Star Logo",
                  ),
                  FaIcon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.yellow,
                    size: 16,
                    semanticLabel: "Star Logo",
                  ),
                  FaIcon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.yellow,
                    size: 16,
                    semanticLabel: "Star Logo",
                  ),
                  FaIcon(
                    FontAwesomeIcons.solidStar,
                    color: Colors.yellow,
                    size: 16,
                    semanticLabel: "Star Logo",
                  ),
                  FaIcon(
                    FontAwesomeIcons.star,
                    color: Colors.yellow,
                    size: 16,
                    semanticLabel: "Star Logo",
                  ),
                  Text(
                    "(4.2)",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                        color: Colors.black54),
                  )
                ],
              ),
            )),
        Expanded(
            flex: 2,
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                    "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...")))
      ]),
    );
  }
}