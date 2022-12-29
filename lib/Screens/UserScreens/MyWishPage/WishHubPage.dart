import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wishy_store/Screens/UserScreens/WishlistsPage.dart';
import 'package:wishy_store/Screens/UserScreens/WishHubUser.dart';

class WishHubPage extends StatefulWidget {
  const WishHubPage({Key? key}) : super(key: key);

  @override
  State<WishHubPage> createState() => _WishHubPageState();
}

class _WishHubPageState extends State<WishHubPage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  List<String> wishlistTypeNew = [];
  bool isthereIsWishlissts = false;

  Map wishlistData = {};

  Map wishlistData2 = {};

  Map wishlistData4 = {};

  // List<String> wishlistNames = [];

  Map wishlistData3 = {};

  List<String> wishlistType = [];
//we want to check if theres any "sharedWishlistsFromUsers"
// if empty return {}
// if not empty

// sharedwishlist ->  map

  String? name;

  List<String> wishlistNames = [];
  List<String> wishlistTypes = [];
  List<String> userIds = [];
  List<String> wishlistDescriptions = [];
  Map wishlistUsers = {};

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

        wishlistData['sharedWishlistsFromUsers'].forEach((key, value) {
          wishlistUsers[key] = value;
          // print(key);

          //resub
          // wishlistData['sharedWishlistsFromUsers'][key].forEach((key, value) {
          //   // print(key);

          //   if (key == 'wishlistOwnerEmail') {
          //     // print(value);
          //   }
          //    else if (key == 'userId') {
          //     userIds.add(value);
          //   } else {
          //     print(value['wishlistType']);
          //   }

          //   // else if (key == 'wishlistName') {
          //   //   print(value);
          //   //   wishlistNames.add(value);
          //   // } else if (key == 'wishlistType') {
          //   //   wishlistTypes.add(value);
          //   // } else if (key == 'wishlistDescription') {
          //   //   wishlistDescriptions.add(value);
          //   // }
          //   // if (key == 'wishlistOwnerEmail') {
          //   //           print(value['wishlistOwnerEmail']);
          //   //         }
          //   //          else if (key == 'userId') {
          //   //           print('nothing but userId');
          //   //         } else {
          //   //           wishlistNames.add(value['wishlistName']);
          //   //           wishlistTypes.add(value['wishlistType']);
          //   //           wishlistDescriptions.add(value['wishlistDescription']);
          //   //           userIds.add(value['userId']);
          //   //         }

          //   // if (key == 'wishlistType') {
          //   //   wishlistTypes.add(value);
          //   // }
          //   // if (key == 'wishlistDescription') {
          //   //   wishlistDescriptions.add(value);
          //   // }
          //   // if (key == 'userId') {
          //   //   userIds.add(value);
          //   // }
          // });

          //  wishlistType.add(value['wishlistType']);
          // wishlistNames.add(value['wishlistName']);
        });
      });
    });
  }

  // void getWishlistForThatEmail(String email) {
  //   FirebaseFirestore wishlist = FirebaseFirestore.instance;
  //   wishlist
  //       .collection('wishlists')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get()
  //       .asStream()
  //       .toList()
  //       .then((value) {
  //     value.forEach((element) {
  //       wishlistData = element.data() as Map;

  //       wishlistData['sharedWishlistsFromUsers'][email].forEach((key, value) {
  //         // print(key);
  //         if (key == 'wishlistOwnerEmail') {
  //           print('nothing but email');
  //         } else if (key == 'userId') {
  //           print('nothing but userId');
  //         } else {
  //           wishlistNames.add(value['wishlistName']);
  //           wishlistTypes.add(value['wishlistType']);
  //           wishlistDescriptions.add(value['wishlistDescription']);
  //           userIds.add(value['userId']);
  //         }
  //       });
  //     });
  //   });
  void getWishlistForThatEmail(String email) {}

