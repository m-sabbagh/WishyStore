import 'package:flutter/material.dart';

import 'package:wishy_store/Screens/UserScreens/stores/ItemsCard.dart';
import 'package:wishy_store/Screens/UserScreens/stores/category.dart';
import 'package:wishy_store/Screens/UserScreens/stores/StoreItems.dart';
import 'package:wishy_store/Screens/UserScreens/stores/itemDetails.dart';
import 'package:wishy_store/Widgets/postiontedArrowBack.dart';

class StoreOne extends StatefulWidget {
  const StoreOne({Key? key}) : super(key: key);

  static String id = 'store1';
  @override
  State<StoreOne> createState() => _StoreOneState();
}

class _StoreOneState extends State<StoreOne> {
  // Widget listofItems() {
  //   return ListTile(
  //     leading: Stack(
  //       children: [
  //       Image.asset(
  //         'images/asd.jpeg',
  //         fit: BoxFit.cover,
  //       ),
  //       Text('smartbuy'),
  //     ]),
  //     trailing: Text(
  //       'add to wishlist',
  //       style: TextStyle(color: Colors.white),
  //     ),
  //     title: Text(
  //       'Iphone 14 Pro max',
  //       style: TextStyle(color: Colors.white),
  //     ),
  //     subtitle: Text(
  //       '550',
  //       style: TextStyle(color: Colors.white),
  //     ),
  //   );
  // }

  //store image , store name , store type , store description

  Widget trrrry() {
    return Stack(children: [
      SingleChildScrollView(
          child: Column(children: [
        Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: SizedBox(
                    height: 200,
                    child: Image.asset(
                      'images/asd.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            positionedArrowBack(context, Color(0xff1F1C2C)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '  Smartbuy',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              // 'wishlist description:  this wishlist for my birthday',
              '    Retail',

              style: TextStyle(color: Colors.white),
            ),
            Card(
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
            ),
          ],
        ),
        Categories(),
      ])),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 14, 35),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          trrrry(),

          //for the items
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
              child: GridView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: storeitems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPaddin,
                  crossAxisSpacing: kDefaultPaddin,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) => ItemCard(
                  storeItems: storeitems[index],
                  press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        item: storeitems[index],
                      ),
                    ),
                  ),

// ensa had
//                       // add items to wishlist
//                       // if (isthereIsWishlissts == false) {
//                       //   Alert(
//                       //       context: context,
//                       //       title: "Create wishlist",
//                       //       content: Column(
//                       //         children: <Widget>[
//                       //           SizedBox(
//                       //             height: 45.0,
//                       //             child: TextField(
//                       //               controller: _wishListName,
//                       //               decoration: InputDecoration(
//                       //                 hintText: 'Wishlist name',
//                       //                 hintStyle: TextStyle(
//                       //                   color: Colors.grey,
//                       //                 ),
//                       //                 border: OutlineInputBorder(
//                       //                   borderRadius:
//                       //                       BorderRadius.circular(10.0),
//                       //                   borderSide: BorderSide(
//                       //                     color: Colors.grey,
//                       //                     width: 2.0,
//                       //                   ),
//                       //                 ),
//                       //               ),
//                       //             ),
//                       //           ),
//                       //           SizedBox(
//                       //             height: 30,
//                       //           ),
//                       //           SizedBox(
//                       //             height: 45,
//                       //             child: Container(
//                       //               padding:
//                       //                   EdgeInsets.only(left: 20, right: 16),
//                       //               alignment: Alignment.center,
//                       //               decoration: BoxDecoration(
//                       //                 border: Border.all(
//                       //                     color: Colors.grey, width: 2.0),
//                       //                 borderRadius: BorderRadius.circular(10),
//                       //               ),
//                       //               child: DropdownButton(
//                       //                 value: selecteditem,
//                       //                 isExpanded: true,
//                       //                 hint: Text('Wishlist type'),
//                       //                 underline: Container(),
//                       //                 items: wishlistTypes.map((item) {
//                       //                   return DropdownMenuItem(
//                       //                     child: Text(item),
//                       //                     value: item,
//                       //                   );
//                       //                 }).toList(),
//                       //                 onChanged: (value) {
//                       //                   setState(() {
//                       //                     selecteditem = value.toString();
//                       //                     // for (var i = 0; i < items.length; i++) {
//                       //                     //   if (items[i] == value) {
//                       //                     //     selecteditem = items[i];
//                       //                     //     value = items[i];
//                       //                     //   }
//                       //                     // }
//                       //                   });
//                       //                 },
//                       //               ),
//                       //             ),
//                       //           ),
//                       //         ],
//                       //       ),
//                       //       buttons: [
//                       //         DialogButton(
//                       //           color: Color(0xFF5E57A5),
//                       //           onPressed: () => Navigator.pop(context),
//                       //           child: Text(
//                       //             "Cancel",
//                       //             style: TextStyle(
//                       //                 color: Colors.white, fontSize: 20),
//                       //           ),
//                       //         ),
//                       //         DialogButton(
//                       //           color: Color(0xFF5E57A5),
//                       //           onPressed: () {
//                       //             if (_wishListName.text.isEmpty ||
//                       //                 selecteditem == null) {
//                       //               Fluttertoast.showToast(
//                       //                   msg: "Please fill all the fields",
//                       //                   toastLength: Toast.LENGTH_SHORT,
//                       //                   gravity: ToastGravity.BOTTOM,
//                       //                   timeInSecForIosWeb: 1,
//                       //                   backgroundColor: Colors.red,
//                       //                   textColor: Colors.white,
//                       //                   fontSize: 16.0);
//                       //             } else {
//                       //               setState(() {
//                       //                 if (wishlistNames.length == 4) {
//                       //                   Fluttertoast.showToast(
//                       //                       msg:
//                       //                           "You can only create 4 wishlists",
//                       //                       toastLength: Toast.LENGTH_SHORT,
//                       //                       gravity: ToastGravity.BOTTOM,
//                       //                       timeInSecForIosWeb: 1,
//                       //                       backgroundColor: Colors.red,
//                       //                       textColor: Colors.white,
//                       //                       fontSize: 16.0);
//                       //                 } else if (_wishListName.text.length >
//                       //                     11) {
//                       //                   Fluttertoast.showToast(
//                       //                       msg:
//                       //                           "Wishlist name can't be more than 10 characters",
//                       //                       toastLength: Toast.LENGTH_LONG,
//                       //                       gravity: ToastGravity.BOTTOM,
//                       //                       timeInSecForIosWeb: 1,
//                       //                       backgroundColor: Colors.red,
//                       //                       textColor: Colors.white,
//                       //                       fontSize: 16.0);
//                       //                 } else {
//                       //                   (CreateWishList().addNewWishlist(
//                       //                       _wishListName.text.toString(),
//                       //                       selecteditem));

