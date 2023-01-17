import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/StoreOwner/EditItems.dart';

class CategoryItems extends StatefulWidget {
  String categoryName;
  CategoryItems({required this.categoryName});

  @override
  State<CategoryItems> createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryItems> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            Text(
              '${widget.categoryName}',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('StoreOwners')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if ([...snapshot.data['categories'][widget.categoryName].keys]
                .isEmpty)
              return Center(
                  child: Text(
                'No Items in this category yet!',
                style: TextStyle(fontSize: 20),
              ));
            return ListView.builder(
              //space between items
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              itemCount:
                  snapshot.data['categories'][widget.categoryName].length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditItems(
                                  itemBarcode: snapshot
                                      .data['categories'][widget.categoryName]
                                      .values
                                      .toList()[index]['itemBarcode'],
                                  itemTitle: snapshot
                                      .data['categories'][widget.categoryName]
                                      .keys
                                      .toList()[index],
                                  itemPrice: snapshot
                                      .data['categories'][widget.categoryName]
                                      .values
                                      .toList()[index]['itemPrice'],
                                  itemCategory: widget.categoryName,
                                  itemImage: snapshot
                                      .data['categories'][widget.categoryName]
                                      .values
                                      .toList()[index]['itemImage'],
                                  itemDescription: snapshot
                                      .data['categories'][widget.categoryName]
                                      .values
                                      .toList()[index]['itemDescription'],
                                )));
                  },
                  subtitle: Text(
                      '${snapshot.data['categories'][widget.categoryName].values.toList()[index]['itemBarcode']}'),
                  title: Text(
                      '${snapshot.data['categories'][widget.categoryName].keys.toList()[index]}'),
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(snapshot
                            .data['categories'][widget.categoryName].values
                            .toList()[index]['itemImage']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Delete Item'),
                              content: Text(
                                  'Are you sure you want to delete this item?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel')),
                                TextButton(
                                    onPressed: () {
                                      FirebaseFirestore.instance
                                          .collection('StoreOwners')
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.uid)
                                          .update({
                                        'categories.${widget.categoryName}.${snapshot.data['categories'][widget.categoryName].keys.toList()[index]}':
                                            FieldValue.delete()
                                      });
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: Text('Delete')),
                              ],
                            );
                          });
                    },
                  ),
                  // trailing:
                  //     Text(snapshot.data['categories'][widget.categoryName]),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
