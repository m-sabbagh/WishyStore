import 'package:flutter/material.dart';

class ItemExample extends StatelessWidget {
  const ItemExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Item Example',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
              child: Image.asset(
            'images/ItemExample.png',
            fit: BoxFit.cover,
          )),
        ),
      ),
    );
  }
}
