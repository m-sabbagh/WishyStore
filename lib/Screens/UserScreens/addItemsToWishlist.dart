import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddItemsToWishlist {
  // String? wishlistName;
  // String? photoUrl;
  // String? ItemTitle;
  // String? ItemPrice;

  void addNewItems({
    String? wName,
    String? photoUrl,
    String? itemTitle,
    String? itemPrice,
  }) async {
    FirebaseFirestore wishlist = FirebaseFirestore.instance;
    User? user = await FirebaseAuth.instance.currentUser;
    // CollectionReference wish =
    //     FirebaseFirestore.instance.collection('wishlists');

    //here i want to add the new wishlist to the
    // userWishlists each time the user clicks the button
    await wishlist.collection('wishlists').doc(user!.uid).set({
      'userWishlists': {
        wName: {
          'UserItems': {
            'photoUrl': photoUrl,
            'itemTitle': itemTitle,
            'temPrice': itemPrice,
          },
        },
      },
    }, SetOptions(merge: true));
  }
}
