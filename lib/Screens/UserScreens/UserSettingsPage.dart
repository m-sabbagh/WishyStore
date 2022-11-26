import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../User/StoreOwner shared screens/LogInPage.dart';
import 'package:settings_ui/settings_ui.dart';

class UserSettingsPage extends StatefulWidget {
  const UserSettingsPage({Key? key}) : super(key: key);
  static String id = 'user_settings_page';

  @override
  State<UserSettingsPage> createState() => _UserSettingsPageState();
}

class _UserSettingsPageState extends State<UserSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF313050),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 200),
            child: SafeArea(
                child: Text(
              'My profile',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
          ),
          SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 48, // Image radius
            backgroundImage: Image.asset('images/user_defulat.png').image,
          ),
          Text(
            'User Name',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            'User email address',
            style: TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          SizedBox(
            height: 50,
          ),
          const Divider(
            color: Colors.white,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
          ListTile(
            title: const Text(
              'Edit Profile',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          ListTile(
            title: const Text(
              'Change password',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          MaterialButton(
            minWidth: 300,
            color: Colors.white,
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: Text("Sign Out"),
          ),
        ],
      ),
    );
  }
}
