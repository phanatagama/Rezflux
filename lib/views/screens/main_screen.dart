import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rezflux_app/views/screens/favorite_screen.dart';
import 'package:rezflux_app/views/screens/home_screen.dart';
import 'package:rezflux_app/views/screens/setting_screen.dart';

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  // late PersistentTabController _controller;

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller =
        PersistentTabController(initialIndex: 0);
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}

List<Widget> _buildScreens() {
  return [Home(), Favorite(), Setting()];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: Icon(FontAwesomeIcons.home),
      title: ("Home"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(FontAwesomeIcons.gratipay),
      title: ("Favorite"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: Icon(FontAwesomeIcons.cog),
      title: ("Settings"),
      activeColorPrimary: Colors.blue,
      inactiveColorPrimary: Colors.grey,
    ),
  ];
}
