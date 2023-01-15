import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wishy_store/Widgets/ErrorToast.dart';

class AddNewCategory extends StatefulWidget {
  static String id = 'addNewCategory';

  @override
  State<AddNewCategory> createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  TextEditingController _categoryName = TextEditingController();
  TextEditingController _editCategoryName = TextEditingController();

  String? sType;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStoreType();
    getCategories();
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

  List<String> categories = [];

  Future getCategories() async {
    await FirebaseFirestore.instance
        .collection('StoreOwners')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => {
              if (value['categories'] != null)
                {
                  for (var i in value['categories'].keys)
                    {
                      categories.add(i),
                    }
                }
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
    } else if (categories.contains(_categoryName.text) == true) {
      print('HUN ');
      CustomFlutterToast_Error(
          message: "Category already exists", toastLength: Toast.LENGTH_SHORT);
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
    String userId = FirebaseAuth.instance.currentUser!.uid;
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
                    if (_categoryName.text.isEmpty) {
                      CustomFlutterToast_Error(
                          message: 'Please enter a category name',
                          toastLength: Toast.LENGTH_SHORT);
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Add new category'),
                              content: Text(
                                  'Are you sure you want to add this category? You can\'t change the category name later'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('No')),
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        addCategoryToStore();
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text('Yes')),
                              ],
                            );
                          });
                    }
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
              SingleChildScrollView(
                child: ListTile(
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
                    builder:
                        (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
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
                              // leading: Icon(Icons .),
                              // subtitle: Text(
                              //   categories[index],
                              //   style: TextStyle(
                              //     color: Colors.black,
                              //     fontSize: 20.0,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              // onTap: () {},
                              trailing: Column(
                                children: [
                                  // Expanded(
                                  //     child: IconButton(
                                  //   onPressed: () {
                                  //     showDialog(
                                  //       context: context,
                                  //       builder: (BuildContext context) {
                                  //         return AlertDialog(
                                  //           title: Text("Edit category name "),
                                  //           actions: [
                                  //             TextField(
                                  //               controller: _editCategoryName,
                                  //               decoration: InputDecoration(
                                  //                 hintText:
                                  //                     '${categories[index]}',
                                  //                 hintStyle: TextStyle(
                                  //                   color: Colors.black,
                                  //                 ),
                                  //                 border: OutlineInputBorder(
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(
                                  //                           10.0),
                                  //                   borderSide: BorderSide(
                                  //                     color: Colors.grey,
                                  //                     width: 2.0,
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //             Row(
                                  //               children: [
                                  //                 TextButton(
                                  //                   child: Text("Cancel"),
                                  //                   onPressed: () {
                                  //                     Navigator.of(context)
                                  //                         .pop();
                                  //                   },
                                  //                 ),
                                  //                 TextButton(
                                  //                   child: Text("Confirm"),
                                  //                   onPressed: () {
                                  //                     setState(() {
                                  //                       FirebaseFirestore
                                  //                           .instance
                                  //                           .collection(
                                  //                               'StoreOwners')
                                  //                           .doc(userId)
                                  //                           .update({
                                  //                         'categories': {
                                  //                           categories[index]=
                                  //                               _editCategoryName
                                  //                                   .text

                                  //                         }
                                  //                       });
                                  //                       SetOptions(merge: true);

                                  //                       // FirebaseFirestore
                                  //                       //     .instance
                                  //                       //     .collection(
                                  //                       //         'StoreOwners')
                                  //                       //     .doc(userId)
                                  //                       //     .update({
                                  //                       //   'categories': {
                                  //                       //     _editCategoryName
                                  //                       //         .text
                                  //                       //   }
                                  //                       // });
                                  //                       // SetOptions(merge: true);
                                  //                       Navigator.of(context)
                                  //                           .pop();
                                  //                     });
                                  //                   },
                                  //                 ),
                                  //               ],
                                  //             )
                                  //           ],
                                  //         );
                                  //       },
                                  //     );
                                  //   },
                                  //   icon: Icon(Icons.edit),
                                  // )),
                                  Expanded(
                                    child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text(
                                                    "Are you sure you want to delete this category? this will delete all the products in this category"),
                                                actions: [
                                                  TextButton(
                                                    child: Text("No"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: Text("Yes"),
                                                    onPressed: () {
                                                      setState(() {
                                                        FirebaseFirestore
                                                            firestore =
                                                            FirebaseFirestore
                                                                .instance;
                                                        final docref = firestore
                                                            .collection(
                                                                'StoreOwners')
                                                            .doc(userId);

                                                        docref.update({
                                                          'categories.${categories[index]}':
                                                              FieldValue
                                                                  .delete(),
                                                        });
                                                        SetOptions(merge: true);

                                                        Navigator.of(context)
                                                            .pop();
                                                      });
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.delete)),
                                  ),
                                ],
                              ),
                              title: Text(
                                categories[index],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Text('Loading');
                      }
                    },
                  ),
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
