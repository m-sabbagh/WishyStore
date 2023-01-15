import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateWishList {
  // CreateWishList(
  //   {required this.wishlistName,
  //   required this.wishlistType,
  //   required this.wishlistCount});

  String? wishlistName;
  String? wishlistType;
  String? wishlistDescription;

  void addNewWishlist(String? wName, wType, String description) async {
    FirebaseFirestore wishlist = FirebaseFirestore.instance;
    User? user = await FirebaseAuth.instance.currentUser;
    // CollectionReference wish =
    //     FirebaseFirestore.instance.collection('wishlists');

    //here i want to add the new wishlist to the
    // userWishlists each time the user clicks the button
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
