import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wishy_store/FirebaseNetowrkFile/UsersCollection.dart';
import 'package:wishy_store/FirebaseNetowrkFile/StoreOwnersCollection.dart';
import 'package:wishy_store/Screens/User_StoreOwner%20sharedScreens/StoreOwner/LogInPage.dart';

import 'package:wishy_store/Widgets/buttonPadding.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wishy_store/Widgets/ErrorToast.dart';

class StoreOwnerSignUp extends StatefulWidget {
  static String id = 'StoreOwnerSignUp';

  @override
  State<StoreOwnerSignUp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StoreOwnerSignUp> {
  void requestToAddTheStore() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    User? user = await _auth.currentUser;
    UsersCollection usersCollection = UsersCollection();
    StoreOwnersCollection storeOwnersCollection = StoreOwnersCollection();

    storeOwnersCollection.firstname = _firstNamecontroller.text;
    storeOwnersCollection.lastname = _lastNamecontroller.text;
    storeOwnersCollection.email = _emailcontroller.text;
    storeOwnersCollection.password = _passwordcontroller.text;
    storeOwnersCollection.userType = 'StoreOwner';
    storeOwnersCollection.uId = user!.uid;
    storeOwnersCollection.storeOwnerGranted = false;
    storeOwnersCollection.storeType = selectedStoreType.toString();
    storeOwnersCollection.storeName = _storeName.text;
    storeOwnersCollection.phoneNumber = _phonecontroller.text;
    storeOwnersCollection.supportEmail = _supportEmailAddress.text;
    storeOwnersCollection.categories = {};

    await db
        .collection('StoreOwners')
        .doc(user.uid)
        .set(storeOwnersCollection.toMap());

    usersCollection.firstname = _firstNamecontroller.text;
    usersCollection.lastname = _lastNamecontroller.text;
    usersCollection.email = _emailcontroller.text;
    usersCollection.password = _passwordcontroller.text;
    usersCollection.userType = 'StoreOwner';
    usersCollection.uId = user.uid;
    await db.collection('Users').doc(user.uid).set(usersCollection.toMap());

    // await db.collection(selectedStoreType.toString()).doc(user!.uid).set({
    // 'uid': user.uid,
    // 'email address': _emailcontroller.text,
    // 'store name': _storeName.text,
    // 'store type': selectedStoreType,
    // 'phone number': _phonecontroller.text,
    // 'support email address': _supportEmailAddress.text,
    // 'categories': {},
    // "storeOwnerGranted": false,

    // 'store owner name':
    //     _firstNamecontroller.text + " " + _lastNamecontroller.text,
    // 'store owner email address': _emailcontroller.text,
    // 'store owner phone number': _phonecontroller.text,
    // 'store owner password': _passwordcontroller.text,
    // 'store owner uid': user.uid,
    // 'store owner profile picture': user.photoURL,
    // 'store owner store name': _storeName.text,
    // 'store owner support email address': _supportEmailAddress.text,
    // 'store owner store type': selectedStoreType,
    // 'store owner store owner name':
    //     _firstNamecontroller.text + " " + _lastNamecontroller.text,
    // 'store owner store owner email address': _emailcontroller.text,
    // });
  }

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

  final _storeName = TextEditingController();
  final _supportEmailAddress = TextEditingController();
  final _phonecontroller = TextEditingController();

  //text filed sizedBox height named as sizedBoxHeightTextF
  double sizedBoxHeightTextF = 45.0;

  List<String> storeTypes = <String>[
    'Retail store',
    'Health and Beauty store',
    'Gift centers store',
    'Fitness store',
    'Clothing store',
    'Jewelry store',
  ];

  String? selectedStoreType;

