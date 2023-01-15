import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/User_StoreOwner%20sharedScreens/StoreOwner/UserNavBar.dart';
import 'package:wishy_store/Screens/UserScreens/ShowStoreForUser/StoresPage.dart';
import 'package:wishy_store/Screens/UserScreens/ShowStoreForUser/StorePage.dart';
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
      backgroundColor: Color.fromARGB(255, 17, 14, 35),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'WishyStore',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(EvaIcons.search, color: Colors.white),
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
                      color: Colors.white,
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
                        color: Colors.white,
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
                                  size: Size.fromRadius(55), // Image radius
                                  child: Image.asset('images/ledrz.jpeg',
                                      fit: BoxFit.cover),
                                ),
                              )),
                        ),
                        Text(
                          'Leaders', //should capitlize the first letter
                          style: TextStyle(color: Colors.white),
                        )
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
                                  size: Size.fromRadius(55), // Image radius
                                  child: Image.asset(
                                      'images/Deal_of_the_Day-11_400x400.png',
                                      fit: BoxFit.cover),
                                ),
                              )),
                        ),
                        Text(
                          'Smartbuy',
                          style: TextStyle(color: Colors.white),
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
                              size: Size.fromRadius(55), // Image radius
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
                              size: Size.fromRadius(55), // Image radius
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
                              size: Size.fromRadius(55), // Image radius
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
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "My wishlists",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 210,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, MyWishPage.id);
                    },
                    child: Text(
                      "View all",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        child: Card(
                          child: Container(
                            width: 50,
                            height: 50,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Text(
                        'Wishlist1',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      Card(
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Wishlist2',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
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
