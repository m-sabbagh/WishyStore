import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:wishy_store/Screens/User/StoreOwner%20shared%20screens/LogInPage.dart';
import 'package:wishy_store/Screens/User/StoreOwner%20shared%20screens/UserNavBar.dart';
import 'package:wishy_store/Screens/User/StoreOwner%20shared%20screens/NewSettings/StoreOwnerSignUp.dart';
import 'package:wishy_store/Screens/UserScreens/MyWishPage/MyWishPage.dart';
import 'package:wishy_store/Screens/UserScreens/UserProfilePage.dart';
import 'package:wishy_store/Screens/UserScreens/WishlistsPage.dart';
import 'package:wishy_store/Screens/UserScreens/stores/StoresPage.dart';
import 'package:wishy_store/Screens/UserScreens/UserHomePage.dart';
import 'package:wishy_store/Screens/UserScreens/stores/store1.dart';
import 'package:wishy_store/Screens/UserScreens/WishHubUser.dart';
import 'package:wishy_store/StoreOwner/StoreOwnerNavBar.dart';
import 'package:wishy_store/StoreOwner/StoreOwnerPage.dart';
import 'package:wishy_store/StoreOwner/addNewCategory.dart';
import 'package:wishy_store/StoreOwner/addNewItemToStore.dart';
import 'package:wishy_store/stayLoggedIn.dart';
import 'Screens/User/StoreOwner shared screens/UserSignUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(WishyStore());
}

class WishyStore extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // scaffoldBackgroundColor: Color(0x8F8F8FFF),
          // scaffoldBackgroundColor: Colors.white,
          ),
      // home: StayLoggedIn(),
      // home: LoginScreen(),
      home: StoreOwnerNavBar(),
      routes: {
        UserSignUpPage.id: (context) => UserSignUpPage(),
        NavigationBarForUser.id: (context) => NavigationBarForUser(),
        UserProfilePage.id: (context) => UserProfilePage(),
        UserHomePage.id: (context) => UserHomePage(),
        MyWishPage.id: (context) => MyWishPage(),
        UserStorePage.id: (context) => UserStorePage(),
        // WishlistPage.id: (context) => WishlistPage(),
        WishlistPage.id: (context) => WishlistPage(),
        StoreOne.id: (context) => StoreOne(),
        WishHubUser.id: (context) => WishHubUser(),
        StoreOwnerNavBar.id: (context) => StoreOwnerNavBar(),
        AddNewItemToStore.id: (context) => AddNewItemToStore(),
        AddNewCategory.id: (context) => AddNewCategory(),
        StoreOwnerSignUp.id: (context) => StoreOwnerSignUp(),

        // SharedWishlistsItems.id: (context) => SharedWishlistsItems(),
      },
    );
  }
}
