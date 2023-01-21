import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/WishlistsPage.dart';
import 'package:wishy_store/Screens/UserScreens/wishlistsImages.dart';
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

  List<String> mainPromotionStores = [];
  List<String> mainPromotionImages = [];

  Future getFeedsStores() async {
    FirebaseFirestore.instance
        .collection('Promotions')
        .doc('MainPagePromotion')
        .get()
        .then((value) {
      if (value.data() == null) {
      } else {
        value.data()!.forEach((key, value) {
          if (value['approved'] == true) {
            mainPromotionStores.add(key);
            mainPromotionImages.add(value['storePromotionImage']);
          } else if (value['approved'] == false) {}
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFeedsStores();
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
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('Promotions')
                      .doc('MainPagePromotions')
                      .get(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: mainPromotionImages.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                ),
                                child: Image.network(
                                  i,
                                  fit: BoxFit.fill,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    } else {
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: 200.0,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                        ),
                        items: [
                          'https://reactnativecode.com/wp-content/uploads/2018/02/Default_Image_Thumbnail.png'
                        ].map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                ),
                                child: Image.network(
                                  i,
                                  fit: BoxFit.fill,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    }
                  }),
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
                    width: 230,
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     // Navigator.pushNamed(context, MyWishPage.id);
                  //   },
                  //   child: Text(
                  //     "View all",
                  //     style: TextStyle(
                  //       color: Colors.black87,
                  //     ),
                  //   ),
                  // ),
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
                          return Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Card(
                                elevation: 4,
                                shadowColor: Color.fromARGB(255, 174, 172, 172),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: ListTile(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => WishlistPage(
                                                  isSharedUser: false,
                                                  wishlistName: snapshot
                                                      .data['userWishlists']
                                                      .keys
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
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    return Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Card(
                          elevation: 4,
                          shadowColor: Color.fromARGB(255, 174, 172, 172),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ListTile(
                            leading: Image.network(
                                'https://reactnativecode.com/wp-content/uploads/2018/02/Default_Image_Thumbnail.png'),
                            title: Text('Loading...'),
                          ),
                        ),
                      ],
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
