import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rezflux_app/controller/detail_controller.dart';
import 'package:rezflux_app/models/detail_model.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Detail extends StatelessWidget {
  final DetailController controller =
      Get.put(DetailController(Get.parameters['id'] ?? 'rqdv5juczeskfw1e867'));

  dynamic _menuConstraint(dynamic maxWidth) {
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

  Widget _labelsMenu(List<Category> menu, String type, num count) {
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

  Widget _customerReview(List customerReviews) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
            title: Text(
              customerReviews[index]?.name ?? "John Doe",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(customerReviews[index]?.date ?? "16 Desember 1967",
                    style: GoogleFonts.mulish(
                      fontSize: 10,
                    )),
                Text(
                  customerReviews[index]?.review ?? "Recomended",
                  style: GoogleFonts.mulish(
                    fontSize: 14,
                  ),
                )
              ],
            ),
            leading: CircleAvatar(
              child: Text(customerReviews[index]?.name[0] ?? "A",
                  style: GoogleFonts.mulish(
                    fontSize: 16,
                  )),
            ));
      },
      itemCount: customerReviews.length,
    );
  }

  List<Widget> _categoriesRest(List categories) {
    List<Widget> list = [];
    for (var index = 0; index < categories.length; index++) {
      list.add(Chip(
        label: Text(
          categories[index]?.name ?? "Label",
          style: GoogleFonts.nunito(
              textStyle: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w700,
          )),
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
            minHeight: 48,
            color: Get.arguments ?? Colors.blue,
            maxHeight:  (data?.customerReviews?.length < 5 )
                ? data?.customerReviews?.length * 72.0
                : 5.0 * 72.0,
            collapsed: Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: radius,
              ),
              child: Center(
                child: Text(
                  "Reviews",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            panel: _customerReview(data?.customerReviews),
            body: SingleChildScrollView(
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
                          "https://restaurant-api.dicoding.dev/images/large/${data?.pictureId}",
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
                              data?.name,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32.0,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "${data?.address}",
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
                                  "${data?.rating}",
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
                                  "${data?.city}",
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
                        "Categories",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Row(children: _categoriesRest(data?.categories)),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Description",
                        style: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Text(
                        data.description,
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
                              return _labelsMenu(data?.menus?.foods, "foods",
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
                              return _labelsMenu(data?.menus?.drinks, "drinks",
                                  _menuConstraint(constraints.maxWidth));
                            },
                          ),
                        ])),
                SizedBox(
                  height: 48,
                )
              ],
            )),
          ),
          onEmpty: const Text("empty"),
          onLoading: Center(
            child: CircularProgressIndicator(),
          ),
          onError: (error) => Text("Error $error"),
        ),
        appBar: null);
  }
}
