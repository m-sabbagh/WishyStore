import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:wishy_store/Screens/User_StoreOwner%20sharedScreens/StoreOwner/UserNavBar.dart';
import 'package:wishy_store/Screens/User_StoreOwner%20sharedScreens/StoreOwner/StoreOwnerSignUp.dart';
import 'package:wishy_store/Screens/UserScreens/MyWishPage/MyWishPage.dart';
import 'package:wishy_store/Screens/UserScreens/UserProfilePage.dart';
import 'package:wishy_store/Screens/UserScreens/WishlistsPage.dart';
import 'package:wishy_store/Screens/UserScreens/ShowStoreForUser/StoresPage.dart';
import 'package:wishy_store/Screens/UserScreens/UserHomePage.dart';
import 'package:wishy_store/Screens/UserScreens/WishHubUser.dart';
import 'package:wishy_store/StoreOwner/StoreOwnerNavBar.dart';
import 'package:wishy_store/StoreOwner/addNewCategory.dart';
import 'package:wishy_store/StoreOwner/addNewItemToStore.dart';
import 'Screens/User_StoreOwner sharedScreens/StoreOwner/UserSignUpPage.dart';

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
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
          // scaffoldBackgroundColor: Color(0x8F8F8FFF),
          // scaffoldBackgroundColor: Colors.white,
          ),
      // home: StayLoggedIn(),
      // home: LoginScreen(),
      // home: StoreOwnerNavBar(),
      home: NavigationBarForUser(),
      // home: MyWidget(),
      routes: {
        UserSignUpPage.id: (context) => UserSignUpPage(),
        NavigationBarForUser.id: (context) => NavigationBarForUser(),
        UserProfilePage.id: (context) => UserProfilePage(),
        UserHomePage.id: (context) => UserHomePage(),
        MyWishPage.id: (context) => MyWishPage(),
        UserStorePage.id: (context) => UserStorePage(),
        // WishlistPage.id: (context) => WishlistPage(),
        WishlistPage.id: (context) => WishlistPage(),
        // StorePage.id: (context) => StorePage(),
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
