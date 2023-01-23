import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wishy_store/Screens/UserScreens/MyWishPage/CreateWishList.dart';
import 'package:wishy_store/Screens/UserScreens/WishlistsPage.dart';
import 'package:wishy_store/Screens/UserScreens/wishlistsImages.dart';
import 'package:wishy_store/constants.dart';
import '../../../FirebaseNetowrkFile/shareWishlistToUser.dart';
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
  FirebaseAuth _auth = FirebaseAuth.instance;

  final _ShareEmailAddress = TextEditingController();
  RegExp email_valid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+.[a-zA-Z]+");
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: FutureBuilder<DocumentSnapshot>(
                future:
                    wlists.doc(FirebaseAuth.instance.currentUser!.uid).get(),
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
                                "by clicking the button\n ",
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
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: snapshot.data!['userWishlists'].keys
                            .toList()
                            .length,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: [
                              Card(
                                elevation: 4,
                                shadowColor: Color.fromARGB(255, 174, 172, 172),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: SizedBox(
                                  width: 350,
                                  height: 100,
                                  child: Stack(
                                    children: [
                                      ListTile(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        tileColor: Colors.white,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WishlistPage(
                                                        isSharedUser: false,
                                                        wishlistName: snapshot
                                                            .data![
                                                                'userWishlists']
                                                            .keys
                                                            .toList()[index],
                                                        wishlistType: snapshot
                                                                .data![
                                                                    'userWishlists']
                                                                .values
                                                                .toList()[index]
                                                            ['wishlistType'],
                                                        uid: _auth
                                                            .currentUser!.uid,
                                                        wishlistDescription: snapshot
                                                                .data![
                                                                    'userWishlists']
                                                                .values
                                                                .toList()[index]
                                                            [
                                                            'wishlistDescription'],
                                                      )));
                                        },
                                        title: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: SizedBox.fromSize(
                                                size: Size.fromRadius(
                                                    47), // Image radius
                                                child: wishlistImages(snapshot
                                                        .data!['userWishlists']
                                                        .values
                                                        .toList()[index]
                                                    ['wishlistType']),
                                              ),
                                            ),
                                            Text(
                                              snapshot
                                                  .data!['userWishlists'].keys
                                                  .toList()[index],
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        left: 10,
                                        top: 10,
                                        bottom: 10,
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Alert(
                                                      context: context,
                                                      title:
                                                          "Share your wishlist to your friends by email",
                                                      content: Column(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height: 15.0,
                                                          ),
                                                          SizedBox(
                                                            height: 45.0,
                                                            child: TextField(
                                                              controller:
                                                                  _ShareEmailAddress,
                                                              decoration:
                                                                  InputDecoration(
                                                                hintText:
                                                                    'email address',
                                                                hintStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                border:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .grey,
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
                                                          color:
                                                              Color(0xFF5E57A5),
                                                          onPressed: () =>
                                                              Navigator.pop(
                                                                  context),
                                                          child: Text(
                                                            "Cancel",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
                                                          ),
                                                        ),
                                                        DialogButton(
                                                          color:
                                                              Color(0xFF5E57A5),
                                                          onPressed: () {
                                                            if (_ShareEmailAddress
                                                                .text.isEmpty) {
                                                              CustomFlutterToast_Error(
                                                                  message:
                                                                      "Please enter an email",
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT);
                                                            } else if (!_ShareEmailAddress.text.contains(
                                                                        '@') ==
                                                                    true ||
                                                                !_ShareEmailAddress
                                                                        .text
                                                                        .contains(
                                                                            '.com') ==
                                                                    true ||
                                                                !_ShareEmailAddress
                                                                        .text
                                                                        .contains(
                                                                            email_valid) ==
                                                                    true) {
                                                              CustomFlutterToast_Error(
                                                                  message:
                                                                      "Please enter a valid email",
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT);
                                                            } else {
                                                              ShareWishlistToUser
                                                                  shareWishlistTOuser =
                                                                  ShareWishlistToUser(
                                                                emailAddressForSharing:
                                                                    _ShareEmailAddress,
                                                                currentUserEmail:
                                                                    _auth
                                                                        .currentUser!
                                                                        .email,
                                                                wishlistName: snapshot
                                                                    .data![
                                                                        'userWishlists']
                                                                    .keys
                                                                    .toList()[index],
                                                                currentUserId: _auth
                                                                    .currentUser!
                                                                    .uid,
                                                                wishlisttype: snapshot
                                                                        .data![
                                                                            'userWishlists']
                                                                        .values
                                                                        .toList()[index]
                                                                    [
                                                                    'wishlistType'],
                                                                wishlistDescription: snapshot
                                                                        .data![
                                                                            'userWishlists']
                                                                        .values
                                                                        .toList()[index]
                                                                    [
                                                                    'wishlistDescription'],
                                                              );
                                                              setState(() {
                                                                shareWishlistTOuser
                                                                    .checkONtheSharedEmail();
                                                                _ShareEmailAddress
                                                                    .clear();
                                                              });

                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                          },
                                                          child: Text(
                                                            "Share",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20),
                                                          ),
                                                        )
                                                      ]).show();
                                                },
                                                icon: Icon(
                                                  Icons.share,
                                                  size: 30,
                                                  color: Colors.grey.shade700,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              IconButton(
                                                padding: EdgeInsets.zero,
                                                highlightColor:
                                                    Colors.transparent,
                                                icon: Icon(
                                                  Icons.delete,
                                                  size: 30,
                                                  color: Colors.grey.shade700,
                                                ),
                                                onPressed: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          title: Text(
                                                              'Are you sure you want to delete your wishlist?'),
                                                          content: Row(
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    DialogButton(
                                                                  color: Color(
                                                                      0xFF5E57A5),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                    "Cancel",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    DialogButton(
                                                                  color: Color(
                                                                      0xFF5E57A5),
                                                                  onPressed:
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      FirebaseFirestore
                                                                          wishlist =
                                                                          FirebaseFirestore
                                                                              .instance;
                                                                      final docref = wishlist
                                                                          .collection(
                                                                              'wishlists')
                                                                          .doc(FirebaseAuth
                                                                              .instance
                                                                              .currentUser!
                                                                              .uid);
                                                                      docref
                                                                          .update({
                                                                        'userWishlists.${snapshot.data!['userWishlists'].keys.toList()[index]}':
                                                                            FieldValue.delete()
                                                                      });
                                                                      SetOptions(
                                                                          merge:
                                                                              true);
                                                                      Fluttertoast.showToast(
                                                                          msg:
                                                                              "Wishlist deleted successfully",
                                                                          toastLength: Toast
                                                                              .LENGTH_SHORT,
                                                                          gravity: ToastGravity
                                                                              .BOTTOM,
                                                                          backgroundColor: Colors
                                                                              .green,
                                                                          textColor: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16.0);
                                                                    });
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                    "Yes",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                              ),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }

                  return Center(child: CircularProgressIndicator());
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Color(0xFF5E57A5),
          child: Icon(EvaIcons.plus),
          onPressed: () {
            //New added for dispose
            _wishListName.clear();
            wishlistNames.clear();
            wishlistData.clear();
            _wishlistDescription.clear();
            dropDownValue = null;
            getWishlistsIfExists();

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
                    StatefulBuilder(
                        builder: ((BuildContext context, StateSetter setState) {
                      return SizedBox(
                        height: 45,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 16),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: DropdownButton<String>(
                            onChanged: (String? value) {
                              setState(() {
                                dropDownValue = value!;
                                dropDownValue = value.toString();
                              });
                            },
                            hint: Text('Select wishlist type'),
                            value: dropDownValue,
                            isExpanded: true,
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
                      );
                    })),
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
                    onPressed: () {
                      _wishListName.clear();
                      wishlistNames.clear();
                      wishlistData.clear();
                      _wishlistDescription.clear();
                      dropDownValue = null;
                      getWishlistsIfExists();
                      Navigator.pop(context);
                    },
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
                      } else if (wishlistNames.length == 4) {
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
                        setState(() {
                          _wishListName.clear();
                          wishlistNames.clear();
                          wishlistData.clear();
                          _wishlistDescription.clear();
                          dropDownValue = null;
                          getWishlistsIfExists();
                          Navigator.pop(context);
                        });
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
