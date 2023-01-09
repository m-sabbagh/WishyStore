import 'package:flutter/material.dart';

class AddNewItemToStore extends StatelessWidget {
  static String id = 'addNewItemToStore';

  const AddNewItemToStore({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              MaterialButton(
                onPressed: () {},
                child: Text(
                  "Show item example",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              SizedBox(height: 20.0),
              //To add new item

// Store owner must add

// Item id /barcode
// Item category
// Item picture
// Item title
// Item price
// Item description
              SizedBox(
                height: 100,
                child: TextField(
                  // controller: _emailcontroller,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),

              TextField(
                decoration: InputDecoration(
                  hintText: "Item id /barcode",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  fillColor: Colors.black,
                  iconColor: Colors.black,
                  hintText: "Item category",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  hintText: "Item picture",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  hintText: "Item title",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  hintText: "Item price",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                decoration: InputDecoration(
                  hintText: "Item description",
                  hintStyle: TextStyle(color: Colors.black),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              MaterialButton(
                onPressed: () {},
                child: Text(
                  "Add item",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: Text("Add new item to store"),
    backgroundColor: Colors.black,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () => Navigator.pop(context),
    ),
    actions: <Widget>[SizedBox(width: 20.0 / 2)],
  );
}

// SizedBox(
//               height: size.height,
//               child: Stack(
//                 children: <Widget>[
//                   Container(
//                     margin: EdgeInsets.only(top: size.height * 0.3),
//                     padding: EdgeInsets.only(
//                       top: size.height * 0.12,
//                       left: 20.0,
//                       right: 20.0,
//                     ),
//                     // height: 500,
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(24),
//                         topRight: Radius.circular(24),
//                       ),
//                     ),
//                     child: Column(
//                       children: <Widget>[
//                         // ColorAndSize(items: items),
//                         Row(
//                           children: <Widget>[
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Text(
//                                     "Category ",
//                                     style: TextStyle(color: Colors.black),
//                                   ),
//                                   Row(
//                                     children: const <Widget>[
//                                       // ColorDot(
//                                       //   color: Color(0xFF356C95),
//                                       //   isSelected: true,
//                                       // ),
//                                       // ColorDot(color: Color(0xFFF8C078)),
//                                       // ColorDot(color: Color(0xFFA29B9B)),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: RichText(
//                                 text: TextSpan(
//                                   style: TextStyle(color: Colors.black),
//                                   children: [
//                                     TextSpan(text: 'Smartbuy \n'),
//                                     TextSpan(text: "Barcode\n"),
//                                     TextSpan(
//                                       text: "12319283784",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 20.0 / 2),

//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 20.0),
//                           child: TextField(
//                             style: TextStyle(
//                               color: Colors.black,
//                             ),
//                             //multi line
//                             maxLines: 5,
//                             decoration: InputDecoration(
//                               hintText: "Item description",
//                               hintStyle: TextStyle(
//                                 color: Colors.black.withOpacity(0.5),
//                               ),
//                               enabledBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.black.withOpacity(0.5),
//                                 ),
//                               ),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(
//                                   color: Colors.black.withOpacity(0.5),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),

//                         SizedBox(height: 20.0 / 2),
//                         // CounterWithFavBtn(),
//                         SizedBox(height: 20.0 / 2),
//                         // AddtoWishlistButton2(),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 20.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           "Mobile",
//                           style: TextStyle(color: Colors.black),
//                         ),
//                         TextField(
//                           style: TextStyle(
//                             color: Colors.black,
//                           ),
//                           decoration: InputDecoration(
//                             hintText:
//                                 "Please enter Item title example iPhone 12",
//                             hintStyle: TextStyle(
//                               color: Colors.black.withOpacity(0.5),
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.black.withOpacity(0.5),
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 color: Colors.black.withOpacity(0.5),
//                               ),
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 10.0),
//                         Row(
//                           children: <Widget>[
//                             RichText(
//                               text: const TextSpan(
//                                 children: [
//                                   TextSpan(
//                                       text: "Price\n",
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold)),
//                                   TextSpan(
//                                     text: '\$\$\$',
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Expanded(
//                               child: TextField(
//                                 style: TextStyle(
//                                   color: Colors.black,
//                                 ),
//                                 decoration: InputDecoration(
//                                   hintText: "Please enter Item price",
//                                   hintStyle: TextStyle(
//                                     color: Colors.black.withOpacity(0.5),
//                                   ),
//                                   enabledBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Colors.black.withOpacity(0.5),
//                                     ),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Colors.black.withOpacity(0.5),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: 20.0),
//                             Expanded(
//                               child: Container(
//                                 child: Column(
//                                   children: [
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(18),
//                                       child: Image.asset(
//                                         'images/new/upload_image.png',
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             )
