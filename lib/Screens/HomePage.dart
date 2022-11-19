import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/HomePage.dart';
import 'package:wishy_store/Screens//LogInPage.dart';

class HomePage extends StatefulWidget {
  static String id = 'home_screen';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF313040),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF313040),
        title: Text('WishyStore'),
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
