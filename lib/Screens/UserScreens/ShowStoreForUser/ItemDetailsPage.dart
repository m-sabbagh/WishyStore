import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/ShowStoreForUser/AddtoWishlistButton.dart';
import 'package:wishy_store/Screens/UserScreens/ShowStoreForUser/ItemTitleAndImage.dart';

// Scaffold(

class ItemDetailsPage extends StatefulWidget {
  String itemBarcode;
  String itemTitle;
  String itemPrice;
  String itemImage;
  String itemDescription;
  String itemCategory;
  String storeName;

  ItemDetailsPage({
    required this.itemBarcode,
    required this.itemTitle,
    required this.itemPrice,
    required this.itemImage,
    required this.itemDescription,
    required this.itemCategory,
    required this.storeName,
  });

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 14, 35),

      // each product have a color
      // backgroundColor: item.color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[SizedBox(width: 20.0 / 2)],
      ),
      body: SingleChildScrollView(
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
                                      text: "cm",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                            widget.itemDescription,
                            style: TextStyle(height: 1.5),
                          ),
                        ),
                        SizedBox(height: 20.0 / 2),
                        // CounterWithFavBtn(),
                        SizedBox(height: 20.0 / 2),
                        AddToWishlistButton(
                          itemBarcode: widget.itemBarcode,
                          itemTitle: widget.itemTitle,
                          itemPrice: widget.itemPrice,
                          itemImage: widget.itemImage,
                          itemCategory: widget.itemCategory,
                          itemDescription: widget.itemDescription,
                          itemStoreName: widget.storeName,
                        ),
                      ],
                    ),
                  ),
                  ItemTitleAndImage(
                    // itemBarcode: widget.itemBarcode,
                    itemTitle: widget.itemTitle,
                    itemPrice: widget.itemPrice,
                    itemImage: widget.itemImage,
                    itemCategory: widget.itemCategory,
                    // itemDescription: widget.itemDescription,
                    // itemCategory: widget.itemCategory,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
