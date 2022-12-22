import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wishy_store/Screens/UserScreens/MyWishPage/CreateWishList.dart';
import 'package:wishy_store/Screens/UserScreens/MyWishPage/sharedWishlists.dart';
import 'package:wishy_store/Screens/UserScreens/MyWishPage/wishlistCard.dart';
import '../../../Widgets/ErrorToast.dart';

class MyWishPage extends StatefulWidget {
  const MyWishPage({Key? key}) : super(key: key);

  static String id = 'user_wishlists';
  @override
  State<MyWishPage> createState() => _MyWishPageState();
}

class _MyWishPageState extends State<MyWishPage> {
  String? selecteditem;
  var wishlistTypes = [
    'Birthday',
    'Wedding',
    'Graduation',
    'Baby Shower',
    'House Warming',
    'Other'
  ];

  FirebaseAuth _auth = FirebaseAuth.instance;

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
        // print(element.data());
        wishlistData = element.data() as Map;
        // print(wishlistData['userWishlists']);
        // print(wishlistData['userWishlists'].length);
        if (wishlistData['userWishlists'].length == 0) {
          isthereIsWishlissts = false;
        }

        // print('there is wishlist');
        // isthereIsWishlissts = true;
        wishlistData['userWishlists'].forEach((key, value) {
          // print("the name of the wishlist is " + key);

          // print(value);
          // print(value['wishlistType']);
          // createWishlistInThePage(key, wishlist type);
          wishlistNames.add(key);
          wishlistTypeNew.add(value['wishlistType']);
        });
      });
    });
  }

  // Widget wishlistCard(String wishlistn, String wishlistTps) {
  //   FirebaseAuth _auth = FirebaseAuth.instance;

  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => WishlistPage(
  //                     wishlistName: wishlistn,
  //                     wishlistType: wishlistTps,
  //                   )));
  //     },
  //     child: Container(
  //         child: Column(
  //       children: [
  //         SizedBox(
  //           height: 10,
  //         ),
  //         Container(
  //           child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Row(
  //                   children: [
  //                     SizedBox(
  //                       width: 10,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(6.0),
  //                       child: ClipRRect(
  //                         borderRadius: BorderRadius.circular(20),
  //                         child: SizedBox.fromSize(
  //                           size: Size.fromRadius(48), // Image radius
  //                           child: wishlistImages(wishlistTps),
  //                         ),
  //                       ),
  //                     ),
  //                     Text(" " + wishlistn,
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 15,
  //                             fontWeight: FontWeight.bold)),
  //                   ],
  //                 ),
  //                 Row(
  //                   children: [
  //                     IconButton(
  //                         onPressed: () {
  //                           Alert(
  //                               context: context,
  //                               title:
  //                                   "Please enter user email address for who u want to share to ",
  //                               content: Column(
  //                                 children: <Widget>[
  //                                   SizedBox(
  //                                     height: 15.0,
  //                                   ),
  //                                   SizedBox(
  //                                     height: 45.0,
  //                                     child: TextField(
  //                                       controller: _ShareEmailAddress,
  //                                       decoration: InputDecoration(
  //                                         hintText: 'email address',
  //                                         hintStyle: TextStyle(
  //                                           color: Colors.grey,
  //                                         ),
  //                                         border: OutlineInputBorder(
  //                                           borderRadius:
  //                                               BorderRadius.circular(10.0),
  //                                           borderSide: BorderSide(
  //                                             color: Colors.grey,
  //                                             width: 2.0,
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                               buttons: [
  //                                 DialogButton(
  //                                   color: Color(0xFF5E57A5),
  //                                   onPressed: () => Navigator.pop(context),
  //                                   child: Text(
  //                                     "Cancel",
  //                                     style: TextStyle(
  //                                         color: Colors.white, fontSize: 20),
  //                                   ),
  //                                 ),
  //                                 DialogButton(
  //                                   color: Color(0xFF5E57A5),
  //                                   onPressed: () {
  //                                     if (_ShareEmailAddress.text.isEmpty) {
  //                                       Fluttertoast.showToast(
  //                                           msg: "Please fill all the fields",
  //                                           toastLength: Toast.LENGTH_SHORT,
  //                                           gravity: ToastGravity.BOTTOM,
  //                                           timeInSecForIosWeb: 1,
  //                                           backgroundColor: Colors.red,
  //                                           textColor: Colors.white,
  //                                           fontSize: 16.0);
  //                                     } else {
  //                                       ShareWishlistTOuser
  //                                           shareWishlistTOuser =
  //                                           ShareWishlistTOuser(
  //                                               emailAddressForSharing:
  //                                                   _ShareEmailAddress,
  //                                               currentUserEmail:
  //                                                   _auth.currentUser!.email,
  //                                               wishlistName: wishlistn,
  //                                               currentUserId:
  //                                                   _auth.currentUser!.uid);
  //                                       setState(() {
  //                                         shareWishlistTOuser
  //                                             .checkONtheSharedEmail();
  //                                       });

  //                                       Navigator.pop(context);
  //                                     }
  //                                   },
  //                                   child: Text(
  //                                     "Share",
  //                                     style: TextStyle(
  //                                         color: Colors.white, fontSize: 20),
  //                                   ),
  //                                 )
  //                               ]).show();
  //                         },
  //                         icon: Icon(Icons.share_rounded)),
  //                     SizedBox(
  //                       height: 40,
  //                     ),
  //                     IconButton(
  //                       highlightColor: Colors.transparent,
  //                       splashColor: Colors.transparent,
  //                       onPressed: () {
  //                         setState(() {
  //                           // delete them from firebase

  //                           showDialog(
  //                               context: context,
  //                               builder: (context) {
  //                                 return AlertDialog(
  //                                   title: Text(
  //                                       'Are you sure you want to delete your wishlist?'),
  //                                   content: Row(
  //                                     children: [
  //                                       DialogButton(
  //                                         color: Color(0xFF5E57A5),
  //                                         onPressed: () {
  //                                           Navigator.pop(context);
  //                                           setState(() {
  //                                             wishlistNames.remove(wishlistn);
  //                                             wishlistTypeNew
  //                                                 .remove(wishlistTps);
  //                                           });
  //                                         },
  //                                         child: Text(
  //                                           "Yes",
  //                                           style: TextStyle(
  //                                               color: Colors.white,
  //                                               fontSize: 20),
  //                                         ),
  //                                       ),
  //                                       DialogButton(
  //                                         color: Color(0xFF5E57A5),
  //                                         onPressed: () =>
  //                                             Navigator.pop(context),
  //                                         child: Text(
  //                                           "Cancel",
  //                                           style: TextStyle(
  //                                               color: Colors.white,
  //                                               fontSize: 20),
  //                                         ),
  //                                       ),
  //                                     ],
  //                                   ),
  //                                 );
  //                               });
  //                         });
  //                       },
  //                       icon: Icon(Icons.delete),
  //                     )
  //                   ],
  //                 ),
  //               ]),
  //           width: 350,
  //           height: 100,
  //           decoration: BoxDecoration(
  //             color: Color(0xFF5E57A5),
  //             borderRadius: BorderRadius.circular(10),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //       ],
  //     )),
  //   );
  // }

  @override
  void initState() {
    super.initState();
    checkIftheresWishlists(); // printwhatinside();
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

  final _wishListName = TextEditingController();

  WishlistCard wishlistCard = WishlistCard();

  int wishlistCounters = 0;

  bool ShareButtonVisible = true;

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
                  onPressed: () {
                    setState(() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SharedWishlists()));
                    });
                  },
                  icon: Icon(
                    EvaIcons.people,
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
                if (data['userWishlists'].isEmpty ||
                    data['userWishlists'] == null) {
                  return Text(
                    "You dont have any wishlist yet",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  );
                } else {
                  return Center(
                    child: Column(
                      //call each wishlist card here
                      children: [
                        ...wishlistNames.map((e) => WishlistCard(
                              wishname: e,
                              wishType:
                                  wishlistTypeNew[wishlistNames.indexOf(e)],
                              shareButtonVisi: ShareButtonVisible,
                            )),
                      ],
                    ),
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
                          if (wishlistNames.length == 4) {
                            CustomFlutterToast_Error(
                                message: "You can only create 4 wishlists",
                                toastLength: Toast.LENGTH_SHORT);
                          } else if (_wishListName.text.length > 11) {
                            CustomFlutterToast_Error(
                              message:
                                  "Wishlist name can't be more than 10 characters",
                              toastLength: Toast.LENGTH_LONG,
                            );
                          } else {
                            (CreateWishList().addNewWishlist(
                                _wishListName.text.toString(), selecteditem));
                            CustomFlutterToast_Error(
                              message: "Wishlist created + $wishlistCounters",
                              toastLength: Toast.LENGTH_SHORT,
                            );
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
