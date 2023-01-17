import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/User_StoreOwner%20sharedScreens/StoreOwner/UserNavBar.dart';
import 'package:wishy_store/Screens/UserScreens/UserStorePages/StoresPage.dart';
import 'package:wishy_store/Screens/UserScreens/UserStorePages/StorePage.dart';
import 'package:wishy_store/StoreOwner/StoreOwnerPage.dart';
import 'MyWishPage/MyWishPage.dart';

class UserHomePage extends StatefulWidget {
  static String id = 'user_home_page';

  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  void getMywishPage() {
    Navigator.pushNamed(context, MyWishPage.id);
  }

  List<String> wishlistNames = [];

  List<String> wishlistTypeNew = [];
  Map wishlistData = {};

//got it from my wish page
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
        wishlistData = element.data() as Map;

        wishlistData['userWishlists'].forEach((key, value) {
          wishlistNames.add(key);
          wishlistTypeNew.add(value['wishlistType']);
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWishlistsIfExists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'WishyStore',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    EvaIcons.search,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: [
                  'images/Promotion/promotion2.png',
                  'images/Promotion/promotion.jpeg',
                  'images/Promotion/leaderz.jpeg',
                  'images/Promotion/promotion3.jpeg',
                ].map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Image.asset(
                          item,
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
              // _widgetOptions.elementAt(_selectedIndex),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Stores",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, UserStorePage.id);
                    },
                    child: Text(
                      "View all",
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    // ReusableCard(
                    //     colour: kActiveCardColour,
                    //     cardChild: Image.asset('images/ledrz.jpeg'),
                    //     onPress: () {}),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                              margin: EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(20), // Image border
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(70), // Image radius
                                  child: Image.asset('images/ledrz.jpeg',
                                      fit: BoxFit.cover),
                                ),
                              )),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          child: Container(
                              margin: EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(20), // Image border
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(70), // Image radius
                                  child: Image.asset(
                                      'images/Deal_of_the_Day-11_400x400.png',
                                      fit: BoxFit.cover),
                                ),
                              )),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(20), // Image border
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(70), // Image radius
                              child: Image.asset('images/frame0.jpg',
                                  fit: BoxFit.cover),
                            ),
                          )),
                    ),
                    GestureDetector(
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(70), // Image radius
                              child: Image.asset('images/zara.jpg',
                                  fit: BoxFit.cover),
                            ),
                          )),
                    ),
                    GestureDetector(
                      child: Container(
                          margin: EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(70), // Image radius
                              child: Image.asset('images/gift_center.jpeg',
                                  fit: BoxFit.cover),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "My wishlists",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 200,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, MyWishPage.id);
                    },
                    child: Text(
                      "View all",
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('wishlists')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          // ListTile(
                          //   title: Text(
                          //     snapshot.data['userWishlists'].keys
                          //         .toList()[index],
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          //   trailing: Icon(
                          //     Icons.favorite,
                          //     color: Colors.red,
                          //   ),
                          // ),
                          width: 200,
                          color: Colors.red,
                          margin: EdgeInsets.all(10),
                          child: Text(
                            snapshot.data['userWishlists'].keys.toList()[index],
                            style: TextStyle(color: Colors.white),
                          ),
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
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
