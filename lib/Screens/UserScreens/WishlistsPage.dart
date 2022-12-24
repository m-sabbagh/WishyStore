import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wishy_store/Screens/UserScreens/wishlistsImages.dart';
import 'package:wishy_store/Widgets/postiontedArrowBack.dart';

class WishlistPage extends StatefulWidget {
  String? wishlistName;
  String? wishlistType;
  String? uid;
  bool? penVisible = false;
  String? wishlistDescription;

  WishlistPage(
      {this.wishlistName,
      this.wishlistType,
      this.uid,
      this.penVisible,
      this.wishlistDescription});

  static String id = 'wishlistPage';

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  bool isChecked = false;

  Map wishlistData = {};

  List<String> itemTitle = [];
  List<String> itemPrice = [];
  List<String> imageUrl = [];
  List<String> isReserved = [];

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
          });
      });
    });
  }

  Widget listofItems(String wishlistname, String itemTitle, String itemPrice,
      String imageUrl) {
    TextDecoration checkTextStyle() {
      if (isChecked) {
        //if the checkbox is checked then the text will be crossed
        return TextDecoration.lineThrough;
      } else {
        //if the checkbox is not checked then the text will be normal
        return TextDecoration.none;
      }
    }

    return ListTile(
      // leading: Stack(children: [
      //   ClipRect(
      //     child: Container(
      //       width: 50,
      //       height: 50,
      //       decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(10),
      //         image: DecorationImage(
      //           image: Image.asset(imageUrl).image,
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      //     ),
      //   )
      // ]),
      trailing: MaterialButton(
        onPressed: () {
          setState(() {
            isChecked = !isChecked;
          });
        },
        child: Icon(
          Icons.check_box,
          color: isChecked ? Colors.green : Colors.white,
        ),
      ),
      title: Text(
        itemTitle.trim(),
        style: TextStyle(color: Colors.white, decoration: checkTextStyle()),
      ),
      subtitle: Text(
        itemPrice.trim(),
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String wishlistname = widget.wishlistName!;
    String wishlistTps = widget.wishlistType!;
    String usrid = widget.uid!;
    bool penVisible = widget.penVisible!;

    CollectionReference wlists =
        FirebaseFirestore.instance.collection('wishlists');

    //user case
    getItemsFor1Wishlist(wishlistname, usrid);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 14, 35),
      body: Stack(children: [
        SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: SizedBox(
                        height: 200,
                        child: wishlistImages(wishlistTps),
                      ),
                    ),
                  ],
                ),
                positionedArrowBack(context, Color(0xff1F1C2C)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' $wishlistname - $wishlistTps',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                if (penVisible == true)
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                      )),
              ],
            ),
            Text(
              // 'wishlist description:  this wishlist for my birthday',
              'wishlist description:  ${widget.wishlistDescription}',

              style: TextStyle(color: Colors.white),
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
                  if (data['userWishlists'][wishlistname]['UserItems']
                          .isEmpty ||
                      data['userWishlists'][wishlistname]['UserItems'] ==
                          null) {
                    return Text(
                      'No items in this wishlist',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    );
                  } else {
                    return Center(
                      child: Column(
                        //call each wishlist card here
                        children: [
                          // ...wishlistItems
                          //     .map((key, value) {
                          //       return MapEntry(
                          //           key,
                          //           Container(
                          //             child: listofItems(
                          //                 wishlistname,
                          //                 key,
                          //                 value['itemPrice'],
                          //                 value['imageUrl']),
                          //           ));
                          //     })
                          //     .values
                          //     .toList(),

                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: wishlistItems.length,
                              itemBuilder: ((context, index) {
                                return ListTile(
                                  // trailing: IconButton(
                                  //   onPressed: () {
                                  //     setState(() {
                                  //       // updateReservedStatus();
                                  //       print(itemTitle[index]);

                                  //       print(isReserved[index]);
                                  //     });
                                  //   },
                                  //   icon: Icon(
                                  //     Icons.check_box_outline_blank,
                                  //     color: Colors.red,
                                  //   ),
                                  // ),

                                  leading: Stack(children: [
                                    ClipRect(
                                      child: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: Image.asset(imageUrl[index])
                                                .image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
                                  title: Text(
                                    itemTitle[index].trim(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                  subtitle: Text(
                                    itemPrice[index].trim(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }))
                        ],
                      ),
                    );
                  }
                }

                return Center(child: CircularProgressIndicator());
              }),
            ),
          ]),
        ),
      ]),
    );
  }
}
