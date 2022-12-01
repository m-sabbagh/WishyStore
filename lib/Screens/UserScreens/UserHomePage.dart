import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  static String id = 'user_home_page';

  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF313050),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF313045),
        title: Text('WishyStore'),
        leading: IconButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 350),
          icon: Icon(
            Icons.search,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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
                  'images/asd2.jpeg',
                  'images/asd.jpeg',
                  'images/asd3.jpeg',
                  'images/leaderz.jpeg',
                ].map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 250,
                  ),
                  Text('view all', style: TextStyle(color: Colors.white)),
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
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "My wishlists",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 210,
                  ),
                  Text('view all', style: TextStyle(color: Colors.white)),
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
                      Text('Wishlist1'),
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
                      Text('Wishlist2')
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Card(
                        child: Container(
                          width: 50,
                          height: 50,
                          color: Colors.red,
                        ),
                      ),
                      Text('Wishlist3'),
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
                      Text('Wishlist4')
                    ],
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
