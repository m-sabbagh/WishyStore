import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wishy_store/FirebaseNetowrkFile/shareWishlistToUser.dart';
import 'package:wishy_store/Screens/UserScreens/WishlistsPage.dart';
import 'package:wishy_store/Screens/UserScreens/wishlistsImages.dart';
import 'package:wishy_store/Widgets/ErrorToast.dart';

class WishlistCard extends StatefulWidget {
  String wishname;
  String wishType;
  bool shareButtonVisi;
  String wishlistDescription;

  WishlistCard(
      {required this.wishname,
      required this.wishType,
      required this.shareButtonVisi,
      required this.wishlistDescription});
  @override
  State<WishlistCard> createState() => _WishlistCardState(
      wishlistn: wishname,
      wishlistTps: wishType,
      ShareButtonVisi: shareButtonVisi,
      wishlistDescription: wishlistDescription);
}

class _WishlistCardState extends State<WishlistCard> {
  String? wishlistn;
  String? wishlistTps;
  bool? ShareButtonVisi;
  String? wishlistDescription;

  _WishlistCardState(
      {this.wishlistn,
      this.wishlistTps,
      this.ShareButtonVisi,
      this.wishlistDescription});
  FirebaseAuth _auth = FirebaseAuth.instance;

  final _ShareEmailAddress = TextEditingController();
  RegExp email_valid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WishlistPage(
                      isSharedUser: false,
                      wishlistName: wishlistn,
                      wishlistType: wishlistTps,
                      uid: _auth.currentUser!.uid,
                      wishlistDescription: wishlistDescription,
                    )));
      },
      child: Container(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(48), // Image radius
                            child: wishlistImages(wishlistTps),
                          ),
                        ),
                      ),
                      Text(" " + wishlistn!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Alert(
                                context: context,
                                title:
                                    "Share Wishlist to another user by email",
                                content: Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    SizedBox(
                                      height: 45.0,
                                      child: TextField(
                                        controller: _ShareEmailAddress,
                                        decoration: InputDecoration(
                                          hintText: 'email address',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide(
                                              color: Colors.grey,
                                              width: 2.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                buttons: [
                                  DialogButton(
                                    color: Color(0xFF5E57A5),
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  DialogButton(
                                    color: Color(0xFF5E57A5),
                                    onPressed: () {
                                      if (_ShareEmailAddress.text.isEmpty) {
                                        CustomFlutterToast_Error(
                                            message: "Please enter an email",
                                            toastLength: Toast.LENGTH_SHORT);
                                      } else if (!_ShareEmailAddress.text
                                                  .contains('@') ==
                                              true ||
                                          !_ShareEmailAddress.text
                                                  .contains('.com') ==
                                              true ||
                                          !_ShareEmailAddress.text
                                                  .contains(email_valid) ==
                                              true) {
                                        CustomFlutterToast_Error(
                                            message:
                                                "Please enter a valid email",
                                            toastLength: Toast.LENGTH_SHORT);
                                      } else {
                                        ShareWishlistToUser
                                            shareWishlistTOuser =
                                            ShareWishlistToUser(
                                          emailAddressForSharing:
                                              _ShareEmailAddress,
                                          currentUserEmail:
                                              _auth.currentUser!.email,
                                          wishlistName: wishlistn,
                                          currentUserId: _auth.currentUser!.uid,
                                          wishlisttype: wishlistTps,
                                          wishlistDescription:
                                              wishlistDescription,
                                        );
                                        setState(() {
                                          shareWishlistTOuser
                                              .checkONtheSharedEmail();
                                          _ShareEmailAddress.clear();
                                        });

                                        Navigator.pop(context);
                                      }
                                    },
                                    child: Text(
                                      "Share",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  )
                                ]).show();
                          },
                          icon: Icon(Icons.share_rounded)),
                      SizedBox(
                        height: 40,
                      ),
                      IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Are you sure you want to delete your wishlist?'),
                                    content: Row(
                                      children: [
                                        Expanded(
                                          child: DialogButton(
                                            color: Color(0xFF5E57A5),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: DialogButton(
                                            color: Color(0xFF5E57A5),
                                            onPressed: () {
                                              setState(() {
                                                FirebaseFirestore wishlist =
                                                    FirebaseFirestore.instance;
                                                final docref = wishlist
                                                    .collection('wishlists')
                                                    .doc(FirebaseAuth.instance
                                                        .currentUser!.uid);
                                                docref.update({
                                                  'userWishlists.$wishlistn':
                                                      FieldValue.delete()
                                                });
                                                SetOptions(merge: true);

                                                Navigator.pop(context);
                                              });
                                            },
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          });
                        },
                        icon: Icon(Icons.delete),
                      )
                    ],
                  ),
                ]),
            width: 350,
            height: 100,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 120, 114, 186),
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          SizedBox(
            height: 8,
          ),
        ],
      )),
    );
  }
}
