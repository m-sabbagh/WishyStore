import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wishy_store/StoreOwner/getCategories.dart';
import 'package:wishy_store/Widgets/ErrorToast.dart';

class AddNewCategory extends StatefulWidget {
  static String id = 'addNewCategory';

  @override
  State<AddNewCategory> createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  TextEditingController _categoryName = TextEditingController();

  String? sType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStoreType();
    // _callTheFuture();
  }

  void getStoreType() async {
    await FirebaseFirestore.instance
        .collection('StoreOwners')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      sType = value['storeType'];
    });
  }

  void addCategoryToStore() async {
    if (_categoryName.text.isEmpty) {
      CustomFlutterToast_Error(
          message: 'Please enter a category name',
          toastLength: Toast.LENGTH_SHORT);
    } else if (_categoryName.text.length > 10) {
      CustomFlutterToast_Error(
          message: "Category name can't be more than 10 characters",
          toastLength: Toast.LENGTH_SHORT);
    } else {
      if (sType != null) {
        try {
          await FirebaseFirestore.instance
              .collection('StoreOwners')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .set(
            {
              'categories': {
                _categoryName.text: {},
              }
            },
            SetOptions(merge: true),
          );
          setState(() {
            _categoryName.clear();

            Fluttertoast.showToast(
              msg: 'Category added successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          });
        } catch (e) {
          CustomFlutterToast_Error(
              message: "Something went wrong", toastLength: Toast.LENGTH_SHORT);
        }
      }
    }
  }

  Widget build(BuildContext context) {
    // It provide us total height and width
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              MaterialButton(
                onPressed: () {},
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: _categoryName,
                  decoration: InputDecoration(
                    hintText: 'Enter category name',
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
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    addCategoryToStore();
                  },
                  color: Colors.grey,
                  textColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add new category"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ListTile(
                title: Text(
                  "My categories",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('StoreOwners')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .get(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      List<String> categories = [];
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;
                      data['categories'].forEach((key, value) {
                        categories.add(key);
                      });

                      if (data['categories'].length == 0) {
                        return Text('No categories added yet');
                      }
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {},
                            subtitle: Text(
                              'Click to edit',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            trailing: Column(
                              children: [
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                Icon(
                                  Icons.edit,
                                  color: Colors.red,
                                ),
                              ],
                            ),
                            title: Text(categories[index]),
                          );
                        },
                      );
                    } else {
                      return Text('Loading');
                    }
                  },
                ),
              ),
            ],
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
    backgroundColor: Colors.black,
    title: Text(
      "Add new category",
      style: TextStyle(color: Colors.white),
    ),
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.pop(context),
    ),
    actions: <Widget>[SizedBox(width: 20.0 / 2)],
  );
}
