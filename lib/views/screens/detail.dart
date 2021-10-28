import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Detail extends StatefulWidget {
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Column(children: [
          Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(32),
                  bottomLeft: Radius.circular(32)),
              child: CachedNetworkImage(
                imageUrl: "https://restaurant-api.dicoding.dev/images/large/14",
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
                        "Melting Pot",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "Jln. Pandeglang no 19",
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
                            "4.5",
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
                            child: FaIcon(FontAwesomeIcons.clock,
                                color: Colors.white, size: 16),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "24 Hour",
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
                Row(
                  children: [
                    Chip(
                      label: Text(
                        'Italia',
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w700)),
                      ),
                      backgroundColor: const Color(0xA4EBF3),
                      avatar: FaIcon(
                        FontAwesomeIcons.checkCircle,
                        color: Colors.blue,
                        size: 16,
                        semanticLabel: 'Categories',
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Chip(
                      label: Text(
                        'Modern',
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w700)),
                      ),
                      backgroundColor: const Color(0xA4EBF3),
                      avatar: FaIcon(
                        FontAwesomeIcons.checkCircle,
                        color: Colors.blue,
                        size: 16,
                        semanticLabel: 'Categories',
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8,),
                Text(
                  "Description",
                  style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
                  style: GoogleFonts.mulish(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ],
            ),
          )
        ]),
        appBar: false ? AppBar(title: Text("Detail Page")) : null);
  }
}
