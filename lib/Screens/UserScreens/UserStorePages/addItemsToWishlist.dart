import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddItemsToWishlist {
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
    FirebaseFirestore wishlist = FirebaseFirestore.instance;
    User? user = await FirebaseAuth.instance.currentUser;
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
