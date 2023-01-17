import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wishy_store/StoreOwner/MyCategories.dart';
import 'package:wishy_store/StoreOwner/addNewItemToStore.dart';
import 'package:wishy_store/StoreOwner/UploadToStorage.dart';
import 'package:wishy_store/Widgets/ErrorToast.dart';

class StoreOwnerPage extends StatefulWidget {
  static String id = 'StoreOwnerPage';

  @override
  State<StoreOwnerPage> createState() => _StoreOwnerPage();
}

class _StoreOwnerPage extends State<StoreOwnerPage> {
  String? storename;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  String imageUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  File? filevar;
  String? imageURL = '';
  TextEditingController _changePhoneNumber = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  CollectionReference storeOwners =
      FirebaseFirestore.instance.collection('StoreOwners');
  FirebaseAuth _auth = FirebaseAuth.instance;

  RegExp email_valid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+");

  void updatePhoneNumber() {
    if (_changePhoneNumber.text.isEmpty) {
      CustomFlutterToast_Error(
          message: 'Please enter a phone number',
          toastLength: Toast.LENGTH_SHORT);
    } else if (_changePhoneNumber.text.length != 9 ||
        // _phonecontroller.text.startsWith('0') == true ||
        !_changePhoneNumber.text.startsWith('7') == true) {
      CustomFlutterToast_Error(
          message: "Please enter a valid phone number",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      storeOwners.doc(_auth.currentUser!.uid).update({
        'phoneNumber': _changePhoneNumber.text,
      });

      Fluttertoast.showToast(
          msg: 'Phone number updated successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);

      _changePhoneNumber.clear();
      Navigator.pop(context);
    }
  }

  void upadteSupportEmail() {
    if (_emailcontroller.text.isEmpty) {
      CustomFlutterToast_Error(
          message: 'Please enter email address',
          toastLength: Toast.LENGTH_SHORT);
    } else if (!_emailcontroller.text.contains('@') == true ||
        !_emailcontroller.text.contains('.com') == true ||
        !_emailcontroller.text.contains(email_valid) == true) {
      CustomFlutterToast_Error(
          message: "Please enter a valid email",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      storeOwners.doc(_auth.currentUser!.uid).update({
        'supportEmail': _emailcontroller.text,
      });

      Fluttertoast.showToast(
          msg: 'Email updated successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);

      _emailcontroller.clear();
      Navigator.pop(context);
    }
  }

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
                      children: [
                        // Card(
                        //   child: SizedBox(
                        //     height: 200,
                        //     child: Image.asset(
                        //       'images/asd.jpeg',
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                      ],
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
                                  snapshot.data!['storeName'],
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
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
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text(
                                                'Update store phone number'),
                                            content: Row(
                                              children: [
                                                Text(
                                                  '+962',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                SizedBox(width: 8),
                                                SizedBox(
                                                  width: 200,
                                                  height: 50,
                                                  child: TextField(
                                                    controller:
                                                        _changePhoneNumber,
                                                    decoration: InputDecoration(
                                                      hintTextDirection:
                                                          TextDirection.ltr,
                                                      alignLabelWithHint: true,
                                                      hintText: 'Ex: 7xxxxxxxx',
                                                      hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                    ),
                                                    keyboardType:
                                                        TextInputType.number,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    _changePhoneNumber.clear();

                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Cancel')),
                                              TextButton(
                                                  onPressed: () {
                                                    updatePhoneNumber();
                                                  },
                                                  child: Text('Save'))
                                            ],
                                          );
                                        });
                                  },
                                  child: Center(
                                      child: Text(
                                    "Update store phone number",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 11),
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
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('Edit support email'),
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  height: 50,
                                                  child: TextField(
                                                    controller:
                                                        _emailcontroller,
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          'Enter support email',
                                                      hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        borderSide: BorderSide(
                                                          color: Colors.grey,
                                                          width: 2.0,
                                                        ),
                                                      ),
                                                    ),
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Cancel')),
                                              TextButton(
                                                  onPressed: () {
                                                    upadteSupportEmail();
                                                  },
                                                  child: Text('Save'))
                                            ],
                                          );
                                        });
                                  },
                                  child: Center(
                                      child: Text(
                                    "Update support email",
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
