import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/UserNavBar.dart';
import 'package:wishy_store/Screens/UserScreens/UserStorePages/StoresPage.dart';
import 'package:wishy_store/Screens/UserScreens/UserStorePages/StorePage.dart';
import 'package:wishy_store/Screens/UserScreens/WishlistsPage.dart';
import 'package:wishy_store/Screens/UserScreens/wishlistsImages.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
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
              children: [],
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
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Popular Stores",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 180,
                  ),
                  GestureDetector(
                    onTap: () {},
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
                    "My Wishlists",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    width: 180,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, MyWishPage.id);
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
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    if (data['userWishlists'].isEmpty ||
                        data['userWishlists'] == null) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "You don't have any wishlists yet",
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, MyWishPage.id);
                                },
                                child: Text(
                                  "Create a wishlist",
                                  style: TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            snapshot.data['userWishlists'].keys.toList().length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WishlistPage(
                                            isSharedUser: false,
                                            wishlistName: snapshot
                                                .data['userWishlists'].keys
                                                .toList()[index],
                                            wishlistType: snapshot
                                                    .data['userWishlists']
                                                    .values
                                                    .toList()[index]
                                                ['wishlistType'],
                                            uid: _auth.currentUser!.uid,
                                            wishlistDescription: snapshot
                                                    .data['userWishlists']
                                                    .values
                                                    .toList()[index]
                                                ['wishlistDescription'],
                                          )));
                            },
                            leading: wishlistImages(snapshot
                                .data['userWishlists'].values
                                .toList()[index]['wishlistType']),
                            title: Text(
                              snapshot.data['userWishlists'].keys
                                  .toList()[index],
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 20,
                              ),
                            ),
                          );
                        },
                      );
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  // }

                  // if (snapshot.hasData) {

                  // }

                  // else {
                  //   return Center(
                  //     child: CircularProgressIndicator(),
                  //   );
                  // }
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
