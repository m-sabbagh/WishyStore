import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNewItemToStore extends StatefulWidget {
  const AddNewItemToStore({Key? key}) : super(key: key);
  static String id = 'addNewItemToStore';

  @override
  State<AddNewItemToStore> createState() => _AddNewItemToStoreState();
}

class _AddNewItemToStoreState extends State<AddNewItemToStore> {
  // Future getImage(String? itemBarcode) async {
  //   final image = await ImagePicker().pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: 100,
  //     maxHeight: 512,
  //     maxWidth: 512,
  //   );

  // }

  // void uploadImage(String? itemBarcode) async {
  //   Reference ref = FirebaseStorage.instance.ref().child(itemBarcode!);
  //   await ref.putFile(File(image!.path));
  //   ref.getDownloadURL().then((value) async {
  //     await FirebaseAuth.instance.currentUser!.updatePhotoURL(value);
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String? selectedItemCategory;
  String userId = FirebaseAuth.instance.currentUser!.uid;

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

                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 50,
                    )),

                Text(
                  'Add item image , image must be 512x512',
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  height: 50,
                  child: TextField(
                    // controller: _emailcontroller,
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
                          // controller: _emailcontroller,
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
                          // controller: _emailcontroller,
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
                      border:
                          Border.all(color: Colors.grey.shade400, width: 2.0),
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
                    // controller: _emailcontroller,
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
                      onPressed: () {},
                      color: Colors.black,
                      child: Text(
                        "Show item example",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        // addItemToStore();
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
