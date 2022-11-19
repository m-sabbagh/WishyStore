// import 'dart:ffi';
//
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:wishy_store/FirebaseNetowrkFile/allUser.dart';
// import 'package:wishy_store/Screens/HomePage.dart';
// import 'package:wishy_store/Widgets/LogInToast.dart';
//
// class EmailVerficationPage extends StatefulWidget {
//   void verfiedEmail(
//       String email,
//       String password,
//       FirebaseAuth _auth,
//       String firstName,
//       String lastName,
//       BuildContext context,
//       GlobalKey<FormState> _formKey,
//       bool isVerified)
//   async {
//     if (_formKey.currentState!.validate()) {
//       await _auth
//           .createUserWithEmailAndPassword(email: email, password: password)
//           .then((value) => {
//                 postDetailsToFirestore(email, password, _auth, firstName,
//                     lastName, context, isVerified
//                     // selectedItem
//                     )
//               })
//           .catchError((e) {
//         Fluttertoast.showToast(msg: e!.message);
//       });
//     }
//   }
//
//   postDetailsToFirestore(
//     String email,
//     String password,
//     FirebaseAuth _auth,
//     String firstName,
//     String lastName,
//     BuildContext context,
//     bool isVerfied,
//     // selectedItem
//   ) async {
//     FirebaseFirestore db = FirebaseFirestore.instance;
//     User? user = await _auth.currentUser;
//     Alluser alluser = Alluser();
//     alluser.firstname = firstName;
//     alluser.Lastname = lastName;
//     alluser.email = user!.email;
//
//     await db.collection('alluser').doc(user.uid).set(alluser.toMap());
//     Fluttertoast.showToast(msg: 'Verification email sent');
//
//     if (email == db.collection('alluser').doc(user.email).get()) {
//       Fluttertoast.showToast(msg: 'Email already exists');
//       Navigator.pop(context);
//       ;
//     }
//     isVerfied = FirebaseAuth.instance.currentUser!.emailVerified;
//     if (!isVerfied) {
//       FirebaseAuth.instance.currentUser!.sendEmailVerification();
//       Timer.periodic(Duration(seconds: 3), (timer) {
//         if (FirebaseAuth.instance.currentUser!.emailVerified) {
//           timer.cancel();
//           Fluttertoast.showToast(
//               msg: "Verification Email Sent",
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.BOTTOM,
//               timeInSecForIosWeb: 1,
//               backgroundColor: Colors.black,
//               textColor: Colors.white,
//               fontSize: 16.0);
//         }
//       });
//     }
//     Navigator.pushReplacement(
//         context, MaterialPageRoute(builder: (context) => HomePage()));
//     if (isVerfied) {
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage()),
//         (Route<dynamic> route) => false,
//       );
//     }
//   }
//
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }
// }
