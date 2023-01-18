import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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

  getusertype() {
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
            showDialog(
                context: context,
                builder: (context) => Dialog(
                      child: Container(
                        height: 300,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Your request is still pending , please wait for the admin to grant you access',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    FirebaseAuth.instance.signOut();
                                  });
                                  clearallfields();

                                  Navigator.pop(context);
                                },
                                child: Text('OK'))
                          ],
                        ),
                      ),
                    ));
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

//from up there
      //   Navigator.pushNamedAndRemoveUntil(
      //       context, NavigationBarsssss.id, (route) => false);
      // }
      //     //    Navigator.pushNamedAndRemoveUntil(
      //     // context, StoreOwnerPage.id, (route) => false);

      // }
    });
    // if (isFilled == false) {
    //   Navigator.pushNamedAndRemoveUntil(
    //       context, StoreOwnerNavBar.id, (route) => false);
    // } else if (isGranted == false) {
    //   CustomFlutterToast_Error(
    //       message: "Your request is still pending",
    //       toastLength: Toast.LENGTH_SHORT);
    // } else {
    //   //seniro ele rah yadwik 3ala el store owner page

    // }

    // FirebaseFirestore.instance
    //     .collection('StoreOwners')
    //     .doc(_auth.currentUser!.uid)
    //     .get()
    //     .then((value) {
    // });
  }

  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  // if(getusertype()=='Store Owner'){
  //   Navigator.pushNamed(context, StoreOwnerPage.id);
  // }
  // else if(getusertype()=='User'){
  //   Navigator.pushNamed(context, NavigationBarsssss.id);
  // }
  @override
  Future LogIn() async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: _emailcontroller.text.trim(),
          password: _passwordcontroller.text.toString());
      if (user != null) {
        getusertype();
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