  void submitDetails() async {
    try {
      if (_passwordcontroller.text.isEmpty == true ||
          _emailcontroller.text.isEmpty == true ||
          _firstNamecontroller.text.isEmpty == true ||
          _lastNamecontroller.text.isEmpty == true ||
          selectedStoreType.toString().isEmpty == true ||
          _confirmPasswordcontroller.text.isEmpty == true ||
          _storeName.text.isEmpty == true ||
          _supportEmailAddress.text.isEmpty == true ||
          _phonecontroller.text.isEmpty == true) {
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
      } else if (email_valid.hasMatch(_supportEmailAddress.text) == false) {
        CustomFlutterToast_Error(
            message: "Please enter a valid email",
            toastLength: Toast.LENGTH_SHORT);
        setState(() {
          showSpinner = false;
        });
      } else if (_phonecontroller.text.length != 9 ||
          // _phonecontroller.text.startsWith('0') == true ||
          !_phonecontroller.text.startsWith('7') == true) {
        CustomFlutterToast_Error(
            message: "Please enter a valid phone number",
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
            .then((value) => requestToAddTheStore());

        // if (selectedUser == 'User') {
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, UserHomePage.id, (route) => false);
        // }
        // else if (selectedUser == 'Store Owner') {
        //   // Navigator.pushNamed(context, StoreOwnerPage.id);
        //   Navigator.pushNamedAndRemoveUntil(
        //       context, FillingInformation.id, (route) => false);
        // }
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
                            'Your request has been sent successfully , we will contact you through your email soon for more details contact us wishystore@support.jo',
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
    _phonecontroller.clear();
    _storeName.clear();
    _supportEmailAddress.clear();

    selectedStoreType = null;

    _confirmPasswordcontroller.clear();
  }

  bool isVisiblePassword = true;
  bool isVisibleConfirm = true;

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'images/wishyStoreicon.jpeg',
                  height: 160.0,
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
                            hintText: 'First name',
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
                            hintText: 'Last name',
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

                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: sizedBoxHeightTextF,
                        child: TextField(
                          controller: _storeName,
                          decoration: InputDecoration(
                            hintText: 'Store name',
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
                  ],
                ),

                SizedBox(height: 8),

                SizedBox(
                  height: 45,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade400, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButton<String>(
                      onChanged: (String? value) {
                        setState(() {
                          selectedStoreType = value!;
                          selectedStoreType = value.toString();

                          // for (var i = 0; i < items.length; i++) {
                          //   if (items[i] == value) {
                          //     selecteditem = items[i];
                          //     value = items[i];
                          //   }
                          // }
                        });
                      },
                      hint: Text('Select Store Type'),
                      value: selectedStoreType,
                      isExpanded: true,
                      underline: Container(),
                      items: storeTypes
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
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
                        controller: _phonecontroller,
                        decoration: InputDecoration(
                          hintText: 'Mobile number',
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
                    controller: _supportEmailAddress,
                    decoration: InputDecoration(
                      hintText: 'Support email',
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
                    controller: _passwordcontroller,
                    obscureText: isVisiblePassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        splashRadius: 20.0,
                        icon: Icon(
                          isVisiblePassword == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            if (isVisiblePassword == true) {
                              isVisiblePassword = false;
                            } else {
                              isVisiblePassword = true;
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
                    obscureText: isVisibleConfirm,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        splashRadius: 20.0,
                        icon: Icon(
                          isVisibleConfirm == true
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            if (isVisibleConfirm == true) {
                              isVisibleConfirm = false;
                            } else {
                              isVisibleConfirm = true;
                            }
                          });
                        },
                      ),
                      hintText: 'Confirm password',
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
                  buttonName: 'Submit Details'.toUpperCase(),
                  buttonColor: Color(0xFF5E57A5),
                  onPressed: () {
                    setState(() {
                      showSpinner = true;
                      submitDetails();

                      // fillinfoo();
                    });
                  },
                ),
                // ButtonPadding(
                //   buttonName: 'Sign Up',
                //   buttonColor: Color(0xFF5E57A5),
                //   onPressed: () {
                //     //check if the email and password are valid
                //     // obj.verfiedEmail(
                //     //     _emailcontroller.text,
                //     //     _passwordcontroller.text,
                //     //     _auth,
                //     //     firstName,
                //     //     lastName,
                //     //     context,
                //     //     _formKey,
                //     //     isVerfied
                //     //     // selecteditem,
                //     //     );
                //     // verfication
                //     setState(() {
                //       // showSpinner = true;
                //     });
                //     // Navigator.push(
                //     //     context, MaterialPageRoute(builder: (context) => pv()));
                //     // signup();
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
