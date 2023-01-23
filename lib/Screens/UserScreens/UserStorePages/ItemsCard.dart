import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  String itemImage;
  String itemTitle;
  String itemPrice;

  Function? press;

  ItemCard({
    Key? key,
    required this.itemImage,
    required this.itemTitle,
    required this.itemPrice,
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
              style: TextStyle(color: Color.fromARGB(255, 57, 54, 54)),
            ),
          ),
          Text(
            "${itemPrice}JD",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          )
        ],
      ),
    );
  }
}
