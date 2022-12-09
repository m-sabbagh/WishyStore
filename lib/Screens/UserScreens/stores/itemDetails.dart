// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:wishy_store/Screens/UserScreens/stores/StoreItems.dart';
// class DetailsScreen extends StatelessWidget {
//   final StoreItems item;

//   const DetailsScreen({Key? key, required this.item}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // each product have a color
//       backgroundColor: item.color,
//       appBar: buildAppBar(context),
//       body: Body(product: product),
//     );
//   }

//   AppBar buildAppBar(BuildContext context) {
//     return AppBar(
//       backgroundColor: product.color,
//       elevation: 0,
//       leading: IconButton(
//         icon: SvgPicture.asset(
//           'assets/icons/back.svg',
//           color: Colors.white,
//         ),
//         onPressed: () => Navigator.pop(context),
//       ),
//       actions: <Widget>[
//         IconButton(
//           icon: SvgPicture.asset("assets/icons/search.svg"),
//           onPressed: () {},
//         ),
//         IconButton(
//           icon: SvgPicture.asset("assets/icons/cart.svg"),
//           onPressed: () {},
//         ),
//         SizedBox(width: kDefaultPaddin / 2)
//       ],
//     );
//   }
// }
