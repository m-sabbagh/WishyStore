import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/StoreOwner/UploadToStorage.dart';
import 'package:wishy_store/Widgets/ErrorToast.dart';

class FeedsPromotion extends StatefulWidget {
  String storeName;
  FeedsPromotion({required this.storeName});

  @override
  State<FeedsPromotion> createState() => _FeedsPromotionState();
}

class _FeedsPromotionState extends State<FeedsPromotion> {
  final _promotionDescription = TextEditingController();

  String storeUid = FirebaseAuth.instance.currentUser!.uid;

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

  File? filevar;
  String? imageURL = '';
  @override
  Widget build(BuildContext context) {
    //one button to submit the uploaded image
    return Scaffold(
      appBar: AppBar(
        title: Text('Main page promotion'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 200,
                    width: 400,
                    child: ClipRRect(
                      child: Image.asset(
                        'images/upload_storeproduct.jpg',
                        height: 200,
                        width: 200,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      filevar = await Storage.getGalleryImage(image: filevar);
                      imageURL = await Storage.uploadUserImage(image: filevar);
                    },
                    child: Text(
                      'Upload promotion image',
                      style: TextStyle(
                        color: Colors.blue[400],
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  SizedBox(height: 30.0),
                  SizedBox(
                    height: 100,
                    child: TextField(
                      maxLines: 5,
                      controller: _promotionDescription,
                      decoration: InputDecoration(
                        hintText: 'Enter promotion description',
                        hintStyle: TextStyle(
                          color: Colors.black,
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
                  SizedBox(height: 10.0),
                  MaterialButton(
                    onPressed: () async {
                      submitRequest();
                      setState(() {
                        _promotionDescription.clear();
                        imageURL = '';
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.black,
                    child: Text(
                      "Submit request",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
