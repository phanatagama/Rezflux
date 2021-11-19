import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:rezflux_app/views/screens/main_screen.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.network(
          'https://cdn4.iconfinder.com/data/icons/logos-brands-5/24/flutter-512.png'),
      title: Text(
        "RezFlux",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blue,
      showLoader: true,
      loadingText: Text("Loading..."),
      navigator: MyApp(),
      durationInSeconds: 3,
    );
  }
}
