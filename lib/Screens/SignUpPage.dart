import 'package:flutter/material.dart';
import 'package:wishy_store/Widgets/buttonPadding.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:wishy_store/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'HomePage.dart';

class SignUpPage extends StatefulWidget {
  static String id = 'signUpPage_screen';

  @override
  State<SignUpPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SignUpPage> {
  @override
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String firstName;
  String lastName;
  String email;
  String password;
  String confirmPassword;
  //text filed sizedBox height named as sizedBoxHeightTextF
  double sizedBoxHeightTextF = 45.0;
  String selecteditem;
  var items = [
    'User',
    'Store Owner',
  ];

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
                            selecteditem = value;
                          } else if (value == 'Store Owner') {
                            value = items[1];
                            selecteditem = value;
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
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            firstName = value;
                          },
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
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey,
                                width: 2.0,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            lastName = value;
                          },
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
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2.0,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: sizedBoxHeightTextF,
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        height: sizedBoxHeightTextF,
                        child: TextField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          onChanged: (value) {
                            if (password == value) {
                              print('password is correct');
                              confirmPassword = value;
                            } else {
                              //package pop up password doesnt match
                              print('password is not correct');
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                ButtonPadding(
                  buttonName: 'Sign Up',
                  buttonColor: Color(0xFF5E57A5),
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, HomePage.id);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
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
