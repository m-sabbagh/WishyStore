import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/WishlistsPage.dart';

class WishHubUser extends StatefulWidget {
  String? userEmail;

  WishHubUser({
    this.userEmail,
  });

  static String id = 'thatOneUser';

  @override
  State<WishHubUser> createState() => _WishHubUserState(
        userEmail: userEmail,
      );
}

class _WishHubUserState extends State<WishHubUser> {
  String? userEmail;
  _WishHubUserState({this.userEmail});

  String? userId;

  List<String> wishlistNames = [];
  List<String> wishlistTypes = [];
  List<String> wishlistDescriptions = [];

  Map wishlistData = {};
  void getWishlistsByEmail() {
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

        wishlistData['sharedWishlistsFromUsers'][userEmail]
            .forEach((key, value) {
          if (key == 'userId') {
            userId = value;
          } else if (key == 'wishlistOwnerEmail') {
            print('wishlistOwnerEmail: $value');
          } else {
            wishlistNames.add(key);
            wishlistTypes.add(value['wishlistType']);
            wishlistDescriptions.add(value['wishlistDescription']);
          }
          // if (key == userEmail) {
          //   print('wishlistName: $key');
          //   print('wishlistData: $value');
          // }
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // checkIftheresWishlists();
    getWishlistsByEmail();
  }

  CollectionReference wlists =
      FirebaseFirestore.instance.collection('wishlists');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 14, 35),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'Shared Wishlists',
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
                if (data['sharedWishlistsFromUsers'][userEmail].length == 0) {
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
                          itemCount: wishlistNames.length,
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return ListTile(
                              title: Text(
                                wishlistNames[index],
                                style: TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                wishlistTypes[index],
                                style: TextStyle(color: Colors.white),
                              ),
                              leading: Icon(
                                EvaIcons.giftOutline,
                                color: Colors.white,
                              ),
                              trailing: Icon(
                                EvaIcons.arrowIosForward,
                                color: Colors.white,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WishlistPage(
                                      isSharedUser: true,
                                      wishlistName: wishlistNames[index],
                                      wishlistType: wishlistTypes[index],
                                      uid: userId,
                                      wishlistDescription:
                                          wishlistDescriptions[index],
                                    ),
                                  ),
                                );
                              },
                            );
                          })),
                      //  Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => WishlistPage(
//                                       penVisible: false,
//                                       wishlistName:
//                                           wishlistUsers.keys.elementAt(index),
//                                       wishlistType: wishlistTypes[index],
//                                       uid:
//                                           wishlistUsers.values.elementAt(index),
//                                       wishlistDescription: wishlistDescriptions[
//                                           index], //wishlistData3.values.elementAt(index),
//                                     ),
//                                   ),
//                                 );
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
    // return Scaffold(
    //     body: Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Container(
    //         child: Text(
    //           userEmail.toString(),
    //           style: TextStyle(
    //             fontSize: 30,
    //           ),
    //         ),
    //       ),
    //       Text(wishlistData.toString()),
    //     ],
    //   ),
    // ));
  }
}
