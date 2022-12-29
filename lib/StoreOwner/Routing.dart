import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/StoreOwner/FillingInformationForStoreOwner.dart';
import 'package:wishy_store/StoreOwner/StoreOwnerPage.dart';

bool? isFilled;
bool? isGranted;
final _auth = FirebaseAuth.instance;

Future getWhere() async {
  await FirebaseFirestore.instance
      .collection('Users')
      .doc(_auth.currentUser!.uid)
      .get()
      .then((value) {
    isFilled = value['infoFilled'];
    isGranted = value['storeOwnerGranted'];
  });
}

getIsGranted() {
  getWhere();
  return isGranted;
}

getIsFilled() {
  getWhere();
  return isFilled;
}

Widget checkWhichPageToGoTo() {
  print(getIsFilled());
  print(getIsGranted());
  getWhere();
  if (isFilled != null) {
    if (isFilled == true) {
      return StoreOwnerPage(isGranted);
    } else {
      return FillingInformation();
    }
  } else {
    return CircularProgressIndicator();
  }
}
