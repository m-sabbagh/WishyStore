import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wishy_store/FirebaseNetowrkFile/shareWishlistToUser.dart';
import 'package:wishy_store/Screens/UserScreens/WishlistsPage.dart';
import 'package:wishy_store/Screens/UserScreens/wishlistsImages.dart';

class WishlistCard extends StatefulWidget {
  String? wishname;
  String? wishType;
  bool? shareButtonVisi;
  String? wishlistDescription;

  WishlistCard(
      {this.wishname,
      this.wishType,
      this.shareButtonVisi,
      this.wishlistDescription});

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WishlistPage(
                      penVisible: true,
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
                      if (ShareButtonVisi == true)
                        IconButton(
                            onPressed: () {
                              Alert(
                                  context: context,
                                  title:
                                      "Please enter user email address for who u want to share to ",
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
                                          Fluttertoast.showToast(
                                              msg: "Please fill all the fields",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        } else {
                                          ShareWishlistTOuser
                                              shareWishlistTOuser =
                                              ShareWishlistTOuser(
                                            emailAddressForSharing:
                                                _ShareEmailAddress,
                                            currentUserEmail:
                                                _auth.currentUser!.email,
                                            wishlistName: wishlistn,
                                            currentUserId:
                                                _auth.currentUser!.uid,
                                            wishlisttype: wishlistTps,
                                            wishlistDescription:
                                                wishlistDescription,
                                          );
                                          setState(() {
                                            shareWishlistTOuser
                                                .checkONtheSharedEmail();
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
                            // delete them from firebase
                            //  wishlistNames.remove(wishlistn);
                            // //                                             wishlistTypeNew
                            // //                                                 .remove(wishlistTps);
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        'Are you sure you want to delete your wishlist?'),
                                    content: Row(
                                      children: [
                                        DialogButton(
                                          color: Color(0xFF5E57A5),
                                          onPressed: () {
                                            Navigator.pop(context);
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
                                            });
                                          },
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        ),
                                        DialogButton(
                                          color: Color(0xFF5E57A5),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
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
              color: Color(0xFF5E57A5),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      )),
    );
  }
}
