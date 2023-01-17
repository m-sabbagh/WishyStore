import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/MyWishPage/MyWishPage.dart';
import 'package:wishy_store/Screens/UserScreens/UserProfilePage.dart';
import 'package:wishy_store/Screens/UserScreens/UserStorePages/StoresPage.dart';
import 'package:wishy_store/Screens/UserScreens/UserHomePage.dart';

import '../../UserScreens/MyWishPage/WishHubPage.dart';

class NavigationBarForUser extends StatefulWidget {
  static String id = 'navigation_bar';
  @override
  State<NavigationBarForUser> createState() => _NavigationBarForUserState();
}

class _NavigationBarForUserState extends State<NavigationBarForUser> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    UserHomePage(),
    UserStorePage(),
    MyWishPage(),
    WishHubPage(),
    UserProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.widgets,
            ),
            label: 'MyWish',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'WishHub',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF5E57A5),
        onTap: _onItemTapped,
      ),
    );
  }
}
