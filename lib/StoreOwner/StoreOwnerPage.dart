import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:wishy_store/Screens/User/StoreOwner%20shared%20screens/LogInPage.dart';
import 'package:wishy_store/Screens/UserScreens/stores/ItemsCard.dart';
import 'package:wishy_store/Screens/UserScreens/stores/StoreItems.dart';
import 'package:wishy_store/Screens/UserScreens/stores/category.dart';
import 'package:wishy_store/StoreOwner/addNewCategory.dart';
import 'package:wishy_store/StoreOwner/addNewItemToStore.dart';

class StoreOwnerPage extends StatefulWidget {
  static String id = 'StoreOwnerPage';

  @override
  State<StoreOwnerPage> createState() => _StoreOwnerPage();
}

class _StoreOwnerPage extends State<StoreOwnerPage> {
  Widget listofItems() {
    return ListTile(
      leading: Stack(children: [
        Image.asset(
          'images/asd.jpeg',
          fit: BoxFit.cover,
        ),
        Text('smartbuy'),
      ]),
      trailing: Text(
        'add to wishlist',
        style: TextStyle(color: Colors.white),
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

  Widget trrrry() {
    return Stack(children: [
      Column(children: [
        SizedBox(
          height: 10,
        ),

        SizedBox(
          height: 13,
        ),
        Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Card(
                //   child: SizedBox(
                //     height: 200,
                //     child: Image.asset(
                //       'images/asd.jpeg',
                //       fit: BoxFit.cover,
                //     ),
                //   ),
                // ),
              ],
            ),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddNewCategory.id);
                },
                child: Container(
                  height: 100,
                  width: 200,
                  color: Colors.grey,
                  child: Center(
                      child: Text(
                    "Add new category",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, AddNewItemToStore.id);
                },
                child: Container(
                  height: 100,
                  width: 200,
                  color: Colors.grey,
                  child: Center(
                    child: Text(
                      "add new item",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () {},
                child: Container(
                  height: 100,
                  width: 200,
                  color: Colors.grey,
                  child: Center(
                      child: Text(
                    "edit item",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () {},
                child: Container(
                  height: 100,
                  width: 200,
                  color: Colors.grey,
                  child: Center(
                      child: Text(
                    "edit category",
                    style: TextStyle(color: Colors.white),
                  )),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              // Text(
              //   '  Smartbuy ', //from firebase
              //   style: TextStyle(color: Colors.white, fontSize: 20),
              // ),
              // Text(
              //   // 'wishlist description:  this wishlist for my birthday',
              //   '    Retail', //from firebase
              //
              //   style: TextStyle(color: Colors.white),
              // ),
              // Card(
              //
              //   child: IconButton(
              //       onPressed: () {},
              //       icon: const Icon(
              //         Icons.edit,
              //         color: Colors.black,
              //       )),
              // ),
            ],
          ),
        ),

        // Categories(),
        // GestureDetector(
        //   onTap: () {
        //     //add new items
        //   },
        //   child: Padding(
        //     padding: const EdgeInsets.only(left: 200),
        //     child: Column(
        //       children: <Widget>[
        //         Container(
        //           height: 180,
        //           width: 120,
        //           decoration: BoxDecoration(
        //             color: Colors.white,
        //             borderRadius: BorderRadius.circular(16),
        //           ),
        //           child: Icon(
        //             Icons.add,
        //             color: Colors.black,
        //             size: 10,
        //           ),
        //         ),
        //         const Padding(
        //           padding: EdgeInsets.symmetric(vertical: 20.0 / 4),
        //           child: Text(
        //             // products is out demo list
        //             "storeItems",
        //             style: TextStyle(color: Color(0xFFACACAC)),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ]),
    ]);
  }

  // Widget trrrry() {
  //   return Stack(children: [
  //     SingleChildScrollView(
  //         child: Column(children: [
  //       Stack(
  //         children: [
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             children: [
  //               Card(
  //                 child: SizedBox(
  //                   height: 200,
  //                   child: Image.asset(
  //                     'images/asd.jpeg',
  //                     fit: BoxFit.cover,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text(
  //             '  Smartbuy',
  //             style: TextStyle(color: Colors.white, fontSize: 20),
  //           ),
  //           Text(
  //             // 'wishlist description:  this wishlist for my birthday',
  //             '    Retail',

  //             style: TextStyle(color: Colors.white),
  //           ),
  //           Card(
  //             child: IconButton(
  //                 onPressed: () {},
  //                 icon: Icon(
  //                   Icons.add,
  //                   color: Colors.black,
  //                 )),
  //           ),
  //         ],
  //       ),
  //       Categories(),
  //       Padding(
  //         padding: const EdgeInsets.all(8.0),
  //         child: Column(
  //           children: <Widget>[
  //             Container(
  //               padding: EdgeInsets.all(20.0),
  //               // For  demo we use fixed height  and width
  //               // Now we dont need them
  //               // height: 180,
  //               // width: 160,
  //               decoration: BoxDecoration(
  //                 color: Colors.red,
  //                 borderRadius: BorderRadius.circular(16),
  //               ),
  //               child: Hero(
  //                 tag: "test",
  //                 child: IconButton(
  //                   onPressed: () {},
  //                   icon: Icon(Icons.add),
  //                 ),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.symmetric(vertical: 20.0 / 4),
  //               child: Text(
  //                 // products is out demo list
  //                 "storeItems",
  //                 style: TextStyle(color: Color(0xFFACACAC)),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ])),
  //   ]);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            Text(
              'Store Categories',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          trrrry(),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //     child: GridView.builder(
          //       itemCount: storeitems.length,
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2,
          //         mainAxisSpacing: 20.0,
          //         crossAxisSpacing: 20.0,
          //         childAspectRatio: 0.75,
          //       ),
          //       itemBuilder: (context, index) => ItemCard(
          //           storeItems: storeitems[index],
          //           press: () {
          //             // add items to wishlist
          //             // if (isthereIsWishlissts == false) {
          //             //   Alert(
          //             //       context: context,
          //             //       title: "Create wishlist",
          //             //       content: Column(
          //             //         children: <Widget>[
          //             //           SizedBox(
          //             //             height: 45.0,
          //             //             child: TextField(
          //             //               controller: _wishListName,
          //             //               decoration: InputDecoration(
          //             //                 hintText: 'Wishlist name',
          //             //                 hintStyle: TextStyle(
          //             //                   color: Colors.grey,
          //             //                 ),
          //             //                 border: OutlineInputBorder(
          //             //                   borderRadius:
          //             //                       BorderRadius.circular(10.0),
          //             //                   borderSide: BorderSide(
          //             //                     color: Colors.grey,
          //             //                     width: 2.0,
          //             //                   ),
          //             //                 ),
          //             //               ),
          //             //             ),
          //             //           ),
          //             //           SizedBox(
          //             //             height: 30,
          //             //           ),
          //             //           SizedBox(
          //             //             height: 45,
          //             //             child: Container(
          //             //               padding:
          //             //                   EdgeInsets.only(left: 20, right: 16),
          //             //               alignment: Alignment.center,
          //             //               decoration: BoxDecoration(
          //             //                 border: Border.all(
          //             //                     color: Colors.grey, width: 2.0),
          //             //                 borderRadius: BorderRadius.circular(10),
          //             //               ),
          //             //               child: DropdownButton(
          //             //                 value: selecteditem,
          //             //                 isExpanded: true,
          //             //                 hint: Text('Wishlist type'),
          //             //                 underline: Container(),
          //             //                 items: wishlistTypes.map((item) {
          //             //                   return DropdownMenuItem(
          //             //                     child: Text(item),
          //             //                     value: item,
          //             //                   );
          //             //                 }).toList(),
          //             //                 onChanged: (value) {
          //             //                   setState(() {
          //             //                     selecteditem = value.toString();
          //             //                     // for (var i = 0; i < items.length; i++) {
          //             //                     //   if (items[i] == value) {
          //             //                     //     selecteditem = items[i];
          //             //                     //     value = items[i];
          //             //                     //   }
          //             //                     // }
          //             //                   });
          //             //                 },
          //             //               ),
          //             //             ),
          //             //           ),
          //             //         ],
          //             //       ),
          //             //       buttons: [
          //             //         DialogButton(
          //             //           color: Color(0xFF5E57A5),
          //             //           onPressed: () => Navigator.pop(context),
          //             //           child: Text(
          //             //             "Cancel",
          //             //             style: TextStyle(
          //             //                 color: Colors.white, fontSize: 20),
          //             //           ),
          //             //         ),
          //             //         DialogButton(
          //             //           color: Color(0xFF5E57A5),
          //             //           onPressed: () {
          //             //             if (_wishListName.text.isEmpty ||
          //             //                 selecteditem == null) {
          //             //               Fluttertoast.showToast(
          //             //                   msg: "Please fill all the fields",
          //             //                   toastLength: Toast.LENGTH_SHORT,
          //             //                   gravity: ToastGravity.BOTTOM,
          //             //                   timeInSecForIosWeb: 1,
          //             //                   backgroundColor: Colors.red,
          //             //                   textColor: Colors.white,
          //             //                   fontSize: 16.0);
          //             //             } else {
          //             //               setState(() {
          //             //                 if (wishlistNames.length == 4) {
          //             //                   Fluttertoast.showToast(
          //             //                       msg:
          //             //                           "You can only create 4 wishlists",
          //             //                       toastLength: Toast.LENGTH_SHORT,
          //             //                       gravity: ToastGravity.BOTTOM,
          //             //                       timeInSecForIosWeb: 1,
          //             //                       backgroundColor: Colors.red,
          //             //                       textColor: Colors.white,
          //             //                       fontSize: 16.0);
          //             //                 } else if (_wishListName.text.length >
          //             //                     11) {
          //             //                   Fluttertoast.showToast(
          //             //                       msg:
          //             //                           "Wishlist name can't be more than 10 characters",
          //             //                       toastLength: Toast.LENGTH_LONG,
          //             //                       gravity: ToastGravity.BOTTOM,
          //             //                       timeInSecForIosWeb: 1,
          //             //                       backgroundColor: Colors.red,
          //             //                       textColor: Colors.white,
          //             //                       fontSize: 16.0);
          //             //                 } else {
          //             //                   (CreateWishList().addNewWishlist(
          //             //                       _wishListName.text.toString(),
          //             //                       selecteditem));

          //             //                   // }
          //             //                 }
          //             //               });
          //             //               Navigator.pop(context);
          //             //             }
          //             //           },
          //             //           child: Text(
          //             //             "Create",
          //             //             style: TextStyle(
          //             //                 color: Colors.white, fontSize: 20),
          //             //           ),
          //             //         )
          //             //       ]).show();
          //             // }

          //             ///important
          //             //   => Navigator.push(
          //             // context,
          //             // MaterialPageRoute(
          //             //   builder: (context) => DetailsScreen(
          //             //     storeitems: storeitems[index],
          //             //   ),
          //             // ),
          //             // ),
          //           }),
          //     ),
          //   ),
          // ),
        ],
      ),

      // Center(
      //   child: MaterialButton(
      //     color: Colors.blue,
      //     onPressed: () {
      //       FirebaseAuth.instance.signOut();
      //       Navigator.pushReplacement(context,
      //           MaterialPageRoute(builder: (context) => LoginScreen()));
      //     },
      //     child: Text("Sign Out"),
      //   ),
      // ),
    );
  }
}
