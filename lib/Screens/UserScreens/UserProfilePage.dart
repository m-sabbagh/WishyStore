import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../FirebaseNetowrkFile/ReadData/userData/GetUserName.dart';
import '../User/StoreOwner shared screens/LogInPage.dart';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);
  static String id = 'user_settings_page';

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

Future getImage() async {
  final image = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    imageQuality: 100,
    maxHeight: 512,
    maxWidth: 512,
  );
  Reference ref = FirebaseStorage.instance.ref().child('user_profile_image');
  await ref.putFile(File(image!.path));
  ref.getDownloadURL().then((value) async {
    await FirebaseAuth.instance.currentUser!.updatePhotoURL(value);
  });
}

Image backgroundimage() {
  if (FirebaseAuth.instance.currentUser!.photoURL != null) {
    return Image.network(FirebaseAuth.instance.currentUser!.photoURL!);
  } else {
    return Image.asset('images/user_defulat.png');
  }
}

class _UserProfilePageState extends State<UserProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String? oldPassword;
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  var firstname;
  var lastname;
  CollectionReference users = FirebaseFirestore.instance.collection('alluser');

  getpassword() {
    users.doc(user.uid).get().then((value) {
      setState(() {
        oldPassword = value['password'];
      });
    });
  }

  @override
  void initState() {
    getpassword();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('My Profile',
                style: TextStyle(color: Colors.white, fontSize: 30)),
            Row(
              children: [
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(
                //     EvaIcons.search,
                //     color: Colors.white,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 17, 14, 35),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 55,
                      backgroundImage: backgroundimage().image,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Center(
                        child: Text(
                          'Edit picture',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GetUserName(user.uid),
                    Text(
                      user.email!,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    ListTile(
                        title: const Text(
                          'Edit Profile',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                        leading: Icon(
                          Icons.person,
                          color: Color(0xFF5E57A5),
                        ),
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Edit Profile'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: 'Change first name',
                                        ),
                                        onChanged: (value) {
                                          firstname = value;
                                        },
                                      ),
                                      TextField(
                                        decoration: InputDecoration(
                                          hintText: 'change last name',
                                        ),
                                        onChanged: (value) {
                                          lastname = value;
                                        },
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel')),
                                    TextButton(
                                        onPressed: () {
                                          users.doc(user.uid).update({
                                            'firstname': firstname,
                                            'Lastname': lastname,
                                          });
                                          Navigator.pop(context);
                                        },
                                        child: Text('Save'))
                                  ],
                                );
                              });
                        }),
                    const Divider(
                      color: Colors.black,
                      thickness: 0.2,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      title: const Text(
                        'Change password',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Change Password'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: _oldPasswordController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your old password',
                                      ),
                                    ),
                                    TextField(
                                      controller: _newPasswordController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your new password',
                                      ),
                                    ),
                                    TextField(
                                      controller: _confirmPasswordController,
                                      decoration: InputDecoration(
                                        hintText: 'Confirm your new password',
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      if (_oldPasswordController.text ==
                                          oldPassword) {
                                        if (_newPasswordController.text ==
                                            _confirmPasswordController.text) {
                                          if (pass_valid.hasMatch(
                                              _newPasswordController.text)) {
                                            if (_newPasswordController
                                                    .text.length >=
                                                8) {
                                              users
                                                  .doc(user.uid)
                                                  .update({
                                                    'password':
                                                        _newPasswordController
                                                            .text
                                                  })
                                                  .then(
                                                      (value) => print('done'))
                                                  .catchError((error) =>
                                                      print('error'));
                                              FirebaseAuth.instance.currentUser!
                                                  .updatePassword(
                                                      _newPasswordController
                                                          .text);
                                              Navigator.pop(context);
                                            }
                                          }
                                        } else if (_newPasswordController
                                                .text !=
                                            _confirmPasswordController.text) {
                                          print('password not match');
                                        }
                                      } else if (_oldPasswordController.text !=
                                          oldPassword) {
                                        print('old password not match');
                                      } else if (!pass_valid.hasMatch(
                                          _newPasswordController.text)) {
                                        print('password not valid');
                                      } else if (_newPasswordController
                                              .text.length <
                                          8) {
                                        print('password length must be 8');
                                      }
                                    },
                                    child: Text('Confirm'),
                                  ),
                                ],
                              );
                            });
                      },
                      leading: Icon(
                        Icons.password,
                        color: Color(0xFF5E57A5),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 0.2,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                    'contact us through email:\nsupport@wishystore.com'),
                              );
                            });
                      },
                      title: const Text(
                        'Contact us',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      leading: Icon(
                        Icons.email,
                        color: Color(0xFF5E57A5),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 0.2,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      title: const Text(
                        'Terms and Conditions',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      leading: Icon(
                        Icons.bookmark,
                        color: Color(0xFF5E57A5),
                      ),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 0.2,
                      indent: 20,
                      endIndent: 20,
                    ),
                    ListTile(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title:
                                    Text('Are you sure you want to log out?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      FirebaseAuth.instance.signOut();
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    },
                                    child: Text('Confirm'),
                                  ),
                                ],
                              );
                            });
                      },
                      title: const Text(
                        'Log out',
                        style: TextStyle(fontWeight: FontWeight.normal),
                      ),
                      leading: Icon(
                        Icons.logout,
                        color: Color(0xFF5E57A5),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           margin: EdgeInsets.fromLTRB(1, 100, 1, 100),
//           color: Colors.white,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               CircleAvatar(
//                 radius: 48, // Image radius
//                 backgroundImage: Image.asset('images/user_defulat.png').image,
//               ),
//               Text(
//                 'User Name',
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white),
//               ),
//               Text(
//                 'User email address',
//                 style: TextStyle(
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.grey),
//               ),
//               SizedBox(
//                 height: 50,
//               ),
//               const Divider(
//                 color: Colors.white,
//                 thickness: 1,
//                 indent: 20,
//                 endIndent: 20,
//               ),
//               ListTile(
//                 title: const Text(
//                   'Edit Profile',
//                   style: TextStyle(fontWeight: FontWeight.w500),
//                 ),
//                 leading: Icon(
//                   Icons.person,
//                   color: Colors.white,
//                 ),
//               ),
//               ListTile(
//                 title: const Text(
//                   'Change password',
//                   style: TextStyle(fontWeight: FontWeight.w500),
//                 ),
//               ),
//               MaterialButton(
//                 minWidth: 300,
//                 color: Colors.white,
//                 onPressed: () {
//                   FirebaseAuth.instance.signOut();
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (context) => LoginScreen()));
//                 },
//                 child: Text("Sign Out"),
//               ),
//             ],
//           ),
//         ),
