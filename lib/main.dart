import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:wishy_store/Screens/HomePage.dart';
import 'package:wishy_store/Screens/SettingsPage.dart';
import 'package:wishy_store/StoreOwnerPage.dart';
import 'package:wishy_store/stayLoggedIn.dart';
import 'Screens/LogInPage.dart';
import 'Screens/SignUpPage.dart';

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
      home: StayLoggedIn(),
      routes: {
        SignUpPage.id: (context) => SignUpPage(),
        HomePage.id: (context) => HomePage(),
        StoreOwnerPage.id: (context) => StoreOwnerPage(),
        UserSettingsPage.id: (context) => UserSettingsPage(),
      },
    );
  }
}
