// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wishy_store/Widgets/ErrorToast.dart';

import '../Screens/User/StoreOwner shared screens/LogInPage.dart';
import '../Widgets/buttonPadding.dart';

class FillingInformation extends StatefulWidget {
  static String id = 'fillinginformation_screen';

  const FillingInformation({Key? key}) : super(key: key);

  @override
  State<FillingInformation> createState() => _MyHomePageState();
}

RegExp phone_number = new RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$');
RegExp email_valid = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+");

class _MyHomePageState extends State<FillingInformation> {
  bool showSpinner = false;

  final _auth = FirebaseAuth.instance;
  final _StoreName = TextEditingController();
  final _StoreType = TextEditingController();
  final _StoreAddress = TextEditingController();
  final _MobileNumber = TextEditingController();
  final _EmailSupport = TextEditingController();
  //text filed sizedBox height named as sizedBoxHeightTextF
  double sizedBoxHeightTextF = 45.0;

  void fillinfoo() async {
    if (_MobileNumber.text.isEmpty == true ||
        _StoreAddress.text.isEmpty == true ||
        _StoreName.text.isEmpty == true ||
        _StoreType.text.isEmpty == true ||
        _EmailSupport.text.isEmpty == true) {
      CustomFlutterToast_Error(
          message: "Please fill all the fields",
          toastLength: Toast.LENGTH_SHORT);
      setState(() {
        showSpinner = false;
      });
    } else if (phone_number.hasMatch(_MobileNumber.text) == false) {
      CustomFlutterToast_Error(
          message: "Please enter a valid mobile number",
          toastLength: Toast.LENGTH_SHORT);
      setState(() {
        showSpinner = false;
      });
    } else if (email_valid.hasMatch(_EmailSupport.text) == false) {
      CustomFlutterToast_Error(
          message: "Please enter a valid email address",
          toastLength: Toast.LENGTH_SHORT);
      setState(() {
        showSpinner = false;
      });
    } else {
      FirebaseFirestore.instance
          .collection('StoreOwners')
          .doc(_auth.currentUser!.uid)
          .update({
        'StoreInfo': {
          'StoreName': _StoreName.text,
          'StoreType': _StoreType.text,
          'StoreAddress': _StoreAddress.text,
          'MobileNumber': _MobileNumber.text,
          'EmailSupport': _EmailSupport.text,
        },
        'infoFilled': true,
      });
      SetOptions(merge: true);

      FirebaseFirestore.instance
          .collection('Users')
          .doc(_auth.currentUser!.uid)
          .update({
        'infoFilled': true,
      });
      SetOptions(merge: true);

      showDialog(
          context: context,
          builder: (context) => Dialog(
                child: Container(
                  height: 200,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Your request has been sent to the admin',
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()),
                                (route) => false);
                          },
                          child: Text('OK'))
                    ],
                  ),
                ),
              ));

      clearallfields();
    }
  }

  void clearallfields() {
    _StoreAddress.clear();
    _MobileNumber.clear();
    _StoreName.clear();
    _StoreType.clear();
    _EmailSupport.clear();
  }

  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: sizedBoxHeightTextF,
                ),
                Image.asset(
                  'images/asd.jpeg',
                  height: 200.0,
                ),
                SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  height: sizedBoxHeightTextF,
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: sizedBoxHeightTextF,
                        child: TextField(
                          controller: _StoreName,
                          decoration: InputDecoration(
                            hintText: 'Store Name',
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
                          keyboardType: TextInputType.emailAddress,
                          // decoration: kTextfiledDecoration.copyWith(
                          // hintText: 'Enter your password'
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        height: sizedBoxHeightTextF,
                        child: TextField(
                          controller: _StoreType,
                          decoration: InputDecoration(
                            hintText: 'Store Type',
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
                          keyboardType: TextInputType.emailAddress,
                          // decoration: kTextfiledDecoration.copyWith(
                          // hintText: 'Enter your password'
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                SizedBox(
                  height: sizedBoxHeightTextF,
                  child: TextField(
                    controller: _StoreAddress,
                    decoration: InputDecoration(
                      hintText: 'Store Address',
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
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      '+962',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 8),
                    SizedBox(
                      width: 280,
                      height: sizedBoxHeightTextF,
                      child: TextField(
                        controller: _MobileNumber,
                        decoration: InputDecoration(
                          hintText: 'Mobile Number',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
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
                SizedBox(height: 8),
                SizedBox(
                  height: sizedBoxHeightTextF,
                  child: TextField(
                    controller: _EmailSupport,
                    decoration: InputDecoration(
                      hintText: 'Support Email',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                ButtonPadding(
                  buttonName: 'Submit Details'.toUpperCase(),
                  buttonColor: Color(0xFF5E57A5),
                  onPressed: () {
                    setState(() {
                      fillinfoo();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
