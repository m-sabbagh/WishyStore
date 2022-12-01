import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/FirebaseNetowrkFile/ReadData/GetUserName.dart';

class MyWishPage extends StatefulWidget {
  const MyWishPage({Key? key}) : super(key: key);

  static String id = 'user_groups_page';
  @override
  State<MyWishPage> createState() => _MyWishPageState();
}

class _MyWishPageState extends State<MyWishPage> {
  String docid = 'hii';
  User user = FirebaseAuth.instance.currentUser!;

  Future GetCurrentDocId() async {
    return FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        docid = element.id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      // child: Text("hello")
      child: FutureBuilder(
        future: GetCurrentDocId(),
        builder: (context, snapshot) {
          return GetUserName(docid);
        },
      ),
    );
  }
}
