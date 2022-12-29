import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/stores/StoreItems.dart';
import 'package:wishy_store/Screens/UserScreens/stores/test2.dart';
import 'package:wishy_store/Screens/UserScreens/stores/test3.dart';

class BodyOfDetails extends StatelessWidget {
  final StoreItems items;

  const BodyOfDetails({Key? key, required this.items}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                    top: size.height * 0.12,
                    left: 20.0,
                    right: 20.0,
                  ),
                  // height: 500,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      // ColorAndSize(items: items),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Color"),
                                Row(
                                  children: <Widget>[
                                    // ColorDot(
                                    //   color: Color(0xFF356C95),
                                    //   isSelected: true,
                                    // ),
                                    // ColorDot(color: Color(0xFFF8C078)),
                                    // ColorDot(color: Color(0xFFA29B9B)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.amber),
                                children: [
                                  TextSpan(text: "Size\n"),
                                  TextSpan(
                                    text: "${items.size} cm",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0 / 2),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          items.description,
                          style: TextStyle(height: 1.5),
                        ),
                      ),
                      SizedBox(height: 20.0 / 2),
                      // CounterWithFavBtn(),
                      SizedBox(height: 20.0 / 2),
                      AddtoWishlistButton(items: items),
                    ],
                  ),
                ),
                ProductTitleWithImage(items: items)
              ],
            ),
          )
        ],
      ),
    );
  }
}
