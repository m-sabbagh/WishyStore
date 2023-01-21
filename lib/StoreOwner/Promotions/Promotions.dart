import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/StoreOwner/Promotions/FeedsPromotion.dart';
import 'package:wishy_store/Widgets/ErrorToast.dart';

class StoreOwnerPromotions extends StatefulWidget {
  String storeName;
  StoreOwnerPromotions({Key? key, required this.storeName}) : super(key: key);

  @override
  State<StoreOwnerPromotions> createState() => _StoreOwnerPromotionsState();
}

class _StoreOwnerPromotionsState extends State<StoreOwnerPromotions> {
  final _promotionDescription = TextEditingController();
  String storeUid = FirebaseAuth.instance.currentUser!.uid;
  File? filevar;
  String? imageURL = '';
  Future submitRequest() async {
    if (imageURL == '') {
      CustomFlutterToast_Error(message: 'Please upload an image');
    } else if (_promotionDescription.text.isEmpty) {
      CustomFlutterToast_Error(message: 'Please enter a description');
    } else {
      await FirebaseFirestore.instance
          .collection('Promotions')
          .doc('MainPagePromotion')
          .set(
        {
          '${widget.storeName}': {
            'storePromotionDescription': _promotionDescription.text,
            'storePromotionImage': imageURL,
            'approved': false,
            'storePromotionDate': DateTime.now(),
            'storeUid': storeUid,
          }
        },
        SetOptions(merge: true),
      );
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Your promotion request has been submitted')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Promotions'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Expanded(
                //   child: Container(
                //     height: 100,
                //     width: 200,
                //     color: Colors.grey,
                //     child: MaterialButton(
                //       onPressed: () {
                //         showDialog(
                //             context: context,
                //             builder: (context) {
                //               return SizedBox(
                //                 child: AlertDialog(
                //                   title:
                //                       Text('Popluar store promotion request'),
                //                   content: Column(
                //                     children: [
                //                       Text(
                //                           'This promotion will be shown in the popular store section'),
                //                       TextField(
                //                         decoration: InputDecoration(
                //                           hintText:
                //                               'Please enter promotion description',
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                   actions: [
                //                     TextButton(
                //                         onPressed: () {
                //                           Navigator.pop(context);
                //                         },
                //                         child: Text('Cancel')),
                //                     TextButton(
                //                         onPressed: () {
                //                           Navigator.pop(context);
                //                         },
                //                         child: Text('Send request')),
                //                   ],
                //                 ),
                //               );
                //             });
                //       },
                //       child: Center(
                //           child: Text(
                //         "Popluar store promotion",
                //         style: TextStyle(color: Colors.white, fontSize: 12.8),
                //       )),
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 100,
                    width: 200,
                    color: Colors.grey,
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return FeedsPromotion(
                              storeName: widget.storeName,
                            );
                          },
                        ));
                      },
                      child: Center(
                          child: Text(
                        "Feeds promotion",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
