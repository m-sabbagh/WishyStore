import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> CustomFlutterToast_Error({String? message, toastLength}) {
  return Fluttertoast.showToast(
      msg: message?.toString() ?? "Error",
      toastLength: toastLength,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}


//toastLength
//Toast.LENGTH_SHORT