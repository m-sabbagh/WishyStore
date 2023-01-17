import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/UserStorePages/AddtoWishlistButton.dart';
import 'package:wishy_store/Screens/UserScreens/UserStorePages/ItemTitleAndImage.dart';

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
      // each product have a color
      // backgroundColor: item.color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            EvaIcons.arrowBack,
            color: Colors.black87,
          ),
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
                      color: Color.fromARGB(255, 27, 26, 37),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      children: <Widget>[
                        // ColorAndSize(items: items),
                        SizedBox(height: 20.0),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(text: "Category: "),
                                    TextSpan(
                                        text: widget.itemCategory,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  children: [
                                    TextSpan(text: "Barcode: "),
                                    TextSpan(
                                        text: widget.itemBarcode,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))
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
                            style: TextStyle(
                              height: 1.5,
                              color: Colors.white,
                            ),
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
                    storeName: widget.storeName,
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
