import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/stores/StoreItems.dart';

class ItemCard extends StatelessWidget {
  final StoreItems storeItems;
  final Function? press;

  const ItemCard({
    Key? key,
    required this.storeItems,
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
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  storeItems.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0 / 4),
            child: Text(
              // products is out demo list
              storeItems.title,
              style: TextStyle(color: Color(0xFFACACAC)),
            ),
          ),
          Text(
            "\$${storeItems.price}",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.amber),
          )
        ],
      ),
    );
  }
}
