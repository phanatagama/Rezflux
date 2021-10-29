import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rezflux_app/controller/detail.dart';
import 'package:rezflux_app/models/detail.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State {

  final DetailController controller =
      Get.put(DetailController(Get.parameters['id'] ?? 'rqdv5juczeskfw1e867'));

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24.0),
      topRight: Radius.circular(24.0),
    );
    return Scaffold(
        body: controller.obx(
          (data) => SlidingUpPanel(
            borderRadius: radius,
            minHeight: 50,
            color: Get.arguments,
            maxHeight: (data.customerReviews.length*64 < 5*64) ? data.customerReviews.length*64 : 5*64,
            collapsed: Container(
              decoration: BoxDecoration(color: Colors.blue, borderRadius: radius),
              child: Center(
                child: Text(
                  "Reviews",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            panel: _customerReview(data.customerReviews),
            body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(32),
                            bottomLeft: Radius.circular(32)),
                        child: CachedNetworkImage(
                          imageUrl:
                          "https://restaurant-api.dicoding.dev/images/large/${data.pictureId}",
                        ),
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
                                  data.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "${data.address}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w300),
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
                                      "${data.rating}",
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
                                      child: FaIcon(FontAwesomeIcons.mapMarkedAlt,
                                          color: Colors.blue, size: 16),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "${data.city}",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ]))
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
                            "Categories",
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          Row(children: _categories(data.categories)
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Description",
                            style: GoogleFonts.nunito(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          ),
                          Text(
                            data.description,
                            style: GoogleFonts.mulish(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        // margin: EdgeInsets.all(16),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Foods",
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              SizedBox(
                                height: (data.menus.foods.length / 2).round() * (48),
                                child: GridView.builder(
                                  itemCount: data.menus.foods.length,
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: (1 / .2)),
                                  itemBuilder: (_, index) {
                                    var details = data.menus.foods[index];
                                    return _labels(details, 'foods');
                                  },
                                ),
                              ),
                              Text(
                                "Drinks",
                                style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              SizedBox(
                                height: (data.menus.drinks.length / 2).round() * (48),
                                child: GridView.builder(
                                  itemCount: data.menus.drinks.length,
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: (1 / .2)),
                                  itemBuilder: (_, index) {
                                    var details = data.menus.drinks[index];
                                    return _labels(details, 'drinks');
                                  },
                                ),
                              ),
                            ])),
                    SizedBox(
                      height: 50,
                    )
                  ],
                )),
          ),
          onEmpty: const Text("empty"),
      onLoading: Center(
        child: CircularProgressIndicator(),
      ),
    ),
        appBar: false ? AppBar(title: Text("Detail Page")) : null);
  }

  Widget _labels(Category menu, String type) {
    var icon = type == 'foods'
        ? FaIcon(
            FontAwesomeIcons.utensils,
            color: Colors.blue,
            size: 16,
          )
        : FaIcon(FontAwesomeIcons.cocktail, color: Colors.blue, size: 16);
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.3),
        borderRadius: BorderRadius.circular(8),
      ),
      height: double.infinity,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(4),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 8,
          ),
          Text(
            menu.name,
            style: GoogleFonts.lato(fontWeight: FontWeight.w500), overflow: TextOverflow.ellipsis
          )
        ],
      ),
    );
  }

  Widget _customerReview(List customerReviews) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
              title: Text(customerReviews[index].name, style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w500)),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(customerReviews[index].date, style: GoogleFonts.mulish(fontSize: 10)),
                  Text(customerReviews[index].review, style: GoogleFonts.mulish(fontSize: 14))
                ],
              ),
              leading: CircleAvatar(
                child: Text(customerReviews[index].name[0],
                    style: GoogleFonts.mulish(fontSize: 16)),
              ));
      },
      itemCount: customerReviews.length,
    );
  }

  List<Widget> _categories(List categories) {
    List<Widget> list = [];
    for (var index = 0; index < categories.length; index++) {
      list.add(Chip(
        label: Text(
          categories[index].name,
          style: GoogleFonts.nunito(
              textStyle:
                  TextStyle(color: Colors.blue, fontWeight: FontWeight.w700)),
        ),
        backgroundColor: const Color(0xA4EBF3),
        avatar: FaIcon(
          FontAwesomeIcons.checkCircle,
          color: Colors.blue,
          size: 16,
          semanticLabel: 'Categories',
        ),
      ));
      list.add(SizedBox(
        width: 8,
      ));
    }
    return list;
  }
}
