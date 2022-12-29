import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wishy_store/Screens/UserScreens/stores/StoreItems.dart';

import '../../../constants.dart';

class AddtoWishlistButton extends StatelessWidget {
  const AddtoWishlistButton({
    Key? key,
    required this.items,
  }) : super(key: key);

  final StoreItems items;

  // String? selecteditem;
  // var wishlistTypes = [
  //   'Birthday',
  //   'Wedding',
  //   'Graduation',
  //   'Baby Shower',
  //   'House Warming',
  //   'Other'
  // ];

  // String? wishlistOneName;
  // String? wishlistOneType;
  // String? wishlistName;
  // bool isthereIsWishlissts = false;

  // Map wishlistData = {};

  // List<String> wishlistNames = [];

  // List<String> wishlistTypeNew = [];
  // void checkIftheresWishlists() {
  //   FirebaseFirestore wishlist = FirebaseFirestore.instance;
  //   wishlist
  //       .collection('wishlists')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .asStream()
  //       .toList()
  //       .then((value) {
  //     value.forEach((element) {
  //       print(element.data());
  //       wishlistData = element.data() as Map;
  //       print(wishlistData['userWishlists']);
  //       print(wishlistData['userWishlists'].length);
  //       if (wishlistData['userWishlists'].length == 0) {
  //         isthereIsWishlissts = false;
  //       } else {
  //         print('there is wishlist');
  //         isthereIsWishlissts = true;
  //         wishlistData['userWishlists'].forEach((key, value) {
  //           print("the name of the wishlist is " + key);

  //           print(value);
  //           print(value['wishlistType']);
  //           // createWishlistInThePage(key, wishlist type);
  //           wishlistNames.add(key);
  //           wishlistTypeNew.add(value['wishlistType']);
  //         });
  //       }
  //     });
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   checkIftheresWishlists();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 50,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: items.color,
                onPressed: () {
                  //   showDialog<String>(
                  //   context: context,
                  //   builder: (BuildContext context) => AlertDialog(
                  //     title: const Text('Please pick your wishlist'),
                  //     content: Container(
                  //       height: 200,
                  //       child: SingleChildScrollView(
                  //         child: Column(
                  //           children: [
                  //             for (var i = 0; i < wishlistNames.length; i++)
                  //               ListTile(
                  //                 leading: Radio(
                  //                     value: "radio value",
                  //                     groupValue: "group value",
                  //                     onChanged: (value) {
                  //                       print(wishlistNames[i].toString());
                  //                       wishlistName = wishlistNames[i];
                  //                       setState(() {
                  //                         AddItemsToWishlist().addNewItems(
                  //                           //improtant , this works !
                  //                           // wName: 'wishlist1',
                  //                           wName: wishlistName,
                  //                           itemPrice: storeitems[index]
                  //                               .price
                  //                               .toString(),
                  //                           itemTitle: storeitems[index]
                  //                               .title
                  //                               .toString(),
                  //                           imageUrl: storeitems[index]
                  //                               .image
                  //                               .toString(),
                  //                         );
                  //                       });
                  //                       //selected value
                  //                     }),
                  //                 title: Text(wishlistNames[i]),
                  //                 onTap: () {
                  //                   //   setState(() {
                  //                   //   AddItemsToWishlist().addNewItems(
                  //                   //     //improtant , this works !
                  //                   //     // wName: 'wishlist1',
                  //                   //     wName: wishlistName,
                  //                   //     itemPrice: storeitems[index]
                  //                   //         .price
                  //                   //         .toString(),
                  //                   //     itemTitle: storeitems[index]
                  //                   //         .title
                  //                   //         .toString(),
                  //                   //     photoUrl: storeitems[index]
                  //                   //         .image
                  //                   //         .toString(),
                  //                   //   );
                  //                   // });
                  //                 },
                  //               ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     actions: <Widget>[
                  //       TextButton(
                  //         onPressed: () => Navigator.pop(context, 'Cancel'),
                  //         child: const Text('Cancel'),
                  //       ),
                  //       TextButton(
                  //         onPressed: () => Navigator.pop(context, 'OK'),
                  //         child: const Text('OK'),
                  //       ),
                  //     ],
                  //   ),
                  // );
                },
                child: Text(
                  "Add to my wishlist".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
