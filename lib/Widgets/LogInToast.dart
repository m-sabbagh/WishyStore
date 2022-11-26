import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> FlutterToastErorrStyle(String? message) {
  return Fluttertoast.showToast(
      msg: message?.toString() ?? "Error",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
