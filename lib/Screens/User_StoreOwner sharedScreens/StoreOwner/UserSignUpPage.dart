import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wishy_store/FirebaseNetowrkFile/Collections/UsersCollection.dart';
import 'package:wishy_store/Screens/UserScreens/UserNavBar.dart';
import 'package:wishy_store/Widgets/buttonPadding.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wishy_store/Widgets/ErrorToast.dart';

class UserSignUpPage extends StatefulWidget {
  static String id = 'signUpPage_screen';

  @override
  State<UserSignUpPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<UserSignUpPage> {
  void addNewUser() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = await _auth.currentUser;
    UsersCollection usersCollection = UsersCollection();

    // if (selectedUser == 'Store Owner') {
    //   storeOwnersCollection.firstname = _firstNamecontroller.text;
    //   storeOwnersCollection.lastname = _lastNamecontroller.text;
    //   storeOwnersCollection.email = _emailcontroller.text;
    //   storeOwnersCollection.password = _passwordcontroller.text;
    //   storeOwnersCollection.userType = selectedUser;
    //   storeOwnersCollection.uId = user!.uid;
    //   storeOwnersCollection.infoFilled = false;
    //   storeOwnersCollection.storeOwnerGranted = false;

    //   await db
    //       .collection('StoreOwners')
    //       .doc(user.uid)
    //       .set(storeOwnersCollection.toMap());
    // }

    usersCollection.firstname = _firstNamecontroller.text;
    usersCollection.lastname = _lastNamecontroller.text;
    usersCollection.email = _emailcontroller.text;
    usersCollection.password = _passwordcontroller.text;
    usersCollection.userType = 'User';
    usersCollection.uId = user!.uid;
    await db.collection('Users').doc(user.uid).set(usersCollection.toMap());

    // if (selectedUser == 'User') {
    await db.collection('wishlists').doc(user.uid).set({
      'uid': user.uid,
      'email address': _emailcontroller.text,
      'userWishlists': {},
      "sharedWishlistsFromUsers": {}
    });
    // }

    // if(selecteditem=='storeOwner'){
    //   //for admin area
    // }
  }

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
  // String? selectedUser;

  var userType = [
    'User',
    'Store Owner',
  ];

