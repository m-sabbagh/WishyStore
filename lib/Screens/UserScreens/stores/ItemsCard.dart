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
              padding: EdgeInsets.all(20.0),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                color: storeItems.color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${storeItems.id}",
                child: Image.asset(storeItems.image),
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
