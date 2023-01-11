import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/UserProfilePage.dart';
import 'package:wishy_store/StoreOwner/StoreOwnerPage.dart';

class StoreOwnerNavBar extends StatefulWidget {
  static String id = 'store_owner_nav_bar';
  @override
  State<StoreOwnerNavBar> createState() => _StoreOwnerNavBarState();
}

class _StoreOwnerNavBarState extends State<StoreOwnerNavBar> {
  int _selectedIndex = 0;
  // static const TextStyle optionStyle =
  //     TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    // FillingInformation(),
    StoreOwnerPage(),
    UserProfilePage(),
    //hello
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
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}