  void signup() async {
    try {
      if (_passwordcontroller.text.isEmpty == true ||
          _emailcontroller.text.isEmpty == true ||
          _firstNamecontroller.text.isEmpty == true ||
          _lastNamecontroller.text.isEmpty == true ||
          _confirmPasswordcontroller.text.isEmpty == true) {
        CustomFlutterToast_Error(
            message: "Please fill all the fields",
            toastLength: Toast.LENGTH_SHORT);
        setState(() {
          showSpinner = false;
        });
      } else if (_passwordcontroller.text.length < 8) {
        CustomFlutterToast_Error(
            message: "Password must be at least 8 characters",
            toastLength: Toast.LENGTH_SHORT);
        setState(() {
          showSpinner = false;
        });
      } else if (_passwordcontroller.text.length > 30) {
        CustomFlutterToast_Error(
            message: "Password must be at most 30 characters",
            toastLength: Toast.LENGTH_SHORT);
        setState(() {
          showSpinner = false;
        });
      } else if (_emailcontroller.text.length > 50) {
        CustomFlutterToast_Error(
            message: "Email must be at most 50 characters",
            toastLength: Toast.LENGTH_SHORT);
        setState(() {
          showSpinner = false;
        });
      } else if (_emailcontroller.text.length < 16) {
        CustomFlutterToast_Error(
            message: "Email must be at least 16 characters",
            toastLength: Toast.LENGTH_SHORT);
        setState(() {
          showSpinner = false;
        });
      } else if (_firstNamecontroller.text.length > 20) {
        CustomFlutterToast_Error(
            message: "First Name must be at most 20 characters",
            toastLength: Toast.LENGTH_SHORT);
        setState(() {
          showSpinner = false;
        });
      } else if (_firstNamecontroller.text.length < 3) {
        CustomFlutterToast_Error(
            message: "First Name must be at least 3 characters",
            toastLength: Toast.LENGTH_SHORT);
        setState(() {
          showSpinner = false;
        });
      } else if (_lastNamecontroller.text.length > 20) {
        CustomFlutterToast_Error(
            message: "Last Name must be at most 20 characters",
            toastLength: Toast.LENGTH_SHORT);
        setState(() {
          showSpinner = false;
        });
      } else if (_lastNamecontroller.text.length < 3) {
        CustomFlutterToast_Error(
            message: "Last Name must be at least 3 characters",
            toastLength: Toast.LENGTH_SHORT);
        setState(() {
          showSpinner = false;
        });
      } else if (_passwordcontroller.text != _confirmPasswordcontroller.text) {
        CustomFlutterToast_Error(
            message: "Password and Confirm Password must be same",
            toastLength: Toast.LENGTH_SHORT);
        setState(() {
          showSpinner = false;
        });
      } else if (pass_valid.hasMatch(_passwordcontroller.text) == false) {
        Fluttertoast.showToast(
            msg: 'Password is too weak',
            // must contain at least one uppercase letter, one lowercase letter, one number and one special character
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
        CustomFlutterToast_Error(
            message: "Please enter a valid email",
            toastLength: Toast.LENGTH_SHORT);
        setState(() {
          showSpinner = false;
        });
      } else if (_passwordcontroller.text == _confirmPasswordcontroller.text &&
          pass_valid.hasMatch(_passwordcontroller.text) == true &&
          _passwordcontroller.text.length >= 8 &&
          email_valid.hasMatch(_emailcontroller.text) == true) {
        await _auth
            .createUserWithEmailAndPassword(
                email: _emailcontroller.text.trim(),
                password: _passwordcontroller.text.toString())
            .then((value) => addNewUser());
        // collection.add({
        //   'email': _emailcontroller.text,
        //   'password': _passwordcontroller.text,
        //   'firstName': _firstNamecontroller.text,
        //   'lastName': _lastNamecontroller.text,
        //   'userType': selecteditem,
        //   'uid': _auth.currentUser!.uid,
        // });
        Navigator.pushNamedAndRemoveUntil(
            context, NavigationBarForUser.id, (route) => false);

        setState(() {
          showSpinner = false;
        });
        clearallfields();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomFlutterToast_Error(
            message: "The password provided is too weak.",
            toastLength: Toast.LENGTH_SHORT);
      } else if (e.code == 'email-already-in-use') {
        CustomFlutterToast_Error(
            message: "The account already exists for that email.",
            toastLength: Toast.LENGTH_SHORT);
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

  void clearallfields() {
    _emailcontroller.clear();
    _passwordcontroller.clear();
    _firstNamecontroller.clear();
    _lastNamecontroller.clear();
    _confirmPasswordcontroller.clear();
    _formKey.currentState!.reset();
  }

  bool isVisablePassword = true;
  bool isVisableConfirmPassword = true;
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: SizedBox(
            height: 700,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.asset(
                    'images/wishyStoreicon.jpeg',
                    height: 200.0,
                  ),
                  SizedBox(
                    height: 30.0,
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
                      obscureText: isVisablePassword,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          splashRadius: 20.0,
                          icon: Icon(
                            isVisablePassword == true
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isVisablePassword == true) {
                                isVisablePassword = false;
                              } else {
                                isVisablePassword = true;
                              }
                            });
                          },
                        ),
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
                      obscureText: isVisableConfirmPassword,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          splashRadius: 20.0,
                          icon: Icon(
                            isVisableConfirmPassword == true
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isVisableConfirmPassword == true) {
                                isVisableConfirmPassword = false;
                              } else {
                                isVisableConfirmPassword = true;
                              }
                            });
                          },
                        ),
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
      ),
    );
  }
}
