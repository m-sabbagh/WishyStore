import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../FirebaseNetowrkFile/ReadData/GetUserName.dart';
import '../User/StoreOwner shared screens/LogInPage.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({Key? key}) : super(key: key);
  static String id = 'user_settings_page';

  @override
  State<UserSettingsPage> createState() => _UserSettingsPageState();
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

class _UserSettingsPageState extends State<UserSettingsPage> {
  User user = FirebaseAuth.instance.currentUser!;

  CollectionReference users = FirebaseFirestore.instance.collection('alluser');

////checccckkkk

  // String? sadasd;
  // String? firstName;
  // String? lastName;
  // @override
  // void initState() {
  //   sadasd = user.uid;
  //   firstName =users.doc(sadasd).get().then((value) => value['firstname']).toString();
  //   lastName =
  //       users.doc(sadasd).get().then((value) => value['Lastname']).toString();
  // }

// String docid = 'hii';
//   Future GetCurrentDocId() async {
//     return FirebaseFirestore.instance
//         .collection('users')
//         .where('email', isEqualTo: user.email)
//         .get()
//         .then((value) {
//       value.docs.forEach((element) {
//         docid = element.id;
//       });
//     });
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF313050),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: EdgeInsets.fromLTRB(20, 100, 20, 100),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: backgroundimage().image,
                      child: IconButton(
                        onPressed: () {
                          getImage();
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Text(firstName!, style: TextStyle(fontSize: 20)),
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
                    ),
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
                    MaterialButton(
                      color: Color(0xFF5E57A5),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        "Log out",
                        style: TextStyle(color: Colors.white),
                      ),
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
