import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wishy_store/Widgets/ErrorToast.dart';

class Storage {
  static final picker = ImagePicker();
  static final _storage = firebase_storage.FirebaseStorage.instance;

  static Future<String?> uploadUserImage({required File? image}) async {
    final String? filePath = Uri.file(image!.path).pathSegments.last;
    String uniqueImageUrl = DateTime.now().millisecondsSinceEpoch.toString();

    final ref = _storage.ref().child('$filePath$uniqueImageUrl');
    try {
      TaskSnapshot? upImage = await ref.putFile(image);
      String? url = await upImage.ref.getDownloadURL();
      Fluttertoast.showToast(msg: 'Image selected successfully');
      return url;
    } on firebase_storage.FirebaseStorage catch (error) {
      CustomFlutterToast_Error(
        message: 'Something went wrong, please try again',
      );
      return Future.error(error.toString());
    } on PlatformException catch (error) {
      CustomFlutterToast_Error(
        message: 'Something went wrong, please try again',
      );

      return Future.error(error.toString());
    }
  }

  static Future<File?> getGalleryImage({required File? image}) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return image = File(pickedFile.path);
    } else {
      CustomFlutterToast_Error(
        message: 'No Image selected.',
      );
      return Future.error('No Image selected.');
    }
  }
}
