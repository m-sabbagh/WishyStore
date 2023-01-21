import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wishy_store/Widgets/ErrorToast.dart';

//Firebase
class ShareWishlistToUser {
  TextEditingController emailAddressForSharing;
  String? wishlistName;
  String? currentUserId;
  String? currentUserEmail;
  String? wishlisttype;
  String? wishlistDescription;

  ShareWishlistToUser({
    required this.emailAddressForSharing,
    required this.currentUserId,
    required this.wishlistName,
    required this.currentUserEmail,
    required this.wishlisttype,
    required this.wishlistDescription,
  });

  FirebaseFirestore db = FirebaseFirestore.instance;

  String firstLastName = '';

  void checkONtheSharedEmail() {
    if (emailAddressForSharing.text == currentUserEmail) {
      Fluttertoast.showToast(msg: "You can't share with yourself");
    } else {
      getFirstNameForCurrent();
      getSharedEmail_UserId();
    }
  }

  Future getSharedEmail_UserId() async {
    String? sharedTo_UserId;
    await db
        .collection('Users')
        .where('email', isEqualTo: emailAddressForSharing.text)
        .get()
        .then((snapshot) {
      sharedTo_UserId = snapshot.docs[0].data()['uId'];
      createWishlistForSharedUser(sharedTo_UserId);
      Fluttertoast.showToast(
          msg: "Shared Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((error) {
      CustomFlutterToast_Error(
        message: "There's no user with that email",
      );
    });
  }

  void getFirstNameForCurrent() {
    db
        .collection('Users')
        .where('uId', isEqualTo: currentUserId)
        .get()
        .then((snapshot) {
      firstLastName = snapshot.docs[0].data()['firstname'] +
          ' ' +
          snapshot.docs[0].data()['Lastname'];
    });
  }

  Future<Map<dynamic, dynamic>> getThatWishlistItems(
      String? wishlistname) async {
    return await db
        .collection('wishlists')
        .doc(currentUserId)
        .get()
        .then((snapshot) async {
      if (snapshot.data() == null) {
        return {};
      } else {
        Map<dynamic, dynamic> wishlistData = {};
        wishlistData =
            await snapshot.data()!['userWishlists'][wishlistname]['UserItems'];
        return wishlistData;
      }
    });
  }

  void createWishlistForSharedUser(String? ShareUid) async {
    var userItems = await getThatWishlistItems(wishlistName);
    await db.collection('wishlists').doc(ShareUid).set({
      'sharedWishlistsFromUsers': {
        "$firstLastName": {
          wishlistName: {
            'wishlistName': wishlistName,
            'wishlistType': wishlisttype,
            'wishlistDescription': wishlistDescription,
          },
          "wishlistOwnerEmail": currentUserEmail,
          'userId': currentUserId,
        }
      },
    }, SetOptions(merge: true));
  }
}
