import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/HomePage.dart';
import 'package:wishy_store/Screens//LogInPage.dart';

class StoreOwnerPage extends StatefulWidget {
  static String id = 'StoreOwnerPage';

  @override
  State<StoreOwnerPage> createState() => _StoreOwnerPage();
}

class _StoreOwnerPage extends State<StoreOwnerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('store owner pageeeee Page'),
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.blue,
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Text("Sign Out"),
        ),
      ),
    );
  }
}
