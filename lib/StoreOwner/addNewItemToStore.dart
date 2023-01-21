import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/StoreOwner/UploadToStorage.dart';
import 'package:wishy_store/StoreOwner/itemExample.dart';

class AddNewItemToStore extends StatefulWidget {
  const AddNewItemToStore({Key? key}) : super(key: key);
  static String id = 'addNewItemToStore';

  @override
  State<AddNewItemToStore> createState() => _AddNewItemToStoreState();
}

class _AddNewItemToStoreState extends State<AddNewItemToStore> {
  // XFile? image;
  String? storename;
  RegExp barcode_valid = RegExp(r'^[0-9]{13}$');
  RegExp price_valid = RegExp(r'^[0-9]+(.[0-9]{1,2})?$');

  Future getstorename() async {
    await FirebaseFirestore.instance
        .collection('StoreOwners')
        .doc(userId)
        .get()
        .then((value) {
      storename = value.data()!['storeName'];
    });
  }

  // var imageurl;
  // Future getImage() async {
  //   image = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 100,
  //     maxHeight: 512,
  //     maxWidth: 512,
  //   );
  // }

  // Future uploadImage(String? itemBarcode) async {
  //   Reference ref = FirebaseStorage.instance.ref().child(itemBarcode!);
  //   await ref.putFile(File(image!.path));
  //   ref.getDownloadURL().then((value) async {
  //     await FirebaseAuth.instance.currentUser!.updatePhotoURL(value);
  //     imageurl = await value;
  //     print(imageurl);
  //   });
  // }

  //image size must be wirtten right ... 512x512 7ato habal
  //when the storeowner uploads an image it shows it
  final _itemtitle = TextEditingController();
  final _itemprice = TextEditingController();
  final _itembarcode = TextEditingController();
  final _itemdescription = TextEditingController();
  Future addItemToStore() async {
    if (imageURL == '') {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please upload an image')));
    }
    if (_itemtitle.text.isEmpty ||
        _itemprice.text.isEmpty ||
        _itembarcode.text.isEmpty ||
        selectedItemCategory == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill all fields')));
    } else if (_itembarcode.text.length != 13) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Barcode must be 13 digits')));
    } else if (_itemtitle.text.length > 20) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Item title must be less than 20 characters')));
    } else if (_itemdescription.text.length > 500) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Item description must be less than 100 characters')));
    } else if (!barcode_valid.hasMatch(_itembarcode.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item barcode must be a number')));
    } else if (_itemprice.text.length > 6) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item price must be less than 6 digits')));
    } else if (!price_valid.hasMatch(_itemprice.text)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Item price must be a number')));
    } else if (double.parse(_itemprice.text) > 99999.99) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item price must be less than 99999.99')));
    } else if (double.parse(_itemprice.text) < 0.01) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item price must be more than 0.01')));
    } else if (_itemtitle.text.length < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item title must be more than 3 characters')));
    } else {
      FirebaseFirestore.instance.collection('StoreOwners').doc(userId).set({
        'categories': {
          '$selectedItemCategory': {
            '${_itemtitle.text}': {
              'itemTitle': _itemtitle.text,
              'itemPrice': _itemprice.text,
              'itemBarcode': _itembarcode.text,
              'itemImage': imageURL,
              'itemDescription': _itemdescription.text,
            }
          }
        }
      }, SetOptions(merge: true));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Item added successfully')));
      setState(() {
        clearFileds();
      });
    }
  }

  clearFileds() {
    _itemtitle.clear();
    _itemprice.clear();
    _itembarcode.clear();
    _itemdescription.clear();
    imageURL = '';
    // selectedItemCategory = null;
  }

  // Image backgroundimage() {
  //   if (FirebaseAuth.instance.currentUser!.photoURL != null) {
  //     return Image.network(imageUrl);
  //   } else {
  //     return Image.asset('images/user_defulat.png');
  //   }
  // }

  @override
  void initState() {
    getstorename();
    super.initState();
  }

  File? filevar;
  String? imageURL = '';
  String? selectedItemCategory;
  String userId = FirebaseAuth.instance.currentUser!.uid;
  // String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // CircleAvatar(
                    //   backgroundColor: Colors.grey,
                    //   radius: 55,
                    //   backgroundImage: backgroundimage().image,
                    // ),
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
                        // ImagePicker imagePicker = ImagePicker();
                        // XFile? filename = await imagePicker.pickImage(
                        //     source: ImageSource.gallery);

                        // String uniqueImageUrl =
                        //     DateTime.now().millisecondsSinceEpoch.toString();

                        // Reference refRoot = FirebaseStorage.instance.ref();
                        // Reference refDirImage = refRoot.child(storename!);
                        // //name the image whatever you want
                        // Reference referenceImageToUpload =
                        //     refDirImage.child(uniqueImageUrl);

                        // //store the file
                        // await referenceImageToUpload
                        //     .putFile(File(filename!.path));
                        // //get the url of the image
                        // imageUrl = await refDirImage.getDownloadURL();
                        filevar = await Storage.getGalleryImage(image: filevar);
                        imageURL =
                            await Storage.uploadUserImage(image: filevar);
                      },
                      child: Text(
                        'Upload item image',
                        style: TextStyle(
                          color: Colors.blue[400],
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'it is recommended to upload images\n with dimensions of 280x300 pixels.',
                      style: TextStyle(
                        color: Color.fromARGB(255, 211, 183, 105),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.0),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: _itemtitle,
                    decoration: InputDecoration(
                      hintText: 'Enter item title',
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
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: _itemprice,
                          decoration: InputDecoration(
                            hintText: 'Enter item price',
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
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          controller: _itembarcode,
                          decoration: InputDecoration(
                            hintText: 'Enter item barcode',
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
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),

                SizedBox(
                  height: 45,
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 16),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('StoreOwners')
                          .doc(userId)
                          .get(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          List<String> storeCategories = [];
                          Map<String, dynamic> data =
                              snapshot.data!.data() as Map<String, dynamic>;
                          data['categories'].forEach((key, value) {
                            storeCategories.add(key);
                          });
                          if (data['categories'].length == 0) {
                            return Text('No categories added yet');
                          }
                          // storeCategories = snapshot.data!['categories'];
                          return DropdownButtonHideUnderline(
                            child: DropdownButton(
                              hint: Text('Select Category'),
                              isExpanded: true,
                              value: selectedItemCategory,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedItemCategory = newValue.toString();
                                });
                              },
                              items:
                                  storeCategories.map((selectedItemCategory) {
                                return DropdownMenuItem(
                                  child: new Text(selectedItemCategory),
                                  value: selectedItemCategory,
                                );
                              }).toList(),
                            ),
                          );
                        } else {
                          return Text(
                            'Loading...',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),

                SizedBox(height: 20.0),
                SizedBox(
                  height: 100,
                  child: TextField(
                    maxLines: 5,
                    controller: _itemdescription,
                    decoration: InputDecoration(
                      hintText: 'Description',
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
                SizedBox(height: 20.0),

                //To add new item

// Store owner must add

// Item id /barcode
// Item category
// Item picture
// Item title
// Item price
// Item description

                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemExample(),
                          ),
                        );
                      },
                      color: Colors.black,
                      child: Text(
                        "Show item example",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        addItemToStore();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.black,
                      child: Text(
                        "Add item",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: Text("Add new item to store"),
    backgroundColor: Colors.black,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.pop(context),
    ),
    actions: <Widget>[SizedBox(width: 20.0 / 2)],
  );
}