//                       //                   // }
//                       //                 }
//                       //               });
//                       //               Navigator.pop(context);
//                       //             }
//                       //           },
//                       //           child: Text(
//                       //             "Create",
//                       //             style: TextStyle(
//                       //                 color: Colors.white, fontSize: 20),
//                       //           ),
//                       //         )
//                       //       ]).show();
//                       // }

                  //this code for sharing to a wishlist

                  // showDialog<String>(
                  //   context: context,
                  //   builder: (BuildContext context) => AlertDialog(
                  //     title: const Text('Please pick your wishlist'),
                  //     content: Container(
                  //       height: 200,
                  //       child: SingleChildScrollView(
                  //         child: Column(
                  //           children: [
                  //             for (var i = 0; i < wishlistNames.length; i++)
                  //               ListTile(
                  //                 leading: Radio(
                  //                     value: "radio value",
                  //                     groupValue: "group value",
                  //                     onChanged: (value) {
                  //                       print(wishlistNames[i].toString());
                  //                       wishlistName = wishlistNames[i];
                  //                       setState(() {
                  //                         AddItemsToWishlist().addNewItems(
                  //                           //improtant , this works !
                  //                           // wName: 'wishlist1',
                  //                           wName: wishlistName,
                  //                           itemPrice: storeitems[index]
                  //                               .price
                  //                               .toString(),
                  //                           itemTitle: storeitems[index]
                  //                               .title
                  //                               .toString(),
                  //                           imageUrl: storeitems[index]
                  //                               .image
                  //                               .toString(),
                  //                         );
                  //                       });
                  //                       //selected value
                  //                     }),
                  //                 title: Text(wishlistNames[i]),
                  //                 onTap: () {
                  //                   //   setState(() {
                  //                   //   AddItemsToWishlist().addNewItems(
                  //                   //     //improtant , this works !
                  //                   //     // wName: 'wishlist1',
                  //                   //     wName: wishlistName,
                  //                   //     itemPrice: storeitems[index]
                  //                   //         .price
                  //                   //         .toString(),
                  //                   //     itemTitle: storeitems[index]
                  //                   //         .title
                  //                   //         .toString(),
                  //                   //     photoUrl: storeitems[index]
                  //                   //         .image
                  //                   //         .toString(),
                  //                   //   );
                  //                   // });
                  //                 },
                  //               ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     actions: <Widget>[
                  //       TextButton(
                  //         onPressed: () => Navigator.pop(context, 'Cancel'),
                  //         child: const Text('Cancel'),
                  //       ),
                  //       TextButton(
                  //         onPressed: () => Navigator.pop(context, 'OK'),
                  //         child: const Text('OK'),
                  //       ),
                  //     ],
                  //   ),
                  // );

                  // // /important
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//  Expanded(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
//           child: GridView.builder(
//               itemCount: storeitems.length,
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: kDefaultPaddin,
//                 crossAxisSpacing: kDefaultPaddin,
//                 childAspectRatio: 0.75,
//               ),
//               itemBuilder: (context, index) => ItemCard(
//                   storeItems: storeitems[index],
//                   press: () {
//                     Fluttertoast.showToast(msg: 'msg');

//                     //   => Navigator.push(
//                     // context,
//                     // MaterialPageRoute(
//                     //   builder: (context) => DetailsScreen(
//                     //     product: products[index],
//                     //   ),
//                     // ),
//                     // ),
//                   })),
//         ),
//       ),
