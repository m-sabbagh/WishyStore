import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddNewCategory extends StatefulWidget {
  const AddNewCategory({Key? key}) : super(key: key);
  static String id = 'addNewCategory';

  @override
  State<AddNewCategory> createState() => _AddNewCategoryState();
}

class _AddNewCategoryState extends State<AddNewCategory> {
  TextEditingController _categoryName = TextEditingController();

  String? storetype;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStoreType();
  }

  void getStoreType() {
    FirebaseFirestore.instance
        .collection('StoreOwners')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      storetype = value['storeType'];
    });
  }

  void addCategoryToStore() async {
    if (_categoryName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a category name'),
        ),
      );
    } else if (_categoryName.text.length > 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Category name must be less than 10 characters'),
        ),
      );
    } else {
      if (storetype != null) {
        await FirebaseFirestore.instance
            .collection('$storetype Store')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set(
          {
            'categories': {
              _categoryName.text: {},
            }
          },
          SetOptions(merge: true),
        );
        _categoryName.clear();
        Navigator.pop(context);
      }
    }
    // else {
    //   // FirebaseFirestore.instance
    //   //     .collection('stores')
    //   //     .doc(FirebaseAuth.instance.currentUser!.uid)
    //   //     .collection('categories')
    //   //     .doc(_categoryName.text)
    //   //     .set({
    //   //   'categoryName': _categoryName.text,
    //   // });
    //   // _categoryName.clear();
    //   // Navigator.pop(context);

    //   FirebaseFirestore.instance
    //       .collection('stores')
    //       .doc(FirebaseAuth.instance.currentUser!.uid)
    //       .collection('categories')
    //       .doc(_categoryName.text)
    //       .set({
    //     'categoryName': _categoryName.text,
    //   });
    //   _categoryName.clear();
    //   Navigator.pop(context);
    // }
  }

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
              ),
              SizedBox(height: 20.0),
              SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 0.8,
                child: TextField(
                  controller: _categoryName,
                  decoration: InputDecoration(
                    hintText: 'Enter category name',
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
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  onPressed: () {
                    addCategoryToStore();
                  },
                  color: Colors.grey,
                  textColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Add new category"),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              ListTile(
                title: Text(
                  "My categories",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Column(children: [
                  Text(
                    "Retail",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Grocery",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Pharmacy",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
                onTap: () {},
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
    backgroundColor: Colors.black,
    title: Text(
      "Add new category",
      style: TextStyle(color: Colors.white),
    ),
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
