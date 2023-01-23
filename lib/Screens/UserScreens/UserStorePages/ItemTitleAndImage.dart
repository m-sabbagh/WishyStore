import 'package:flutter/material.dart';

import '../../../constants.dart';

class ItemTitleAndImage extends StatelessWidget {
  String itemImage;
  String itemTitle;
  String itemPrice;
  String itemCategory;
  String storeName;

  ItemTitleAndImage({
    required this.itemImage,
    required this.itemTitle,
    required this.itemPrice,
    required this.itemCategory,
    required this.storeName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${itemTitle}',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          Text(
            '${itemCategory} - ${storeName}',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Price\n",
                      style: TextStyle(
                        color: Colors.black87,
                      ),
                    ),
                    TextSpan(
                      text: "${itemPrice}JD",
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 10.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox.fromSize(
                  size: Size(280, 300),
                  child: Image.network(itemImage, fit: BoxFit.cover),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
