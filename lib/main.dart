import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:wishy_store/Screens/UserScreens/UserNavBar.dart';
import 'package:wishy_store/Screens/User_StoreOwner%20sharedScreens/StoreOwner/StoreOwnerSignUp.dart';
import 'package:wishy_store/Screens/UserScreens/MyWishPage/MyWishPage.dart';
import 'package:wishy_store/Screens/UserScreens/UserProfilePage.dart';
import 'package:wishy_store/Screens/UserScreens/WishlistsPage.dart';
import 'package:wishy_store/Screens/UserScreens/UserStorePages/StoresPage.dart';
import 'package:wishy_store/Screens/UserScreens/UserHomePage.dart';
import 'package:wishy_store/Screens/UserScreens/UsersThatSharedInWishHub.dart';
import 'package:wishy_store/StoreOwner/StoreOwnerNavBar.dart';
import 'package:wishy_store/StoreOwner/MyCategories.dart';
import 'package:wishy_store/StoreOwner/addNewItemToStore.dart';
import 'package:wishy_store/stayLoggedIn.dart';
import 'Screens/User_StoreOwner sharedScreens/StoreOwner/UserSignUpPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(WishyStore());
}

class WishyStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color.fromARGB(249, 252, 252, 252),
      ),
      home: StayLoggedIn(),
      routes: {
        UserSignUpPage.id: (context) => UserSignUpPage(),
        NavigationBarForUser.id: (context) => NavigationBarForUser(),
        UserProfilePage.id: (context) => UserProfilePage(),
        UserHomePage.id: (context) => UserHomePage(),
        MyWishPage.id: (context) => MyWishPage(),
        UserStorePage.id: (context) => UserStorePage(),
        WishlistPage.id: (context) => WishlistPage(),
        UsersThatSharedInWishHub.id: (context) => UsersThatSharedInWishHub(),
        StoreOwnerNavBar.id: (context) => StoreOwnerNavBar(),
        AddNewItemToStore.id: (context) => AddNewItemToStore(),
        MyCategories.id: (context) => MyCategories(),
        StoreOwnerSignUp.id: (context) => StoreOwnerSignUp(),
      },
    );
  }
}
