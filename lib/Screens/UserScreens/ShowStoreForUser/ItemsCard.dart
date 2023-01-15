import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/ShowStoreForUser/StoreItems.dart';

class ItemCard extends StatelessWidget {
  String itemImage;
  String itemTitle;
  String itemPrice;
  //image
  //price
  //title
  // final StoreItems storeItems;
  Function? press;

  ItemCard({
    Key? key,
    required this.itemImage,
    required this.itemTitle,
    required this.itemPrice,
    // required this.storeItems,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function()?,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  itemImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0 / 4),
            child: Text(
              itemTitle,
              style: TextStyle(color: Color(0xFFACACAC)),
            ),
          ),
          Text(
            "\$${itemPrice}",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
          )
        ],
      ),
    );
  }
}
