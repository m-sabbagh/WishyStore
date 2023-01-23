import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wishy_store/Screens/UserScreens/UsersThatSharedInWishHub.dart';

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

  Map wishlistData3 = {};

  List<String> wishlistType = [];

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
        });
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
    CollectionReference wlists =
        FirebaseFirestore.instance.collection('wishlists');

    //hello co

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'WishHub',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
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
                    child: Padding(
                      padding: const EdgeInsets.only(top: 200.0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No shared wishlists yet",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "           Ask your friends to \nshare their wishlists with you",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      ListView.builder(
                          itemCount: wishlistUsers.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Card(
                                  elevation: 4,
                                  shadowColor:
                                      Color.fromARGB(255, 174, 172, 172),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    title: Text(
                                      wishlistUsers.keys.elementAt(index),
                                      style: TextStyle(
                                          color: Colors.grey.shade700,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    leading: Icon(
                                      Icons.location_history,
                                      color: Colors.grey.shade700,
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.grey.shade700,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      'Are you sure you want to delete your friend wishlists?'),
                                                  content: Row(
                                                    children: [
                                                      Expanded(
                                                        child: DialogButton(
                                                          color:
                                                              Color(0xFF5E57A5),
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: DialogButton(
                                                          color:
                                                              Color(0xFF5E57A5),
                                                          onPressed: () {
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
                                                                    FieldValue
                                                                        .delete()
                                                              });
                                                              SetOptions(
                                                                  merge: true);
                                                              Navigator.pop(
                                                                  context);
                                                            });
                                                          },
                                                          child: Text(
                                                            "Yes",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
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
                                    ),
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UsersThatSharedInWishHub(
                                                        userEmail: wishlistUsers
                                                            .keys
                                                            .elementAt(
                                                                index))));
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          }),
                    ],
                  );
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
