import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rezflux_app/models/restaurant_model.dart';

class DetailPage extends StatelessWidget {
  final List<Restaurant> data;
  final String id;

  DetailPage({required this.data, required this.id});

  int _menuConstraint(num maxWidth) {
    if (maxWidth < 400) {
      return 1;
    } else if (maxWidth < 600) {
      return 2;
    } else if (maxWidth < 900) {
      return 3;
    } else if (maxWidth < 1200) {
      return 4;
    } else {
      return 5;
    }
  }

  Widget _labelsMenu(List menu, String type, num count) {
    var icon = type == 'foods'
        ? FaIcon(
      FontAwesomeIcons.utensils,
      color: Colors.blue,
      size: 16,
    )
        : FaIcon(
      FontAwesomeIcons.cocktail,
      color: Colors.blue,
      size: 16,
    );
    return Scrollbar(
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: menu.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: count.toInt(),
            childAspectRatio: (1 / .2),
          ),
          itemBuilder: (_, index) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: 48,
                minHeight: 48,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(4),
                child: Row(
                  children: [
                    icon,
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      menu[index].name,
                      style: GoogleFonts.lato(fontWeight: FontWeight.w500),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

  @override
  Widget build(BuildContext context) {
    Restaurant dataRestaurant = data.where((restaurant) => restaurant.id == id).toList()[0];
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(32),
                      bottomLeft: Radius.circular(32)),
                  color: Colors.transparent,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      "${dataRestaurant.pictureId}",
                    ),
                  ),
                ),
                height: 350.0,
              ),
              Container(
                height: 350.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(32),
                        bottomLeft: Radius.circular(32)),
                    color: Colors.white,
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.grey.withOpacity(0.0),
                          Colors.black,
                        ],
                        stops: [
                          0.0,
                          1.0
                        ])),
              ),
              Positioned(
                  bottom: 32,
                  left: 32,
                  right: 32,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          dataRestaurant.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 32.0,
                              fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.white.withOpacity(0.25)),
                                child: FaIcon(
                                  FontAwesomeIcons.solidStar,
                                  color: Colors.yellow,
                                  size: 16,
                                )),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${dataRestaurant.rating}",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white.withOpacity(0.3)),
                              child: FaIcon(
                                FontAwesomeIcons.mapMarkedAlt,
                                color: Colors.blue,
                                size: 16,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${dataRestaurant.city}",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ])),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey.withOpacity(0.5),
                    child: IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                ),
              ),
            ]),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.blue.withOpacity(0.3),
              ),
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    dataRestaurant.description,
                    style: GoogleFonts.mulish(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Foods",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return _labelsMenu(dataRestaurant.menus.foods, "foods",
                              _menuConstraint(constraints.maxWidth));
                        },
                      ),
                      Text(
                        "Drinks",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return _labelsMenu(dataRestaurant.menus.drinks, "drinks",
                              _menuConstraint(constraints.maxWidth));
                        },
                      ),
                    ])),
            SizedBox(
              height: 48,
            )
          ],
        ));
  }

}