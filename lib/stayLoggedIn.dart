import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wishy_store/Screens/User_StoreOwner%20sharedScreens/StoreOwner/LogInPage.dart';
import 'package:wishy_store/StoreOwner/StoreOwnerNavBar.dart';

import 'Screens/UserScreens/UserNavBar.dart';

class StayLoggedIn extends StatelessWidget {
  const StayLoggedIn({Key? key}) : super(key: key);

  Future getUserType() async {
    final user = await FirebaseAuth.instance.currentUser;
    final uid = user!.uid;
    final userRef = FirebaseFirestore.instance.collection('Users').doc(uid);
    final userData = await userRef.get();
    final userType = userData.get('userType');
    if (userType == 'User') {
      return NavigationBarForUser();
    } else {
      return StoreOwnerNavBar();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return FutureBuilder(
              future: getUserType(),
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data;
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
