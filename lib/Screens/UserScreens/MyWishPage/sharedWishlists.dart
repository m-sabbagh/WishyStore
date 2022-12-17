import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/Widgets/postiontedArrowBack.dart';

class SharedWishlists extends StatefulWidget {
  const SharedWishlists({Key? key}) : super(key: key);

  @override
  State<SharedWishlists> createState() => _SharedWishlistsState();
}

class _SharedWishlistsState extends State<SharedWishlists> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  bool isthereIsWishlissts = false;

  Map wishlistData = {};

  List<String> wishlistNames = [];

  List<String> userIds = [];

//we want to check if theres any "sharedWishlistsFromUsers"
// if empty return {}
// if not empty

// sharedwishlist ->  map

  void checkIftheresWishlists() {
    FirebaseFirestore wishlist = FirebaseFirestore.instance;
    wishlist
        .collection('wishlists')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .asStream()
        .toList()
        .then((value) {
      value.forEach((element) {
        wishlistData = element.data() as Map;
        // if (wishlistData['sharedWishlistsFromUsers'].length == 0) {
        //   isthereIsWishlissts = false;
        // }

        wishlistData['sharedWishlistsFromUsers'].forEach((key, value) {
          // wishlistNames.add(key);
          wishlist
              .collection('wishlists')
              .doc(value['userId'])
              .get()
              .then((value) {
            print(value.data());
          });
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkIftheresWishlists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            // ...wishlistNames.map((e) => Text(e)),
            // positionedArrowBack(context, Colors.white),
            Container(
              child: Text("Shared Wishlists"),
            ),
          ],
        ),
      ),
    );
  }
}
