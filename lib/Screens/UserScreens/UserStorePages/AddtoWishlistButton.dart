// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:wishy_store/Screens/UserScreens/stores/StoreItems.dart';

// import '../../../constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wishy_store/Screens/UserScreens/UserStorePages/addItemsToWishlist.dart';
import 'package:wishy_store/constants.dart';

class AddToWishlistButton extends StatefulWidget {
  String itemBarcode;
  String itemTitle;
  String itemPrice;
  String itemImage;
  String itemCategory;
  String itemDescription;
  String itemStoreName;

  AddToWishlistButton({
    required this.itemBarcode,
    required this.itemTitle,
    required this.itemPrice,
    required this.itemImage,
    required this.itemCategory,
    required this.itemDescription,
    required this.itemStoreName,
  });

  @override
  State<AddToWishlistButton> createState() => _AddToWishlistButtonState();
}

class _AddToWishlistButtonState extends State<AddToWishlistButton> {
  String? selecteditem;
  var wishlistTypes = [
    'Birthday',
    'Wedding',
    'Graduation',
    'Baby Shower',
    'House Warming',
    'Other'
  ];

  String? wishlistOneName;
  String? wishlistOneType;
  String? wishlistName;
  bool isthereIsWishlissts = false;

  Map wishlistData = {};

  List<String> wishlistNames = [];

  List<String> wishlistTypeNew = [];
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
        if (wishlistData['userWishlists'].length == 0) {
          isthereIsWishlissts = false;
        } else {
          isthereIsWishlissts = true;
          wishlistData['userWishlists'].forEach((key, value) {
            // createWishlistInThePage(key, wishlist type);
            wishlistNames.add(key);
            wishlistTypeNew.add(value['wishlistType']);
          });
        }
      });
    });
  }

  void checkIfItemIsAlreadyInWishlist(
      {required String wishlistName, required String itemBarcode}) {
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
        if (wishlistData['userWishlists'][wishlistName]['UserItems']
                [widget.itemTitle] !=
            null) {
          if (wishlistData['userWishlists'][wishlistName]['UserItems']
                  [widget.itemTitle]
              .containsValue(itemBarcode)) {
            Fluttertoast.showToast(
                msg: "Item already in $wishlistName",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        } else {
          AddItemsToWishlist().addNewItems(
            //improtant , this works !
            // wName: 'wishlist1',
            itemBarcode: widget.itemBarcode.toString(),
            itemCategory: widget.itemCategory.toString(),
            itemDescription: widget.itemDescription.toString(),
            itemStoreName: widget.itemStoreName.toString(),
            wName: wishlistName,
            itemPrice: widget.itemPrice.toString(),
            itemTitle: widget.itemTitle.toString(),
            imageUrl: widget.itemImage.toString(),
          );
          Fluttertoast.showToast(
              msg: "Item added to $wishlistName",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    checkIftheresWishlists();
  }

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
                color: kButtonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Please pick your wishlist'),
                      content: Container(
                        height: 300,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (wishlistNames.isEmpty == true)
                                Text(
                                  'You dont have any wishlist yet.\nPlease create one to add items to it.',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              for (var i = 0; i < wishlistNames.length; i++)
                                Card(
                                  elevation: 4,
                                  shadowColor:
                                      Color.fromARGB(255, 174, 172, 172),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: ListTile(
                                    iconColor:
                                        Color.fromARGB(255, 120, 114, 186),

                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    leading: Icon(Icons.card_giftcard_rounded),
                                    // leading: Radio(
                                    //     value: "radio value",
                                    //     groupValue: "group value",
                                    //     onChanged: (value) {

                                    //       //selected value
                                    //     }),
                                    title: Text(wishlistNames[i]),
                                    onTap: () {
                                      wishlistName = wishlistNames[i];
                                      setState(() {
                                        checkIfItemIsAlreadyInWishlist(
                                            wishlistName: wishlistName!,
                                            itemBarcode: widget.itemBarcode);
                                      });
                                    },
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Done'),
                          child: const Text('Done'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  "Add to my wishlist".toUpperCase(),
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
