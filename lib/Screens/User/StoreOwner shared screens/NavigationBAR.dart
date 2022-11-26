import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/Groups.dart';
import 'package:wishy_store/Screens/UserScreens/UserSettingsPage.dart';
import 'package:wishy_store/Screens/UserScreens/StoresPage.dart';
import 'package:wishy_store/Screens/UserScreens/UserHomePage.dart';

class NavigationBarsssss extends StatefulWidget {
  static String id = 'navigation_bar';
  @override
  State<NavigationBarsssss> createState() => _NavigationBarsssssState();
}

class _NavigationBarsssssState extends State<NavigationBarsssss> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    UserHomePage(),
    UserStorePage(),
    MyWishPage(),
    UserSettingsPage(),
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.group),
          //   label: 'Groups',
          // ),
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
