import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  String FirestLastName = '';

  void checkONtheSharedEmail() {
    if (emailAddressForSharing.text == currentUserEmail) {
      Fluttertoast.showToast(msg: "You can't share with yourself");
      //show a message that you can't share with yourself
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
      // print(snapshot.docs[0].data()['uId']);
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
      Fluttertoast.showToast(msg: "There's no user with that email");
    });

    // print(snapshot.docs[0].data()['uId']));
  }

  void getFirstNameForCurrent() {
    db
        .collection('Users')
        .where('uId', isEqualTo: currentUserId)
        .get()
        .then((snapshot) {
      // FirestLastName = snapshot.data()!['firstname'] + ' ' + snapshot.data()!['Lastname'];

      FirestLastName = snapshot.docs[0].data()['firstname'] +
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

    print(userItems);
    await db.collection('wishlists').doc(ShareUid).set({
      'sharedWishlistsFromUsers': {
        // "$wishlistName $currentUserEmail": {
        //   "wishlistName": wishlistName,
        //   "wishlistOwnerEmail": currentUserEmail,
        //   'userId': currentUserId,
        //   'wishlistType': wishlisttype,
        // }
        "$FirestLastName": {
          wishlistName: {
            'wishlistName': wishlistName,
            'wishlistType': wishlisttype,
            'wishlistDescription': wishlistDescription,
          },
          "wishlistOwnerEmail": currentUserEmail,
          'userId': currentUserId,
        }

        //after you click share , you send your wishlist to the sharedUser
        // "$currentUserEmail wishlist": {
        //   '$wishlistName-UserItems': {...userItems},
        //   'wishlistOwnerEmail': currentUserEmail
        // },
        // ''
        // 'wishlist owner email': currentUserEmail,
      },
    }, SetOptions(merge: true));
  }
}
