import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wishy_store/Screens/UserScreens/MyWishPage/CreateWishList.dart';
import 'package:wishy_store/Screens/UserScreens/MyWishPage/WishlistCard.dart';
import '../../../Widgets/ErrorToast.dart';

class MyWishPage extends StatefulWidget {
  const MyWishPage({Key? key}) : super(key: key);

  static String id = 'user_wishlists';
  @override
  State<MyWishPage> createState() => _MyWishPageState();
}

class _MyWishPageState extends State<MyWishPage> {
  List<String> wishlistTypes = <String>[
    'Birthday',
    'Wedding',
    'Graduation',
    'Baby Shower',
    'House Warming',
    'Other'
  ];

  String? dropDownValue;

  // FirebaseAuth _auth = FirebaseAuth.instance;

  bool isthereIsWishlissts = false;

  Map wishlistData = {};

  List<String> wishlistNames = [];

  List<String> wishlistTypeNew = [];

  List<String> wishlistdescription = [];

  // referesh , based on the item name that rescieved ,
  //call wishlistCard based on the wishlists in the firebase after deleting the wishlist

  // void refereshAfterDelete() {
  //   getWishlistsIfExists();
  //   setState(() {
  //           widget Column=return Column(),     ...wishlistNames.map((e) => WishlistCard(
  //                             wishname: e,
  //                             wishType:
  //                                 wishlistTypeNew[wishlistNames.indexOf(e)],
  //                             shareButtonVisi: ShareButtonVisible,
  //                             wishlistDescription:
  //                                 wishlistdescription[wishlistNames.indexOf(e)],
  //                           )).toList();
  //   });
  // }

//checkIFthereIsWishlists
  void getWishlistsIfExists() {
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
        if (wishlistData['userWishlists'].length == 0) {
          isthereIsWishlissts = false;
        }

        // print('there is wishlist');
        // isthereIsWishlissts = true;
        wishlistData['userWishlists'].forEach((key, value) {
          // print("the name of the wishlist is " + key);

          // print(value);
          // print(value['wishlistType']);
          // createWishlistInThePage(key, wishlist type);
          wishlistNames.add(key);
          wishlistTypeNew.add(value['wishlistType']);
          wishlistdescription.add(value['wishlistDescription']);
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getWishlistsIfExists();

    // printwhatinside();
  }

// if(wishlistType==other) upload
// else
// getimage() {
//   if(birthday) {
//     return birthdayimage
//   }
//   if(wedding) {
//     return weddingimage
//   }
// }

  final _wishListName = TextEditingController();
  final _wishlistDescription = TextEditingController();

  // WishlistCard wishlistCard = WishlistCard();

  int wishlistCounters = 0;

  bool ShareButtonVisible = true;

  @override
  Widget build(BuildContext context) {
    CollectionReference wlists =
        FirebaseFirestore.instance.collection('wishlists');

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('MyWish',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder<DocumentSnapshot>(
            future: wlists.doc(FirebaseAuth.instance.currentUser!.uid).get(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                if (data['userWishlists'].isEmpty ||
                    data['userWishlists'] == null) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 200.0),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "No wishlists Found",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            " Create a wishlist to start adding wishes",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                          Text(
                            "\t You can add wishlists "
                            "by clicking the button s\n ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      //call each wishlist card here
                      children: [
                        ...wishlistNames.map((name) => WishlistCard(
                              wishname: name,
                              wishType:
                                  wishlistTypeNew[wishlistNames.indexOf(name)],
                              shareButtonVisi: ShareButtonVisible,
                              wishlistDescription: wishlistdescription[
                                  wishlistNames.indexOf(name)],
                            )),
                      ],
                    ),
                  );
                }
              }

              return Center(child: CircularProgressIndicator());
            }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF5E57A5),
          child: Icon(EvaIcons.plus),
          onPressed: () {
            Alert(
                context: context,
                title: "Create wishlist",
                content: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 45.0,
                      child: TextField(
                        controller: _wishListName,
                        decoration: InputDecoration(
                          hintText: 'Wishlist name',
                          hintStyle: TextStyle(
                            color: Colors.grey,
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
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 45,
                      child: Container(
                        padding: EdgeInsets.only(left: 20, right: 16),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButton<String>(
                          onChanged: (String? value) {
                            setState(() {
                              dropDownValue = value!;
                              dropDownValue = value.toString();
                            });
                          },
                          value: dropDownValue,
                          isExpanded: true,
                          hint: Text('Wishlist type'),
                          underline: Container(),
                          items: wishlistTypes
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 100.0,
                      child: TextField(
                        minLines: 1,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        controller: _wishlistDescription,
                        decoration: InputDecoration(
                          hintText: 'Wishlist Description',
                          hintStyle: TextStyle(
                            color: Colors.grey,
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
                  ],
                ),
                buttons: [
                  DialogButton(
                    color: Color(0xFF5E57A5),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  DialogButton(
                    color: Color(0xFF5E57A5),
                    onPressed: () {
                      if (_wishListName.text.isEmpty || dropDownValue == null) {
                        Fluttertoast.showToast(
                            msg: "Please fill all the fields",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      } else {
                        setState(() {
                          if (wishlistNames.length == 4) {
                            CustomFlutterToast_Error(
                                message: "You can only create 4 wishlists",
                                toastLength: Toast.LENGTH_SHORT);
                          } else if (_wishListName.text.length > 11) {
                            CustomFlutterToast_Error(
                              message:
                                  "Wishlist name can't be more than 10 characters",
                              toastLength: Toast.LENGTH_LONG,
                            );
                          } else if (wishlistNames
                              .contains(_wishListName.text.toString())) {
                            CustomFlutterToast_Error(
                              message: "Wishlist already exists",
                              toastLength: Toast.LENGTH_LONG,
                            );
                          } else {
                            (CreateWishList().addNewWishlist(
                                _wishListName.text.toString(),
                                dropDownValue,
                                _wishlistDescription.text.toString()));
                            Fluttertoast.showToast(
                                msg: "Wishlist created",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.green,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        });
                        setState(() {
                          _wishListName.clear();
                          wishlistNames.clear();
                          wishlistData.clear();
                          _wishlistDescription.clear();
                          getWishlistsIfExists();
                          Navigator.pop(context);
                        });
                        // Navigator.pushNamed(context
                      }
                    },
                    child: Text(
                      "Create",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  )
                ]).show();
          }),
    );
  }
}