//important for future
  // dynamic getThatWishlist(String wname, String userId) {
  //   FirebaseFirestore wishlist = FirebaseFirestore.instance;

  //   wishlist
  //       .collection('wishlists')
  //       .doc(userId)
  //       .get()
  //       .asStream()
  //       .toList()
  //       .then((value) => value.forEach((element) {
  //             wishlistData2 = element.data() as Map;

  //             wishlistData2['userWishlists'].forEach((key, value) {
  //               if (key == wname) {
  //                 return value['UserItems'];
  //                 // print(key);
  //                 // print(value['wishlistType']);
  //                 // wishlistTypeNew.add(value['wishlistType']);
  //               }
  //             });
  //           }));
  // }

  @override
  void initState() {
    super.initState();
    checkIftheresWishlists();
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference wlists =
        FirebaseFirestore.instance.collection('wishlists');

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 14, 35),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'WishHub',
              style: TextStyle(color: Colors.white, fontSize: 30),
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
              if (snapshot.hasData) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                if (data['sharedWishlistsFromUsers'].length == 0) {
                  return Center(
                    child: Text(
                      'No Shared Wishlists',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      ListView.builder(
                          itemCount: wishlistUsers.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(
                                wishlistUsers.keys.elementAt(index),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                              leading: Icon(
                                Icons.location_history,
                                color: Colors.white,
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
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
                                                DialogButton(
                                                  color: Color(0xFF5E57A5),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      FirebaseFirestore
                                                          wishlist =
                                                          FirebaseFirestore
                                                              .instance;
                                                      final docref = wishlist
                                                          .collection(
                                                              'wishlists')
                                                          .doc(FirebaseAuth
                                                              .instance
                                                              .currentUser!
                                                              .uid);
                                                      docref.update({
                                                        'sharedWishlistsFromUsers.${wishlistUsers.keys.elementAt(index)}':
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
                              ),
                              // subtitle: Text(
                              //   userIds[index],
                              //   style: TextStyle(color: Colors.white),
                              // ),
                              // subtitle: Text(
                              //   wishlistData3.values.elementAt(index),
                              //   style: TextStyle(color: Colors.white),
                              // ),  // subtitle: Text(
                              //   wishlistData3.values.elementAt(index),
                              //   style: TextStyle(color: Colors.white),
                              // ),
                              onTap: () {
                                setState(() {
                                  // ThatOneUser(
                                  //     userEmail:
                                  //         wishlistUsers.keys.elementAt(index));
                                  // Navigator.pushNamed(context, ThaftOneUser.id);
                                  // print(wishlistUsers.values.elementAt(index));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WishHubUser(
                                              userEmail: wishlistUsers.keys
                                                  .elementAt(index))));
                                });

                                // Navigator.push(context, MaterialPageRoute(
                                //   builder: (context) {
                                //     return ThatOneUser(

                                //     );
                                //   },
                                // ));
                              },
                            );
                          }),

                      // ...wishlistData3
                      //     .map((Key, value) {
                      //       Key = ['wishlistname'];

                      //       return MapEntry(
                      //         Key,
                      //         ListTile(
                      //           title: Text(
                      //             Key,
                      //             style: TextStyle(color: Colors.white),
                      //           ),
                      //           subtitle: Text(
                      //             value,
                      //             style: TextStyle(color: Colors.white),
                      //           ),
                      //           leading: Icon(
                      //             EvaIcons.giftOutline,
                      //             color: Colors.white,
                      //           ),
                      //           onTap: () {
                      //             Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                 builder: (context) => WishlistPage(
                      //                   wishlistName: Key,
                      //                   wishlistType: 'Wedding',
                      //                   uid: value,
                      //                 ),
                      //               ),
                      //             );
                      //           },
                      //         ),
                      //       );
                      //     })
                      //     .values
                      //     .toList(),

                      // ...wishlistData3 .map((key, value) => MapEntry(
                      //     key,
                      //     ListTile(
                      //       leading: Icon(
                      //         EvaIcons.giftOutline,
                      //         color: Colors.white,
                      //       ),
                      //       onTap: () => {
                      //         print(wishlistData3['userId']),
                      //       },
                      //       title: Text(
                      //         key,
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //     ));

                      //   ...wishlistNames.map((e) => ListTile(
                      //   leading: Icon(
                      //     EvaIcons.giftOutline,
                      //     color: Colors.white,
                      //   ),
                      //   onTap: () => {
                      //     print(wishlistData3['userId']),
                      //   },
                      //   title: Text(
                      //     e,
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // )),
                    ],
                  );

                  // return Column(
                  //   children: [
                  //     ListView.builder(
                  //       shrinkWrap: true,
                  //       physics: NeverScrollableScrollPhysics(),
                  //       itemCount: data['sharedWishlistsFromUsers'].length,
                  //       itemBuilder: (context, index) {
                  //         return WishlistCard(
                  //           wishlistName: data['sharedWishlistsFromUsers']
                  //               [index]['wishlistName'],
                  //           wishlistType: wishlistTypeNew[index],
                  //           userId: data['sharedWishlistsFromUsers'][index]
                  //               ['userId'],
                  //         );
                  //       },
                  //     ),
                  //   ],
                  // );
                }
              }

              return Center(child: CircularProgressIndicator());
            }),
          ),
        ),
      ),
    );
  }
}
