import 'package:flutter/material.dart';

class UserStorePage extends StatefulWidget {
  const UserStorePage({Key? key}) : super(key: key);
  static String id = 'user_store_page';

  @override
  State<UserStorePage> createState() => _UserStorePageState();
}

class _UserStorePageState extends State<UserStorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF313050),
      body: Center(
        child: Text(
          "User Store Page",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }
}
