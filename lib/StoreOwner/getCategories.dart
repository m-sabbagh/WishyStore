// import 'dart:convert';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class GetCategories {
//   // String storeType;

//   // GetStoreCategories({required this.storeType});
//   String userId = FirebaseAuth.instance.currentUser!.uid;
//   // String? storeType;

// //wait for the value then call the widgets that use the value

//   // void initState() {
//   //   // TODO: implement initState
//   //   super.initState();
//   //   late final storeType = FirebaseFirestore.instance
//   //       .collection('StoreOwners')
//   //       .doc(userId)
//   //       .get()
//   //       .then((value) => value['storeType']);

//   //   print(storeType);
//   // }

// //

//   String? rr;
//   void fillthev(String s) {
//     rr = s;
//   }

//   Future<dynamic> getStoreType() {
//     if (ConnectionState.done == ConnectionState.done) {
//       Future<dynamic> sa = FirebaseFirestore.instance
//           .collection('StoreOwners')
//           .doc(userId)
//           .get()
//           .then((value) {
//         print('hun');
//         print(value['storeType']);
//         fillTheValue(value['storeType']);
//       });
//       return sa;
//     } else {
//       return Center(
//         child: Text(
//           "Loading...",
//           style: TextStyle(
//               fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       );
//     }
//     // await FirebaseFirestore.instance
//     //     .collection('StoreOwners')
//     //     .doc(userId)
//     //     .get()
//     //     .then((value) {
//     //   storeType = value['storeType'];
//     // });
//     // print(storeType);
//     // return storeType;
//   }

//   // CollectionReference stores = FirebaseFirestore.instance.collection();

//   Future<Widget> fillTheValue(String st) async {
//     print('$st + sheeeesh');

//     CollectionReference stores = FirebaseFirestore.instance.collection(st);
//     return FutureBuilder<DocumentSnapshot>(
//       future: stores.doc(userId).get(),
//       builder: ((context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.done) {
//           print('mshii');
      
//           List<String> categories = [];

//           data['categories'].forEach((key, value) {
//             categories.add(key);
//           });
//           return ListView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: categories.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text(categories[index]),
//               );
//             },
//           );

//           // return Text(
//           //   "${data['categories']}",
//           //   style: TextStyle(
//           //       fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//           // );
//         }
//         return Center(
//           child: Text(
//             "Loading...",
//             style: TextStyle(
//                 fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
//           ),
//         );
//       }),
//     );
//   }
// }
