import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateWishList {
  String? wishlistName;
  String? wishlistType;
  String? wishlistDescription;

  void addNewWishlist(String? wName, wType, String description) async {
    FirebaseFirestore wishlist = FirebaseFirestore.instance;
    User? user = await FirebaseAuth.instance.currentUser;
    await wishlist.collection('wishlists').doc(user!.uid).set({
      'userWishlists': {
        wName: {
          'wishlistType': wType,
          'UserItems': {},
          'wishlistDescription': description,
        },
      },
    }, SetOptions(merge: true));
  }
}
