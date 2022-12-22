import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:wishy_store/Screens/User/StoreOwner%20shared%20screens/NavigationBAR.dart';
import 'package:wishy_store/Widgets/buttonPadding.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../StoreOwnerPage.dart';
import 'SignUpPage.dart';
import 'package:wishy_store/Widgets/ErrorToast.dart';
import 'package:wishy_store/constants.dart';
import 'package:wishy_store/FirebaseNetowrkFile/ForgotPassword.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  getusertype() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      if (value.data()!['userType'] == 'User') {
        Navigator.pushNamed(context, NavigationBarsssss.id);
      }
    });
    FirebaseFirestore.instance
        .collection('StoreOwners')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) {
      if (value.data()!['userType'] == 'StoreOwner') {
        Navigator.pushNamed(context, StoreOwnerPage.id);
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
        Navigator.pushNamed(context, NavigationBarsssss.id);
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

  // Future<void> signInWithGoogle(BuildContext context) async {
  //   try {
  //     if (kIsWeb) {
  //       GoogleAuthProvider googleProvider = GoogleAuthProvider();
  //
  //       googleProvider
  //           .addScope('https://www.googleapis.com/auth/contacts.readonly');
  //
  //       await _auth.signInWithPopup(googleProvider);
  //     } else {
  //       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //       final GoogleSignInAuthentication? googleAuth =
  //           await googleUser?.authentication;
  //
  //       if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
  //         // Create a new credential
  //         final credential = GoogleAuthProvider.credential(
  //           accessToken: googleAuth?.accessToken,
  //           idToken: googleAuth?.idToken,
  //         );
  //         UserCredential userCredential =
  //             await _auth.signInWithCredential(credential);
  //
  //         // if you want to do specific task like storing information in firestore
  //         // only for new users using google sign in (since there are no two options
  //         // for google sign in and google sign up, only one as of now),
  //         // do the following:
  //
  //         // if (userCredential.user != null) {
  //         //   if (userCredential.additionalUserInfo!.isNewUser) {}
  //         // }
  //       }
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     FlutterToastErorrStyle(e.message!); // Displaying the error message
  //   }
  // }

  //text filed sizedBox height named as sizedBoxHeightTextF
  double sizedBoxHeightTextF = 45.0;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 48.0,
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
                    obscureText: true,
                    decoration: InputDecoration(
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
                ButtonPadding(
                  buttonName: 'Create account',
                  buttonColor: kButtonColor,
                  onPressed: () async {
                    Navigator.pushNamed(context, SignUpPage.id);
                  },
                ),
                Center(
                  child: Text(
                    'or connect with',
                    style: TextStyle(),
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () {
                    GoogleSignIn().signIn();
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
