import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rezflux_app/models/listrestaurant.dart';
import 'package:rezflux_app/views/widgets/favorite.dart';

class RestCard extends StatelessWidget {
  final Color mode;
  final Restaurants restaurant;

  RestCard({required this.mode, required this.restaurant});

  List<Widget> generateStar(num rating) {
    List<Widget> list = [];
    var halfrate = rating - rating.toInt();
    for(var i=0; i<rating.toInt(); i+=1) {
      list.add(FaIcon(
        FontAwesomeIcons.solidStar,
        color: Colors.yellow,
        size: 16,
        semanticLabel: "Star Logo",
      ));
    }
    var star = 5 - list.length;
    if (star != 0) {
      if (halfrate > 0) {
        list.add(FaIcon(
          FontAwesomeIcons.starHalfAlt,
          color: Colors.yellow,
          size: 16,
          semanticLabel: "Star Logo",
        ));
      }
      if (list.length < 5) {
        for (var i=0; i<(5 - list.length); i+=1) {
          list.add(FaIcon(
            FontAwesomeIcons.star,
            color: Colors.yellow,
            size: 16,
            semanticLabel: "Star Logo",
          ));
        }
      }
    }
    list.add(Text(
      "($rating)",
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
      ),
    ));
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed("/detail/${restaurant.id}", arguments: mode);
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
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
                              "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}"),
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
                      right: 16,
                      child: Text(
                        restaurant.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w800),
                      )),
                  Positioned(
                      top: 16,
                      left: 16,
                      child: Chip(
                        label: Text(restaurant.city, style: GoogleFonts.nunito(textStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700)),),
                        backgroundColor: const Color(0xA4EBF3),
                        avatar: FaIcon(
                          FontAwesomeIcons.mapMarkerAlt,
                          color: Colors.blue,
                          size: 16,
                          semanticLabel: 'Place Logo',
                        ),
                      )),
                  Positioned(
                      top: 8,
                      right: 8,
                      child: Favorite(id: restaurant.id)
                      )
                ])),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 16, top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: generateStar(restaurant.rating),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      restaurant.description, overflow: TextOverflow.ellipsis, maxLines: 2,)))
          ]),
        ),
      )
      ,
    );
  }


}

