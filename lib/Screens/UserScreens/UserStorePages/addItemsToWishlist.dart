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
    required String imageUrl,
    required String itemTitle,
    required String itemPrice,
    required String itemBarcode,
    required String itemCategory,
    required String itemDescription,
    required String itemStoreName,
  }) async {
    // print(wName);
    // print(imageUrl);
    // print(itemPrice);
    // print(itemTitle);
    FirebaseFirestore wishlist = FirebaseFirestore.instance;
    User? user = await FirebaseAuth.instance.currentUser;

    //here i want to add the new wishlist to the
    // userWishlists each time the user clicks the button
    await wishlist.collection('wishlists').doc(user!.uid).set({
      'userWishlists': {
        wName: {
          'UserItems': {
            itemTitle: {
              'imageUrl': imageUrl,
              'itemTitle': itemTitle,
              'itemPrice': itemPrice,
              'isReserved': false,
              'itemBarcode': itemBarcode,
              'itemCategory': itemCategory,
              'itemDescription': itemDescription,
              'itemStoreName': itemStoreName,
            }
          },
        },
      },
    }, SetOptions(merge: true));
  }
}
