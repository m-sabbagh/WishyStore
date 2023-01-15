// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:wishy_store/Screens/User/StoreOwner%20shared%20screens/NewSettings/StoreOwnerSignUp.dart';

// class pv extends StatefulWidget {
//   const pv({Key? key}) : super(key: key);
//   @override
//   _pvState createState() => _pvState();
//   static String id = 'pv';
// }

// class _pvState extends State<pv> {
//   final _pageController = PageController();
//   bool _isLastPage = false;
//   @override
//   Widget build(BuildContext context) => Scaffold(
//         body: Container(
//           padding: EdgeInsets.only(bottom: 80),
//           child: PageView(
//             onPageChanged: (int page) {
//               setState(() {
//                 _isLastPage = page == 3;
//               });
//             },
//             controller: _pageController,
//             children: [
//               Container(
//                 color: Colors.green[200],
//                 child: Column(children: [
//                   Text(
//                     'welcome to wishy',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ]),
//               ),
//               Container(
//                 color: Colors.blue[200],
//                 child: Column(children: [
//                   Image.asset(
//                     'images/letsgetstarted.jpg',
//                     fit: BoxFit.cover,
//                   ),
//                   Text(
//                     'welcome to wishy',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ]),
//               ),
//               Container(
//                 color: Colors.red[200],
//                 child: Column(children: [
//                   Image.asset(
//                     'images/letsgetstarted.jpg',
//                     fit: BoxFit.cover,
//                   ),
//                   Text(
//                     'welcome to wishy',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ]),
//               ),
//               Container(
//                 color: Colors.yellow[200],
//                 child: Column(children: [
//                   Image.asset(
//                     'images/letsgetstarted.jpg',
//                     fit: BoxFit.cover,
//                   ),
//                   Text(
//                     'welcome to wishy',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ]),
//               )
//             ],
//           ),
//         ),
//         bottomSheet: _isLastPage
//             ? TextButton(
//                 style: TextButton.styleFrom(
//                     backgroundColor: Colors.yellow[800],
//                     foregroundColor: Colors.white,
//                     minimumSize: Size.fromHeight(80)),
//                 onPressed: () => print('Get Started'),
//                 child: Text('Get Started'),
//               )
//             : Container(
//                 height: 80,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     TextButton(
//                       onPressed: () => _pageController.previousPage(
//                         duration: Duration(milliseconds: 300),
//                         curve: Curves.easeIn,
//                       ),
//                       child: Text('previous'),
//                     ),
//                     Center(
//                       child: SmoothPageIndicator(
//                         controller: _pageController,
//                         count: 4,
//                         effect: SwapEffect(
//                           dotHeight: 10,
//                           dotWidth: 10,
//                           spacing: 8,
//                           radius: 4,
//                           dotColor: Colors.grey,
//                           activeDotColor: Colors.blue,
//                         ),
//                       ),
//                     ),
//                     TextButton(
//                       onPressed: () => _pageController.nextPage(
//                         duration: Duration(milliseconds: 300),
//                         curve: Curves.easeIn,
//                       ),
//                       child: Text('Next'),
//                     )
//                   ],
//                 ),
//               ),
//       );
// }
