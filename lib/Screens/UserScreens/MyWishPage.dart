import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wishy_store/Screens/UserScreens/CreateWishList.dart';
import 'package:wishy_store/Screens/UserScreens/wishlistsImages.dart';

class MyWishPage extends StatefulWidget {
  const MyWishPage({Key? key}) : super(key: key);

  static String id = 'user_wishlists';
  @override
  State<MyWishPage> createState() => _MyWishPageState();
}

class _MyWishPageState extends State<MyWishPage> {
//else {get the wishlist name and type for each and disply them }

//if the user dont have a wishlist show msg 'you dont have any wishlist yet'

//if the user have a wishlists get the wishlist name and type for each and disply them

//dismis the creation of wishlist and assume that's its already been created

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

  bool isthereIsWishlissts = false;

  Map wishlistData = {};

  List<String> wishlistNames = [];

  List<String> wishlistTypeNew = [];

  void printwhatinside() {
    print('thissss');
    print(wishlistData);
  }

  void trying() {
    FirebaseFirestore wishlist = FirebaseFirestore.instance;
    wishlist
        .collection('wishlists')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .asStream()
        .toList()
        .then((value) {
      value.forEach((element) {
        print(element.data());
        wishlistData = element.data() as Map;
        print(wishlistData['userWishlists']);
        print(wishlistData['userWishlists'].length);
        // if (wishlistData['userWishlists'].length == 0) {
        //   print('no wishlist');
        //   isthereIsWishlissts = false;
        // }

        print('there is wishlist');
        // isthereIsWishlissts = true;
        wishlistData['userWishlists'].forEach((key, value) {
          print("the name of the wishlist is " + key);

          print(value);
          print(value['wishlistType']);
          // createWishlistInThePage(key, wishlist type);
          wishlistNames.add(key);
          wishlistTypeNew.add(value['wishlistType']);
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    trying();
    // printwhatinside();
  }

// if(wishlistType==other) upload
// else
// getimage() {
//   if(birthday) {
//     return birthdayimage
//   }
//   if(wedding) {
//     return weddingimage
//   }
// }

//IMPORTTTTTANNTTTTTT

  Widget wishlistCard(String wishlistn, String wishlistTps) {
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                if (wishlistTps == 'Other')
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(48),
                      child: Image.asset(
                        'images/asd.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                if (wishlistTps != 'Other')
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(48), // Image radius
                      child: wishlistImages(wishlistTps),
                    ),
                  ),
                Text(" " + wishlistn,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            Row(
              children: [
                Icon(Icons.share),
                SizedBox(
                  height: 40,
                ),
                IconButton(
                  onPressed: () {
                    //delete wishlist from the database
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
    ));
  }

  final _wishListName = TextEditingController();

  int wishlistCounters = 0;

  @override
  Widget build(BuildContext context) {
    CollectionReference wlists =
        FirebaseFirestore.instance.collection('wishlists');

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 14, 35),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('My Wish',
                style: TextStyle(color: Colors.white, fontSize: 30)),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    EvaIcons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<DocumentSnapshot>(
            future: wlists.doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                if (data['userWishlists'].isEmpty) {
                  return Text(
                    "You dont have any wishlist yet",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  );
                } else {
                  return Column(
                    //call each wishlist card here
                    children: [
                      ...wishlistNames.map((e) => wishlistCard(
                          e, wishlistTypeNew[wishlistNames.indexOf(e)])),
                    ],
                  );
                }
              }

              return Center(child: CircularProgressIndicator());
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF5E57A5),
          child: Icon(EvaIcons.plus),
          onPressed: () {
            Alert(
                context: context,
                title: "Create wishlist",
                content: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 45.0,
                      child: TextField(
                        controller: _wishListName,
                        decoration: InputDecoration(
                          hintText: 'Wishlist name',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 45,
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton(
                          value: selecteditem,
                          isExpanded: true,
                          hint: Text('Wishlist type'),
                          underline: Container(),
                          items: wishlistTypes.map((item) {
                            return DropdownMenuItem(
                              child: Text(item),
                              value: item,
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selecteditem = value.toString();
                              // for (var i = 0; i < items.length; i++) {
                              //   if (items[i] == value) {
                              //     selecteditem = items[i];
                              //     value = items[i];
                              //   }
                              // }
                            });
                          },
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
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  DialogButton(
                    color: Color(0xFF5E57A5),
                    onPressed: () {
                      if (_wishListName.text.isEmpty || selecteditem == null) {
                        Fluttertoast.showToast(
                            msg: "Please fill all the fields",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        setState(() {
                          if (_wishListName.text.length > 10) {
                            Fluttertoast.showToast(
                                msg:
                                    "Wishlist name can't be more than 10 characters",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                          if (wishlistNames.length == 4) {
                            Fluttertoast.showToast(
                                msg: "You can only create 4 wishlists",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else {
                            (CreateWishList().addNewWishlist(
                                _wishListName.text.toString(), selecteditem));
                            Fluttertoast.showToast(
                                msg: "Wishlist created + $wishlistCounters",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0);
                            // }
                          }
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      "Create",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          }),
    );
  }
}

//  child: FutureBuilder(
//         future: GetCurrentDocId(),
//         builder: (context, snapshot) {
//           return GetUserName(docid);
//         },

//  String docid = 'hii';
// User user = FirebaseAuth.instance.currentUser!;

// Future GetCurrentDocId() async {
//   return FirebaseFirestore.instance
//       .collection('users')
//       .where('email', isEqualTo: user.email)
//       .get()
//       .then((value) {
//     value.docs.forEach((element) {
//       docid = element.id;
//     });
//   });
// }
