import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wishy_store/Widgets/ErrorToast.dart';

class UpdateStoreInfo extends StatefulWidget {
  const UpdateStoreInfo({Key? key}) : super(key: key);

  @override
  State<UpdateStoreInfo> createState() => _UpdateStoreInfoState();
}

class _UpdateStoreInfoState extends State<UpdateStoreInfo> {
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
      appBar: AppBar(
        title: Text('Update store info'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
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
                                title: Text('Update store phone number'),
                                content: Row(
                                  children: [
                                    Text(
                                      '+962',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    SizedBox(width: 8),
                                    SizedBox(
                                      width: 200,
                                      height: 50,
                                      child: TextField(
                                        controller: _changePhoneNumber,
                                        decoration: InputDecoration(
                                          hintTextDirection: TextDirection.ltr,
                                          alignLabelWithHint: true,
                                          hintText: 'Ex: 7xxxxxxxx',
                                          hintStyle: TextStyle(
                                            color: Colors.grey,
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
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
                        style: TextStyle(color: Colors.white, fontSize: 11),
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
                                        controller: _emailcontroller,
                                        decoration: InputDecoration(
                                          hintText: 'Enter support email',
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
                                        keyboardType:
                                            TextInputType.emailAddress,
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
    );
  }
}
