import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

// import '../export_feature.dart';

//  ImagePicker imagePicker = ImagePicker();
//           XFile? filename = await imagePicker.pickImage(
//               source: ImageSource.gallery);

//           String uniqueImageUrl =
//               DateTime.now().millisecondsSinceEpoch.toString();

//           Reference refRoot = FirebaseStorage.instance.ref();
//           Reference refDirImage = refRoot.child(storename!);
//           //name the image whatever you want
//           Reference referenceImageToUpload =
//               refDirImage.child(uniqueImageUrl);

//           //store the file
//           await referenceImageToUpload
//               .putFile(File(filename!.path));
//           //get the url of the image
//           imageUrl = await refDirImage.getDownloadURL();

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
      return url;
    } on firebase_storage.FirebaseStorage catch (error) {
      debugPrint(error.toString());
      return Future.error(error.toString());
    } on PlatformException catch (error) {
      debugPrint('Error');
      debugPrint(error.toString());
      return Future.error(error.toString());
    }
  }

  static Future<File?> getGalleryImage({required File? image}) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return image = File(pickedFile.path);
    } else {
      debugPrint('No Image selected.');
      return Future.error('No Image selected.');
    }
  }
}
