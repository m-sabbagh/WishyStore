import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wishy_store/Screens/UserScreens/UserStorePages/ItemDetailsPage.dart';
import 'package:wishy_store/Screens/UserScreens/wishlistsImages.dart';
import 'package:wishy_store/Widgets/postiontedArrowBack.dart';

class WishlistPage extends StatefulWidget {
  String? wishlistName;
  String? wishlistType;
  String? uid;
  bool? isSharedUser = true;
  String? wishlistDescription;

  WishlistPage(
      {this.wishlistName,
      this.wishlistType,
      this.uid,
      this.isSharedUser,
      this.wishlistDescription});

  static String id = 'wishlistPage';

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  // bool isChecked = false;

  Map wishlistData = {};

  List<String> itemTitle = [];
  List<String> itemPrice = [];
  List<String> imageUrl = [];
  List<bool> isReserved = [];
  List<String> itemBarcode = [];
  List<String> itemCategory = [];
  List<String> itemDescription = [];
  List<String> itemStoreName = [];

  Map<String, dynamic> wishlistItems = {};

  void getItemsFor1Wishlist(String? wishlistname, String? usrid) {
    FirebaseFirestore wishlist = FirebaseFirestore.instance;
    wishlist
        .collection('wishlists')
        .doc(usrid)
        .get()
        .asStream()
        .toList()
        .then((value) {
      value.forEach((element) {
        wishlistData = element.data() as Map;
        if (wishlistData['userWishlists'][wishlistname].length == 0) {
        } else
          wishlistData['userWishlists'][wishlistname]['UserItems']
              .forEach((key, value) {
            wishlistItems[key] = value;

            imageUrl.add(value['imageUrl']);
            itemTitle.add(value['itemTitle']);
            itemPrice.add(value['itemPrice']);
            isReserved.add(value['isReserved']);
            itemBarcode.add(value['itemBarcode']);
            itemCategory.add(value['itemCategory']);
            itemDescription.add(value['itemDescription']);
            itemStoreName.add(value['itemStoreName']);
          });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String wishlistname = widget.wishlistName!;
    String wishlistTps = widget.wishlistType!;
    String usrid = widget.uid!;
    bool isSharedUser = widget.isSharedUser!;

    CollectionReference wlists =
        FirebaseFirestore.instance.collection('wishlists');

    //user case
    getItemsFor1Wishlist(wishlistname, usrid);
    FirebaseFirestore wishlists = FirebaseFirestore.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      width: 180,
                      height: 230,
                      child: wishlistImages(wishlistTps)),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              positionedArrowBack(context, Color(0xff1F1C2C)),
            ],
          ),
          Row(
            children: [
              Text(
                ' $wishlistname ',
                style: TextStyle(color: Colors.black87, fontSize: 20),
              ),
              SizedBox(
                width: 2,
              ),
              Text(
                ' ${wishlistTps} ',
                style: TextStyle(color: Colors.black87, fontSize: 10),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            // 'wishlist description:  this wishlist for my birthday',
            ' ${widget.wishlistDescription}',

            style: TextStyle(color: Colors.black87),
          ),
          Divider(
            color: Colors.grey,
          ),
          FutureBuilder<DocumentSnapshot>(
            future: wlists.doc(usrid).get(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                if (data['userWishlists'][wishlistname]['UserItems'].isEmpty ||
                    data['userWishlists'][wishlistname]['UserItems'] == null) {
                  return Center(
                    child: Text(
                      'No items in this wishlist',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                  );
                } else {
                  return ListView.builder(
                      padding: EdgeInsets.only(top: 0),
                      shrinkWrap: true,
                      itemCount: wishlistItems.length,
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        return Dismissible(
                          key: Key(itemTitle[index]),
                          direction: isSharedUser
                              ? DismissDirection.none
                              : DismissDirection.endToStart,
                          onDismissed: (direction) {
                            wishlists.collection('wishlists').doc(usrid).set({
                              'userWishlists': {
                                wishlistname: {
                                  'UserItems': {
                                    itemTitle[index]: FieldValue.delete()
                                  }
                                }
                              }
                            }, SetOptions(merge: true));

                            //remove the item
                            // itemTitle.removeAt(index);
                            // itemPrice.removeAt(index);
                            // imageUrl.removeAt(index);
                            // isReserved.removeAt(index);
                            // itemBarcode.removeAt(index);
                            // itemCategory.removeAt(index);
                            // itemDescription.removeAt(index);
                            // itemStoreName.removeAt(index);

                            // Then show a snackbar.
                            Fluttertoast.showToast(
                                msg: '${itemTitle[index]} deleted',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                          background: Container(
                            color: Colors.red,
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ItemDetailsPage(
                                    itemTitle: itemTitle[index],
                                    itemPrice: itemPrice[index],
                                    itemBarcode: itemBarcode[index],
                                    itemCategory: itemCategory[index],
                                    itemDescription: itemDescription[index],
                                    storeName: itemStoreName[index],
                                    itemImage: imageUrl[index],
                                    showAddToWishlistButton: false,
                                  ),
                                ),
                              );
                            },

                            //isSharedUSER==false then its enabled which means its True for the user
                            //if u entered the wishlists items as its shared and the item is resereved then its disabled which means its false
                            trailing: GestureDetector(
                              onTap: () {
                                if (isSharedUser == true &&
                                    isReserved[index] == true) {
                                  //bottom flutter toast
                                  Fluttertoast.showToast(
                                      msg: "This item is reserved",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.grey,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                } else if (isSharedUser == false) {
                                  setState(() {
                                    isReserved[index] = !isReserved[index];
                                  });

                                  wishlists
                                      .collection('wishlists')
                                      .doc(usrid)
                                      .set({
                                    // 'userWishlists.$wishlistname.UserItems.${itemTitle[index]}.isReserved':
                                    // value
                                    'userWishlists': {
                                      '$wishlistname': {
                                        'UserItems': {
                                          '${itemTitle[index]}': {
                                            'isReserved': isReserved[index]
                                          }
                                        }
                                      }
                                    }
                                  }, SetOptions(merge: true));
                                  //remove

                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Are you sure you want to reserve this item? \nThis action cannot be undone'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Cancel')),
                                            TextButton(
                                                onPressed: () {
                                                  setState(() {
                                                    isReserved[index] =
                                                        !isReserved[index];
                                                    FirebaseFirestore
                                                        wishlists =
                                                        FirebaseFirestore
                                                            .instance;

                                                    wishlists
                                                        .collection('wishlists')
                                                        .doc(usrid)
                                                        .set({
                                                      'userWishlists': {
                                                        '$wishlistname': {
                                                          'UserItems': {
                                                            '${itemTitle[index]}':
                                                                {
                                                              'isReserved':
                                                                  isReserved[
                                                                      index]
                                                            }
                                                          }
                                                        }
                                                      }
                                                    }, SetOptions(merge: true));
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                child: Text('Yes'))
                                          ],
                                        );
                                      });
                                }
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  color: isReserved[index]
                                      ? Colors.red
                                      : Colors.green, //
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      isReserved[index]
                                          ? 'Reserved'
                                          : 'Reserve', //
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            leading: Stack(children: [
                              ClipRect(
                                child: Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image:
                                          Image.network(imageUrl[index]).image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              )
                            ]),
                            title: Text(
                              itemTitle[index].trim(),
                              style: TextStyle(
                                color: Colors.black87,
                                decoration: TextDecoration.none,
                              ),
                            ),
                            subtitle: Text(
                              'Price: ${itemPrice[index]}JD',
                              style: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        );
                      }));
                }
              }

              return Center(child: CircularProgressIndicator());
            }),
          ),
        ]),
      ),
    );
  }
}
