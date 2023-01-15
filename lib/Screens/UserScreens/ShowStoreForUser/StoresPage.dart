import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/ShowStoreForUser/StorePage.dart';
import 'package:wishy_store/Screens/UserScreens/ShowStoreForUser/ListOfStores.dart';

class UserStorePage extends StatefulWidget {
  const UserStorePage({Key? key}) : super(key: key);
  static String id = 'user_store_page';

  @override
  State<UserStorePage> createState() => _UserStorePageState();
}

//store categories are hardcoded , that means that we dont need firebase to store them
//we can just use a list of strings to store them
//we can also use a list of widgets to store them

class _UserStorePageState extends State<UserStorePage> {
  List<String> storeCategories = [
    'Retail',
    'Grocery',
    'Pharmacy',
    'Fashion',
    'Electronics',
    'Home Appliances',
    'Sports',
    'Books',
    'Toys',
    'Furniture',
    'Food',
    'Others'
  ];

  List<String> retailStoresUserIds = [];
  Map<String, dynamic> storeData = {};

  List<String> giftCenterUserIds = [];

  List<String> userIdForRetailStores = [];

  void passOnEveryDocumment() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('StoreOwners');
    collectionReference.get().then((value) {
      value.docs.forEach((element) {
        // print(element.data());
        storeData = element.data() as Map<String, dynamic>;

        // print(storeData['storeType']);

        if (storeData['storeType'] == 'Gift centers store') {
          giftCenterUserIds.add(storeData['uId']);

          print(storeData['uId']);
          // userIdForRetailStores.add(storeData['userId']);
        }
      });
    });

    // collectionReference.startAtDocument(DocumentSnapshot .fromMap
    // ({
    //   'storeName': 'Smart Buy',
    // })).get().then((value) {
    //   value.docs.forEach((element) {
    //     print(element.data());
    //   });
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passOnEveryDocumment();
  }

  Widget StoreCard() {
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.pushNamed(context, StorePage.id);
        });
      },
      child: Column(
        children: [
          Container(
            height: 180,
            width: 130,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox.fromSize(
                size: Size.fromRadius(80), // Image radius
                child: Image.asset('images/Deal_of_the_Day-11_400x400.png',
                    fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Smart Buy',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget CategoryCard() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          // StoreCard(),
          GestureDetector(
            onTap: () async {},
            child: Container(
              height: 150,
              width: 130,
              color: Colors.purple[800],
              child: Center(
                  child: Text(
                'Retail',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              )),
              // child: ClipRRect(
              //   borderRadius: BorderRadius.circular(20),
              //   child: SizedBox.fromSize(
              //     size: Size.fromRadius(80), // Image radius
              //     child: Image.asset('images/Deal_of_the_Day-11_400x400.png',
              //         fit: BoxFit.cover),
              //   ),
              // ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            height: 150,
            width: 130,
            color: Colors.purple[800],
            child: Center(
              child: Text(
                'Health and Beauty',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),

            // child: ClipRRect(
            //   borderRadius: BorderRadius.circular(20),
            //   child: SizedBox.fromSize(
            //     size: Size.fromRadius(80), // Image radius
            //     child: Image.asset('images/Deal_of_the_Day-11_400x400.png',
            //         fit: BoxFit.cover),
            //   ),
            // ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            height: 150,
            width: 130,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: SizedBox.fromSize(
                size: Size.fromRadius(80), // Image radius
                child: Image.asset('images/Deal_of_the_Day-11_400x400.png',
                    fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Stores', style: TextStyle(color: Colors.white, fontSize: 30)),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    EvaIcons.search,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 17, 14, 35),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            StoreCard(),
            CategoryCard(),
            SizedBox(
              height: 20,
            ),

            ListTile(
              onTap: () async {
                // ListOfStores

                //i want to navigatoe to the list of stores
                //and i want to send the list of user ids of the stores

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return ListOfStores(
                        listOfStoreOwnerIds_UserId: giftCenterUserIds,
                        storeType: 'Gift centers stores');
                  }),
                );
              },
              // subtitle: Text(
              //   'Retail',
              //   style: TextStyle(color: Colors.white, fontSize: 20),
              // ),
              leading: Image.asset(
                'images/Deal_of_the_Day-11_400x400.png',
                height: 100,
                width: 100,
              ),
              title: Text(
                'Gift centers stores',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              // trailing: Icon(
              //   Icons.arrow_forward_ios,
              //   color: Colors.white,
              // ),
            ),
            SizedBox(
              height: 20,
            ),

            // Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'Retail',
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//               ),
//               RRRR(),
//               SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 height: 20,
//               ),

//  body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: 1,
//               ),
//               ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemBuilder: ((context, index) {
//                     return SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               RRRR(),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               RRRR(),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               RRRR(),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               RRRR(),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//                   itemCount: 4),
//             ],
//           ),
//         ),
//       ),
          ],
        ),
      ),
    );
  }
}

// Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   'Retail',
//                   style: TextStyle(color: Colors.white, fontSize: 20),
//                 ),
//               ),
//               RRRR(),
//               SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 height: 20,
//               ),

//  body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(
//                 width: 1,
//               ),
//               ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   itemBuilder: ((context, index) {
//                     return SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               RRRR(),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               RRRR(),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               RRRR(),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               RRRR(),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     );
//                   }),
//                   itemCount: 4),
//             ],
//           ),
//         ),
//       ),
