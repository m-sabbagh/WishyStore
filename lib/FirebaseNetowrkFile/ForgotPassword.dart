import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wishy_store/Screens/HomePage.dart';
import 'package:wishy_store/Screens/LogInPage.dart';
import 'package:wishy_store/Widgets/buttonPadding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wishy_store/Widgets/LogInToast.dart';
import 'package:wishy_store/constants.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  static String id = 'forgot_password';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

final _emailcontroller = TextEditingController();

void dispose() {
  _emailcontroller.dispose();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailcontroller.text.trim());
      setState(() {
        _emailcontroller.clear();
        Alert(
                context: context,
                buttons: [
                  DialogButton(
                    color: Color(0xFF5E57A5),
                    child: Text(
                      "OK",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    width: 120,
                  )
                ],
                title: "Email Sent",
                desc: "Check your email to reset your password")
            .show();
      });
    } on FirebaseAuthException catch (e) {
      if (_emailcontroller.text.isEmpty == true) {
        FlutterToastErorrStyle("Please fill all the fields");
      } else if (e.code == 'user-not-found') {
        FlutterToastErorrStyle("No user found for that email.");
      } else
        FlutterToastErorrStyle("Wrong input");
    }
  }

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Please enter your email to reset your password',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 45.0,
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
                      color: kTextFieldColor,
                      width: 2.0,
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            ButtonPadding(
              buttonName: 'Send',
              buttonColor: kButtonColor,
              onPressed: () {
                resetPassword();
              },
            ),
          ],
        ),
      ),
    );
  }
}
