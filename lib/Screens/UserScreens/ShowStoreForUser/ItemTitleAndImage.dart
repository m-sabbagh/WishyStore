import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/ShowStoreForUser/StoreItems.dart';

import '../../../constants.dart';

class ItemTitleAndImage extends StatelessWidget {
  String itemImage;
  String itemTitle;
  String itemPrice;
  String itemCategory;

  ItemTitleAndImage({
    required this.itemImage,
    required this.itemTitle,
    required this.itemPrice,
    required this.itemCategory,
  });

  // final StoreItems items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   "Mobile",
          //   style: TextStyle(color: Colors.white),
          // ),
          Text(
            '${itemTitle}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            '${itemCategory}',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "Price\n"),
                    TextSpan(
                      text: "\$${itemPrice}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      itemImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}


//  Container(
//                 height: 250,
//                 width: 250,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(18),
//                   child: Image.network(
//                     itemImage,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               )