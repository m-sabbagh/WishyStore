import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:wishy_store/Screens/UserScreens/wishlistsImages.dart';

class WishlistPage extends StatefulWidget {
  String? wishlistName;
  String? wishlistType;

  WishlistPage({this.wishlistName, this.wishlistType});

  static String id = 'wishlistPage  ';

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  Widget listofItems(String wishlistname) {
    return ListTile(
      leading: Stack(children: [
        Image.asset(
          'images/asd.jpeg',
          fit: BoxFit.cover,
        ),
        Text('smartbuy'),
      ]),
      trailing: Checkbox(
        fillColor: MaterialStateProperty.all(Colors.red),
        checkColor: Colors.blue,
        activeColor: Colors.amber,
        value: false,
        onChanged: (value) {
          setState(() {
            value = true;
          });
        },
      ),
      title: Text(
        'Iphone 14 Pro max',
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        '550',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String wishlistname = widget.wishlistName!;
    String wishlistTps = widget.wishlistType!;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 14, 35),
      body: Stack(children: [
        SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                    '  $wishlistTps',
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
              listofItems(wishlistname),
              listofItems(wishlistname),
              listofItems(wishlistname),
              listofItems(wishlistname),
              listofItems(wishlistname),
              listofItems(wishlistname),
              listofItems(wishlistname),
              listofItems(wishlistname),
              listofItems(wishlistname),
              listofItems(wishlistname),
              listofItems(wishlistname),
              listofItems(wishlistname),
              listofItems(wishlistname),
            ])),
      ]),
    );
  }
}
