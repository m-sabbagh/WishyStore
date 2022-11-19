import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/HomePage.dart';
import 'package:wishy_store/Screens//LogInPage.dart';

class StayLoggedIn extends StatelessWidget {
  const StayLoggedIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
            //else if user else if store owner
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
