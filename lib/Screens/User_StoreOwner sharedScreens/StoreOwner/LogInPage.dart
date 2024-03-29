import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wishy_store/Screens/UserScreens/UserNavBar.dart';
import 'package:wishy_store/Screens/User_StoreOwner%20sharedScreens/StoreOwner/StoreOwnerSignUp.dart';
import 'package:wishy_store/StoreOwner/StoreOwnerNavBar.dart';
import 'package:wishy_store/Widgets/buttonPadding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'UserSignUpPage.dart';
import 'package:wishy_store/Widgets/ErrorToast.dart';
import 'package:wishy_store/constants.dart';
import 'package:wishy_store/FirebaseNetowrkFile/ForgotPassword.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  bool? isFilled;
  bool? isGranted;
  void clearallfields() {
    _emailcontroller.clear();
    _passwordcontroller.clear();
  }

  getUserTyoe() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      if ('${value['userType']}' == 'StoreOwner') {
        //you got 2 chocices , if granted or not
        if (value['storeOwnerGranted'] == false) {
          //change it to alert
          setState(() {
            showSpinner = false;
            Alert(
                context: context,
                title: "Welcome to WishyStore ",
                style: AlertStyle(
                  backgroundColor: Colors.white,
                  titleStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Your request is still pending , please contact us for more information at wishystore@support.jo ',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        // color: Colors.black,
                      ),
                    ),
                  ],
                ),
                buttons: [
                  DialogButton(
                    color: Color(0xFF5E57A5),
                    onPressed: () {
                      setState(() {
                        FirebaseAuth.instance.signOut();
                      });
                      clearallfields();

                      Navigator.pop(context);
                    },
                    child: Text(
                      "Done",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          });
        } else if (value['storeOwnerGranted'] == true) {
          Navigator.pushNamedAndRemoveUntil(
              context, StoreOwnerNavBar.id, (route) => false);
        } else
          CustomFlutterToast_Error(
              message: "Something went wrong", toastLength: Toast.LENGTH_SHORT);
      } else if ('${value['userType']}' == 'User') {
        Navigator.pushNamedAndRemoveUntil(
            context, NavigationBarForUser.id, (route) => false);
      }
    });
  }

  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Future LogIn() async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _passwordcontroller.text.toString());
      if (user != null) {
        getUserTyoe();
      }
    } on FirebaseAuthException catch (e) {
      if (_passwordcontroller.text.isEmpty == true ||
          _emailcontroller.text.isEmpty == true) {
        CustomFlutterToast_Error(
            message: "Please fill all the fields",
            toastLength: Toast.LENGTH_SHORT);
        setState(() {
          showSpinner = false;
        });
      } else if (e.code == 'user-not-found') {
        CustomFlutterToast_Error(
            message: "No user found for that email.",
            toastLength: Toast.LENGTH_SHORT);
        setState(() {
          showSpinner = false;
        });
      } else if (e.code == 'wrong-password') {
        setState(() {
          showSpinner = false;
        });
        CustomFlutterToast_Error(
            message: "Wrong password provided for that user.",
            toastLength: Toast.LENGTH_SHORT);
      } else
        CustomFlutterToast_Error(
            message: "Wrong input", toastLength: Toast.LENGTH_SHORT);
      setState(() {
        showSpinner = false;
      });
    }
  }

  double sizedBoxHeightTextF = 45.0;
  bool showSpinner = false;
  bool isVisable = true;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(
                  'images/wishyStoreicon.jpeg',
                  height: 200.0,
                ),
                SizedBox(
                  height: 30.0,
                ),
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
                          color: kTextFieldColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                SizedBox(
                  height: sizedBoxHeightTextF,
                  child: TextField(
                    controller: _passwordcontroller,
                    obscureText: isVisable,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        splashRadius: 20.0,
                        icon: Icon(
                          isVisable == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            if (isVisable == true) {
                              isVisable = false;
                            } else {
                              isVisable = true;
                            }
                          });
                        },
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      // filled: true,
                      // fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: kTextFieldColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()));
                  },
                  child: Center(
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                ),
                ButtonPadding(
                  buttonName: 'Log in',
                  buttonColor: kButtonColor,
                  onPressed: () {
                    setState(() {
                      showSpinner = true;
                    });
                    LogIn();
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, UserSignUpPage.id);
                    },
                    style: TextButton.styleFrom(
                      side: BorderSide(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: Container(
                      height: 30.0,
                      child: Center(
                        child: Text(
                          'Create account',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: TextButton(
                    onPressed: () async {
                      Navigator.pushNamed(context, StoreOwnerSignUp.id);
                    },
                    style: TextButton.styleFrom(
                      side: BorderSide(
                          color: Colors.black,
                          width: 1,
                          style: BorderStyle.solid),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: Container(
                      height: 30.0,
                      child: Center(
                        child: Text(
                          'Join as a store owner',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
