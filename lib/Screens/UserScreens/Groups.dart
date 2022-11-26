import 'package:flutter/material.dart';

class MyWishPage extends StatefulWidget {
  const MyWishPage({Key? key}) : super(key: key);
  static String id = 'user_groups_page';

  @override
  State<MyWishPage> createState() => _MyWishPageState();
}

class _MyWishPageState extends State<MyWishPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          "MyWish Page",
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
