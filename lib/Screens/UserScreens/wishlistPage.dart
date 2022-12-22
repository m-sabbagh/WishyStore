import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wishy_store/Screens/UserScreens/wishlistsImages.dart';

class WishlistPage extends StatefulWidget {
  String? wishlistName;
  String? wishlistType;

  WishlistPage({this.wishlistName, this.wishlistType});

  static String id = 'wishlistPage';

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  bool isChecked = false;

  Map wishlistData = {};

  bool isThereItems = false;

  Map<String, dynamic> wishlistItems = {};

  void getItemsFor1Wishlist(String? wishlistname) {
    FirebaseFirestore wishlist = FirebaseFirestore.instance;
    wishlist
        .collection('wishlists')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .asStream()
        .toList()
        .then((value) {
      value.forEach((element) {
        // print(element.data());
        wishlistData = element.data() as Map;
        // print(wishlistData['userWishlists']);
        // print(wishlistData['userWishlists'].length);
        if (wishlistData['userWishlists'][wishlistname].length == 0) {
          isThereItems = false;
        } else
          isThereItems = true;

        // print('there is wishlist');
        // isthereIsWishlissts = true;
        wishlistData['userWishlists'][wishlistname]['UserItems']
            .forEach((key, value) {
          // print("the name of the wishlist is " + key);

          // print(value);
          // print(value['wishlistType']);
          // createWishlistInThePage(key, wishlist type);
          // print(key);
          // print(value);
          wishlistItems[key] = value;
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
      leading: Stack(children: [
        ClipRect(
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: Image.asset(imageUrl).image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        )
      ]),
      trailing: Checkbox(
        key: Key(itemTitle),
        fillColor: MaterialStateProperty.all(Colors.red),
        checkColor: Colors.black,
        activeColor: Colors.amber,
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
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
    CollectionReference wlists =
        FirebaseFirestore.instance.collection('wishlists');
    getItemsFor1Wishlist(wishlistname);

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
                Positioned(
                  top: 0.0,
                  left: 9.0,
                  right: 0.0,
                  child: AppBar(
                    leading: Row(
                      children: [
                        Card(
                          color: Color(0xff1F1C2C),
                          shape: ShapeBorder.lerp(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              1),
                          child: IconButton(
                            icon: Icon(EvaIcons.arrowBackOutline,
                                color: Colors.grey),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ' $wishlistname - $wishlistTps',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
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
              ' for wishlist descriptionnn this wishlist for my birthday kasjdkasjdkjaskdjkasjdkajskdjaskdj  kasjdksajkdjsakdjkasjdkasjkdjasksajdkasjkdjaskdjkasjdksjkdjaksd',

              style: TextStyle(color: Colors.white),
            ),
            Divider(
              color: Colors.grey,
            ),
            FutureBuilder<DocumentSnapshot>(
              future: wlists.doc(FirebaseAuth.instance.currentUser!.uid).get(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  if (data['userWishlists'][wishlistname]['UserItems']
                          .isEmpty ||
                      data['userWishlists'][wishlistname]['UserItems'] ==
                          null) {
                    return Text(
                      "You dont have any items yet",
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
                          ...wishlistItems
                              .map((key, value) {
                                return MapEntry(
                                    key,
                                    Container(
                                      child: listofItems(
                                          wishlistname,
                                          key,
                                          value['itemPrice'],
                                          value['imageUrl']),
                                    ));
                              })
                              .values
                              .toList(),
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
