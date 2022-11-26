import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wishy_store/Screens/User/StoreOwner%20shared%20screens/NavigationBAR.dart';
import 'package:wishy_store/Screens/User/StoreOwner%20shared%20screens/LogInPage.dart';

class StayLoggedIn extends StatelessWidget {
  const StayLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return NavigationBarsssss();
            //else if user else if store owner
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
