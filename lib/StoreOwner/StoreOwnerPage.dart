import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/StoreOwner/MyCategories.dart';
import 'package:wishy_store/StoreOwner/Promotions/Promotions.dart';
import 'package:wishy_store/StoreOwner/UpdateStoreInfo.dart';
import 'package:wishy_store/StoreOwner/addNewItemToStore.dart';
import 'package:wishy_store/StoreOwner/UploadToStorage.dart';

class StoreOwnerPage extends StatefulWidget {
  static String id = 'StoreOwnerPage';

  @override
  State<StoreOwnerPage> createState() => _StoreOwnerPage();
}

class _StoreOwnerPage extends State<StoreOwnerPage> {
  String? storename;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String imageUrl = '';

  getStoreName() {
    FirebaseFirestore.instance
        .collection('StoreOwners')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        storename = value['storeName'];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStoreName();
  }

  File? filevar;
  String? imageURL = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            //  Menu
            SizedBox(
              width: 10,
            ),
            Text(
              'My Store',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 13,
                ),
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [],
                    ),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('StoreOwners')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .get(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return Row(
                              children: [
                                Text(
                                  '${snapshot.data!['storeName']}-',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  snapshot.data!['storeType'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            );
                          } else {
                            return Text('Loading');
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                height: 100,
                                width: 200,
                                color: Colors.grey,
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, MyCategories.id);
                                  },
                                  child: Center(
                                      child: Text(
                                    "My categories",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: 100,
                                width: 200,
                                color: Colors.grey,
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, AddNewItemToStore.id);
                                  },
                                  child: Center(
                                      child: Text(
                                    "Add new item",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                height: 100,
                                width: 200,
                                color: Colors.grey,
                                child: MaterialButton(
                                  onPressed: () async {
                                    filevar = await Storage.getGalleryImage(
                                        image: filevar);
                                    imageURL = await Storage.uploadUserImage(
                                        image: filevar);

                                    await FirebaseFirestore.instance
                                        .collection('StoreOwners')
                                        .doc(userId)
                                        .update({'storeLogo': imageURL});
                                    SetOptions(merge: true);
                                  },
                                  child: Center(
                                      child: Text(
                                    "Upload store logo",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: 100,
                                width: 200,
                                color: Colors.grey,
                                child: MaterialButton(
                                  onPressed: () async {
                                    filevar = await Storage.getGalleryImage(
                                        image: filevar);
                                    imageURL = await Storage.uploadUserImage(
                                        image: filevar);

                                    await FirebaseFirestore.instance
                                        .collection('StoreOwners')
                                        .doc(userId)
                                        .update({'storeCover': imageURL});
                                    SetOptions(merge: true);
                                  },
                                  child: Center(
                                      child: Text(
                                    "Upload store cover",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Container(
                                height: 100,
                                width: 200,
                                color: Colors.grey,
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return UpdateStoreInfo();
                                      },
                                    ));
                                  },
                                  child: Center(
                                      child: Text(
                                    "Update store info",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                height: 100,
                                width: 200,
                                color: Colors.grey,
                                child: MaterialButton(
                                  onPressed: () async {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return StoreOwnerPromotions(
                                          storeName: storename!,
                                        );
                                      },
                                    ));
                                  },
                                  child: Center(
                                      child: Text(
                                    "Promotions",
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ]),
          ],
        ),
      ),
    );
  }
}
