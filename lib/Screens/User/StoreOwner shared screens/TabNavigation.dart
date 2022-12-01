import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/UserHomePage.dart';

import '../../UserScreens/MyWishPage.dart';

class TabNavigation extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? tabName;

  const TabNavigation({Key? key, this.navigatorKey, this.tabName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget checkerrr;

    //  _buildoffstageNavigator('UserHomePage'),
    //     _buildoffstageNavigator('UserStorePage'),
    //     _buildoffstageNavigator('UserGroupsPage'),
    //     _buildoffstageNavigator('UserSettingsPage'),

    if (tabName == "Home") {
      checkerrr = UserHomePage();
    } else if (tabName == "UserGroupsPage") {
      checkerrr = MyWishPage();
    } else
      checkerrr = MyWishPage();
    // } else if (tabName == "Stores") {
    //   child = UserStorePage();
    // } else if (tabName == "Settings") {
    //   child = UserSettingsPage();
    // }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => checkerrr,
        );
      },
    );
  }
}
