import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wishy_store/Screens/UserScreens/stores/StoreItems.dart';
import 'package:wishy_store/Screens/UserScreens/stores/test.dart';

class DetailsScreen extends StatelessWidget {
  final StoreItems item;

  const DetailsScreen({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // each product have a color
      backgroundColor: item.color,
      appBar: buildAppBar(context),
      body: BodyOfDetails(items: item),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: item.color,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[SizedBox(width: 20.0 / 2)],
    );
  }
}
