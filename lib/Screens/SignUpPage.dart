import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wishy_store/Widgets/buttonPadding.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomePage.dart';
import 'package:wishy_store/Widgets/LogInToast.dart';
import 'package:wishy_store/StoreOwnerPage.dart';

class SignUpPage extends StatefulWidget {
  static String id = 'signUpPage_screen';

  @override
  State<SignUpPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignUpPage> {
  @override
  // // EmailVerficationPage obj = EmailVerficationPage();
  // bool isVerfied = false;
  //
  // void setState(VoidCallback fn) {
  //   super.setState(fn);
  //   // isVerfied = FirebaseAuth.instance.currentUser!.emailVerified;
  //
  //   if (isVerfied == false) {
  //     FirebaseAuth.instance.currentUser!.sendEmailVerification();
  //     Timer.periodic(Duration(seconds: 3), (timer) {
  //       if (FirebaseAuth.instance.currentUser!.emailVerified) {
  //         // isVerfied = true;
  //         timer.cancel();
  //       }
  //     });
  //   }
  // }
  //verfication

  CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool showSpinner = false;
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  RegExp email_valid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+");

  final _auth = FirebaseAuth.instance;
  final _firstNamecontroller = TextEditingController();
  final _lastNamecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmPasswordcontroller = TextEditingController();
  //text filed sizedBox height named as sizedBoxHeightTextF
  double sizedBoxHeightTextF = 45.0;
  String? selecteditem;

  var items = [
    'User',
    'Store Owner',
  ];

  void signup() async {
    try {
      if (_passwordcontroller.text.isEmpty == true ||
          _emailcontroller.text.isEmpty == true ||
          _firstNamecontroller.text.isEmpty == true ||
          _lastNamecontroller.text.isEmpty == true ||
          selecteditem.toString().isEmpty == true ||
          _confirmPasswordcontroller.text.isEmpty == true) {
        FlutterToastErorrStyle("Please fill all the fields");
        setState(() {
          showSpinner = false;
        });
      } else if (_passwordcontroller.text.length < 8) {
        FlutterToastErorrStyle("Password must be at least 8 characters");
        setState(() {
          showSpinner = false;
        });
      } else if (_passwordcontroller.text != _confirmPasswordcontroller.text) {
        FlutterToastErorrStyle("Password and Confirm Password must be same");
        setState(() {
          showSpinner = false;
        });
      } else if (pass_valid.hasMatch(_passwordcontroller.text) == false) {
        Fluttertoast.showToast(
            msg:
                'Password must contain at least one uppercase letter, one lowercase letter, one number and one special character',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          showSpinner = false;
        });
      } else if (email_valid.hasMatch(_emailcontroller.text) == false) {
        FlutterToastErorrStyle("Please enter a valid email");
        setState(() {
          showSpinner = false;
        });
      } else if (_passwordcontroller.text == _confirmPasswordcontroller.text &&
          pass_valid.hasMatch(_passwordcontroller.text) == true &&
          _passwordcontroller.text.length >= 8 &&
          email_valid.hasMatch(_emailcontroller.text) == true) {
        await _auth.createUserWithEmailAndPassword(
            email: _emailcontroller.text.trim(),
            password: _passwordcontroller.text.toString());
        collection.add({
          'email': _emailcontroller.text,
          'password': _passwordcontroller.text,
          'firstName': _firstNamecontroller.text,
          'lastName': _lastNamecontroller.text,
          'userType': selecteditem,
        });
        if (selecteditem == 'User') {
          Navigator.pushNamed(context, HomePage.id);
        } else if (selecteditem == 'Store Owner') {
          Navigator.pushNamed(context, StoreOwnerPage.id);
        }
        setState(() {
          showSpinner = false;
        });
        clearallfields();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        FlutterToastErorrStyle("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        FlutterToastErorrStyle("The account already exists for that email.");
      } else if (e.code == 'user-not-found') {
        FlutterToastErorrStyle("No user found for that email.");
        setState(() {
          showSpinner = false;
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          showSpinner = false;
        });
        FlutterToastErorrStyle("Wrong password provided for that user.");
      } else
        FlutterToastErorrStyle("Wrong input");
      setState(() {
        showSpinner = false;
      });
    }
  }

  void clearallfields() {
    _emailcontroller.clear();
    _passwordcontroller.clear();
    _firstNamecontroller.clear();
    _lastNamecontroller.clear();
    selecteditem = null;
    _confirmPasswordcontroller.clear();
    _formKey.currentState!.reset();
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
                  'images/wishyStoreicon.jpeg',
                  height: 200.0,
                ),
                SizedBox(
                  height: 30.0,
                ),
                SizedBox(
                  height: sizedBoxHeightTextF,
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
                      hint: Text('I am a'),
                      underline: Container(),
                      items: items.map((item) {
                        return DropdownMenuItem(
                          child: Text(item),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value == 'User') {
                            value = items[0];
                            selecteditem = value.toString() ?? 'User';
                          } else if (value == 'Store Owner') {
                            value = items[1];
                            selecteditem = value.toString() ?? 'Store Owner';
                          }
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: sizedBoxHeightTextF,
                        child: TextField(
                          controller: _firstNamecontroller,
                          decoration: InputDecoration(
                            hintText: 'First Name',
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
                          controller: _lastNamecontroller,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
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
                    controller: _emailcontroller,
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
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
                SizedBox(
                  height: sizedBoxHeightTextF,
                  child: TextField(
                    controller: _passwordcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
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
                SizedBox(height: 8),
                SizedBox(
                  height: sizedBoxHeightTextF,
                  child: TextField(
                    controller: _confirmPasswordcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
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
                SizedBox(height: 8.0),
                Text(
                  'Use 8 or more characters with a mix of letters, numbers & symbols',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                ButtonPadding(
                  buttonName: 'Sign Up',
                  buttonColor: Color(0xFF5E57A5),
                  onPressed: () {
                    //check if the email and password are valid
                    // obj.verfiedEmail(
                    //     _emailcontroller.text,
                    //     _passwordcontroller.text,
                    //     _auth,
                    //     firstName,
                    //     lastName,
                    //     context,
                    //     _formKey,
                    //     isVerfied
                    //     // selecteditem,
                    //     );
                    // verfication
                    setState(() {
                      showSpinner = true;
                    });
                    signup();
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

// // if (_confirmPasswordcontroller != _passwordcontroller) {
// //     //   FlutterToastErorrStyle("Password does not match");
// //     // }
// //     // else{
// //     //   try {
// //     //     final newUser = await _auth.createUserWithEmailAndPassword(
// //     //         email: _emailcontroller.text.trim(),
// //     //         password: _passwordcontroller.text.trim());
// //     //     if (newUser != null) {
// //     //       Navigator.pushNamed(context, HomePage.id);
// //     //     }
// //     //   } on FirebaseAuthException catch (e) {
// //     //     if (_passwordcontroller.text.isEmpty == true ||
// //     //         _emailcontroller.text.isEmpty == true) {
// //     //       FlutterToastErorrStyle("Please fill all the fields");
// //     //       setState(() {
// //     //         showSpinner = false;
// //     //       });
// //     //     } else if (e.code == 'weak-password') {
// //     //       FlutterToastErorrStyle("The password provided is too weak.");
// //     //       setState(() {
// //     //         showSpinner = false;
// //     //       });
// //     //     } else if (e.code == 'email-already-in-use') {
// //     //       FlutterToastErorrStyle("The account already exists for that email.");
// //     //       setState(() {
// //     //         showSpinner = false;
// //     //       });
// //     //     } else
// //     //       FlutterToastErorrStyle("Wrong input");
// //     //     setState(() {
// //     //       showSpinner = false;
// //     //     });
// //     //   }
// //     // }

// Container(
//                 //       padding: EdgeInsets.only(left: 20, right: 16),
//                 //       alignment: Alignment.center,
//                 //       decoration: BoxDecoration(
//                 //         border: Border.all(color: Colors.grey, width: 2.0),
//                 //         borderRadius: BorderRadius.circular(10),
//                 //       ),
//                 //       child: DropdownSearch<String>(
//                 //         selectedItem: _selectedItemcontroller.text,
//                 //         onChanged: (v) {
//                 //           _selectedItemcontroller.text = v!;
//                 //         },
//                 //
//                 //         popupProps: PopupProps.menu(
//                 //           // searchFieldProps: TextFieldProps(
//                 //           //   controller: _selectedItemcontroller,
//                 //           //   decoration: InputDecoration(
//                 //           //     border: OutlineInputBorder(),
//                 //           //     labelText: "Search",
//                 //           //   ),
//                 //           // ),
//                 //           fit: FlexFit.values[1],
//                 //           showSelectedItems: true,
//                 //         ),
//                 //         items: [
//                 //           "User",
//                 //           "Store Owner",
//                 //         ],
//                 //         dropdownDecoratorProps: DropDownDecoratorProps(
//                 //           dropdownSearchDecoration: InputDecoration(
//                 //             labelText: "I am a",
//                 //             // hintText: "country in menu mode",
//                 //           ),
//                 //         ),
//                 //         // onChanged: print,
//                 //         // selectedItem: "Brazil",
//                 //       ),
//                 //     )),
