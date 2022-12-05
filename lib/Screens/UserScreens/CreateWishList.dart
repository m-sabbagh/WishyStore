import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateWishList {
  // CreateWishList(
  //   {required this.wishlistName,
  //   required this.wishlistType,
  //   required this.wishlistCount});

  String? wishlistName;
  String? wishlistType;
  int? wishlistCount;

  void addNewWishlist(String? wName, wType) async {
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
        },
      },
    }, SetOptions(merge: true));

    // Wishlists wishlists = Wishlists();
    // CollectionReference subCollection = db.collection('wishlists').doc(user!.uid).collection('wishlist1');

// every add call my wish to show the new wislist
//
//
//
//

// if userWishlists[0] then add to wishlist1
// if userWishlists[1] then add to wishlist2
//check on the collection

// also for the store owner u can from the sign

//     if (wCount == 1) {
//       await db.collection('wishlists').doc(user!.uid).set({
//         'uid': user.uid,
//         'email adrress': user.email,
//       });

//       await db
//           .collection('wishlists')
//           .doc(user!.uid)
//           .collection('wishlistOne')
//           .doc(user.uid)
//           .set({
//         'wishlist name': wName,
//         'wishlist type': wType,
//       });
//       // await db.collection('wishlists').doc(user!.uid).update({

//       // });
//     }

//     if (wCount == 2) {
//       await db
//           .collection('wishlists')
//           .doc(user!.uid)
//           .collection('wishlistTwo')
//           .doc(user.uid)
//           .set({
//         'wishlist name': wName,
//         'wishlist type': wType,
//       });
//     }

//     // 'wishlistName2' + '--' + wType: wName,

//     if (wCount == 3) {
//       await db
//           .collection('wishlists')
//           .doc(user!.uid)
//           .collection('wishlistThree')
//           .doc(user.uid)
//           .set({
//         // 'Type:' " " + wType + ", " 'wishlist3 named ': wName,
//         'wishlist name': wName,
//         'wishlist type': wType,
//       });
//     }

//     if (wCount == 4) {
//       await db
//           .collection('wishlists')
//           .doc(user!.uid)
//           .collection('wishlistFour')
//           .doc(user.uid)
//           .set({
//         'wishlist name': wName,
//         'wishlist type': wType,
//       });
//     }

//     // wishlists.uId = user!.uid;
//   }

//   // CreateWishList wishlist = CreateWishList(
//   //     wishlistName: widget.wishlistName,
//   //     wishlistType: widget.wishlistType,
//   //     wishlistCount: widget.wishlistCount);

// }

// class CreateWishList extends StatefulWidget {
//   String? wishlistName;
//   String? wishlistType;
//   int? wishlistCount;
//   CreateWishList(
//       {required this.wishlistName,
//       required this.wishlistType,
//       required this.wishlistCount});

//   @override
//   State<CreateWishList> createState() => _CreateWishListState();
// }

// class _CreateWishListState extends State<CreateWishList> {
//   void addNewWishlist(String? wName, wType, wCount) async {
//     FirebaseFirestore db = FirebaseFirestore.instance;
//     User? user = await FirebaseAuth.instance.currentUser;
//     // CollectionReference w = FirebaseFirestore.instance.collection('w');

//     // Wishlists wishlists = Wishlists();
//     // CollectionReference subCollection = db.collection('wishlists').doc(user!.uid).collection('wishlist1');

//     if (wCount == 1) {
//       await db.collection('wishlists').doc(user!.uid).set({
//         'uid': user.uid,
//         'email adrress': user.email,
//       });

//       await db
//           .collection('wishlists')
//           .doc(user!.uid)
//           .collection('wishlistOne')
//           .doc(user.uid)
//           .set({
//         'wishlist name': wName,
//         'wishlist type': wType,
//       });
//       // await db.collection('wishlists').doc(user!.uid).update({

//       // });
//     }

//     if (wCount == 2) {
//       await db
//           .collection('wishlists')
//           .doc(user!.uid)
//           .collection('wishlistTwo')
//           .doc(user.uid)
//           .set({
//         'wishlist name': wName,
//         'wishlist type': wType,
//       });
//     }

//     // 'wishlistName2' + '--' + wType: wName,

//     if (wCount == 3) {
//       await db
//           .collection('wishlists')
//           .doc(user!.uid)
//           .collection('wishlistThree')
//           .doc(user.uid)
//           .set({
//         // 'Type:' " " + wType + ", " 'wishlist3 named ': wName,
//         'wishlist name': wName,
//         'wishlist type': wType,
//       });
//     }

//     if (wCount == 4) {
//       await db
//           .collection('wishlists')
//           .doc(user!.uid)
//           .collection('wishlistFour')
//           .doc(user.uid)
//           .set({
//         'wishlist name': wName,
//         'wishlist type': wType,
//       });
//     }

//     // wishlists.uId = user!.uid;
//   }

//   @override
//   Widget build(BuildContext context) {
//     CreateWishList wishlist = CreateWishList(
//         wishlistName: widget.wishlistName,
//         wishlistType: widget.wishlistType,
//         wishlistCount: widget.wishlistCount);

//     addNewWishlist(
//         wishlist.wishlistName, wishlist.wishlistType, wishlist.wishlistCount);

//     return Container(
//         child: Column(
//       children: [
//         SizedBox(
//           height: 10,
//         ),
//         Container(
//           child:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Row(
//               children: [
//                 SizedBox(
//                   width: 10,
//                 ),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(20), // Image border
//                   child: SizedBox.fromSize(
//                     size: Size.fromRadius(48), // Image radius
//                     child: Image.asset(
//                       'images/asd2.jpeg',
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Text(" " + wishlist.wishlistName.toString(),
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 15,
//                         fontWeight: FontWeight.bold)),
//               ],
//             ),
//             Row(
//               children: [
//                 Icon(Icons.share),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Icon(Icons.delete),
//               ],
//             ),
//           ]),
//           width: 350,
//           height: 100,
//           decoration: BoxDecoration(
//             color: Color(0xFF3F3E4D),
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         SizedBox(
//           height: 10,
//         ),
//       ],
//     ));
//   }
// }

// // SizedBox(
// //   height: 10,
// // ),
// // Container(
// //   child: Row(
// //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //       children: [
// //         Row(
// //           children: [
// //             SizedBox(
// //               width: 10,
// //             ),
// //             ClipRRect(
// //               borderRadius:
// //                   BorderRadius.circular(20), // Image border
// //               child: SizedBox.fromSize(
// //                 size: Size.fromRadius(48), // Image radius
// //                 child: Image.asset(
// //                   'images/asd2.jpeg',
// //                   fit: BoxFit.cover,
// //                 ),
// //               ),
// //             ),
// //             Text(" " + "My birthday ",
// //                 style: TextStyle(
// //                     color: Colors.black,
// //                     fontSize: 15,
// //                     fontWeight: FontWeight.bold)),
// //           ],
// //         ),
// //         Row(
// //           children: [
// //             Icon(Icons.share),
// //           ],
// //         ),
// //       ]),
// //   width: 350,
// //   height: 100,
// //   decoration: BoxDecoration(
// //     color: Color(0xFF5E57A5),
// //     borderRadius: BorderRadius.circular(10),
// //
  }
}
