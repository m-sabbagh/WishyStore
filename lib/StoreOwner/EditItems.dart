// import 'dart:html';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/StoreOwner/UploadToStorage.dart';

class EditItems extends StatefulWidget {
  String itemBarcode;
  String itemTitle;
  String itemPrice;
  String itemImage;
  String itemCategory;
  String itemDescription;

  EditItems({
    required this.itemBarcode,
    required this.itemTitle,
    required this.itemPrice,
    required this.itemImage,
    required this.itemCategory,
    required this.itemDescription,
  });

  @override
  State<EditItems> createState() => _EditItemsState();
}

class _EditItemsState extends State<EditItems> {
  final _itemtitle = TextEditingController();
  final _itemprice = TextEditingController();
  final _itembarcode = TextEditingController();
  final _itemdescription = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Future upadeItem({required String updatedItem}) async {

  // }

  Future editDialog(
      {required String title,
      required String hint,
      required String mapFiled,
      required TextEditingController controller,
      required int? i}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: TextField(
              maxLines: i,
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
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
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    setState(() {
                      CollectionReference store =
                          FirebaseFirestore.instance.collection('StoreOwners');

                      store.doc(FirebaseAuth.instance.currentUser!.uid).set(
                        {
                          'categories': {
                            '${widget.itemCategory}': {
                              '${widget.itemTitle}': {
                                '$mapFiled': '${controller.text}',
                              }
                            },
                          }
                        },
                        SetOptions(merge: true),
                      );
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Save')),
            ],
          );
        });
  }

  File? filevar;
  String? imageURL = '';
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

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 200,
                      width: 400,
                      child: ClipRRect(
                        child: Image.network(
                          widget.itemImage,
                          height: 200,
                          width: 200,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {},
                      child: Text(
                        'You can\'t edit item image',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                  ],
                ),

                SizedBox(height: 20.0),
                Container(
                  color: Colors.grey[200],
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.itemTitle,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'You cant edit item title',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.itemPrice,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  editDialog(
                                      title: 'Edit item price',
                                      mapFiled: 'itemPrice',
                                      i: 1,
                                      hint: widget.itemPrice,
                                      controller: _itemprice);
                                },
                                icon: Icon(Icons.edit)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                widget.itemBarcode,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  editDialog(
                                      title: 'Edit item barcode',
                                      mapFiled: 'itemBarcode',
                                      i: 1,
                                      hint: widget.itemBarcode,
                                      controller: _itembarcode);
                                },
                                icon: Icon(Icons.edit)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),

                SizedBox(height: 15.0),
                Container(
                  color: Colors.grey[200],
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.itemDescription,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            editDialog(
                              title: 'Edit item description',
                              mapFiled: 'itemDescription',
                              hint: widget.itemDescription,
                              controller: _itemdescription,
                              i: 5,
                            );
                          },
                          child: Text(
                            'edit',
                            style: TextStyle(
                              color: Colors.blue[400],
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     // MaterialButton(
                //     //   shape: RoundedRectangleBorder(
                //     //     borderRadius: BorderRadius.circular(10.0),
                //     //   ),
                //     //   onPressed: () {},
                //     //   color: Colors.black,
                //     //   child: Text(
                //     //     "Show item example",
                //     //     style: TextStyle(color: Colors.grey),
                //     //   ),
                //     // ),
                //     MaterialButton(
                //       onPressed: () async {
                //         setState(() {
                //           print(_itembarcode.text);
                //           print(_itemtitle.text);
                //           print(_itemprice.text);
                //           print(_itemdescription.text);

                //           // print(imageURL);
                //         });
                //         upadeItem();
                //       },
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(10.0),
                //       ),
                //       color: Colors.black,
                //       child: Text(
                //         "Upade item",
                //         style: TextStyle(color: Colors.grey),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Edit item',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
