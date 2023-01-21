import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/UserStorePages/ItemsCard.dart';
import 'package:wishy_store/Screens/UserScreens/UserStorePages/ItemDetailsPage.dart';
import 'package:wishy_store/Widgets/postiontedArrowBack.dart';

class StorePage extends StatefulWidget {
  String storeName;
  String storeOwnerUid;
  String storeType;
  List<String> storeCategories = [];

  //you can get the store logo easily if u need

  StorePage(
      {required this.storeName,
      required this.storeOwnerUid,
      required this.storeType,
      required this.storeCategories});

  static String id = 'store_page';
  @override
  State<StorePage> createState() => _StorePageState(
      storeName: storeName,
      storeOwnerUid: storeOwnerUid,
      storeType: storeType,
      storeCategories: storeCategories);
}

class _StorePageState extends State<StorePage> with TickerProviderStateMixin {
  String storeName;
  String storeOwnerUid;
  String storeType;
  List<String> storeCategories = [];

  _StorePageState(
      {required this.storeName,
      required this.storeOwnerUid,
      required this.storeType,
      required this.storeCategories});

  Widget storeCoverAndElements() {
    return SingleChildScrollView(
        child: Column(children: [
      Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('StoreOwners')
                    .doc(storeOwnerUid)
                    .get(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 200,
                      child: Image.network(
                        snapshot.data['storeLogo'],
                        fit: BoxFit.cover,
                      ),
                    );
                  } else {
                    return Card(
                      child: SizedBox(
                        height: 200,
                        child: Image.asset(
                          'images/dummyImageCoverLogo.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          positionedArrowBack(context, Color(0xff1F1C2C)),
        ],
      ),
      SizedBox(
        height: 10,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              storeName,
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: SizedBox(
              width: 10,
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4,
            child: SizedBox(
              height: 40,
              width: 40,
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.search),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      SizedBox(
        height: 10,
      ),
    ]));
  }

  Widget itemsGridView({required String categoryName}) {
    return
        // for (var i = 0; i < howManyCategory; i++)
        FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('StoreOwners')
          .doc(storeOwnerUid)
          .get(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['categories'][categoryName].isEmpty) {
            return Center(
              child: Text(
                'No Items in this category',
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            );
          } else
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GridView.builder(
                  padding: EdgeInsets.only(top: 10),
                  // item count supposed to be according to the number of items in the category

                  itemCount: snapshot.data['categories'][categoryName].length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 20.0,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('StoreOwners')
                            .doc(storeOwnerUid)
                            .get(),
                        builder: (context, AsyncSnapshot snapshot) {
                          //get the item image and item title and item price and call the item card for each
                          if (snapshot.hasData) {
                            Map categoryItems =
                                snapshot.data['categories'][categoryName];
                            return ItemCard(
                                itemImage: categoryItems.values.toList()[index]
                                    ['itemImage'],
                                // itemTitle: categoryItems.keys.toList()[index]
                                itemTitle: categoryItems.values.toList()[index]
                                    ['itemTitle'],
                                itemPrice: categoryItems.values.toList()[index]
                                    ['itemPrice'],
                                press: () {
                                  // send the item description too
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ItemDetailsPage(
                                        itemCategory: categoryName,
                                        itemBarcode: categoryItems.values
                                            .toList()[index]['itemBarcode'],
                                        itemDescription: categoryItems.values
                                            .toList()[index]['itemDescription'],
                                        itemImage: categoryItems.values
                                            .toList()[index]['itemImage'],
                                        itemTitle: categoryItems.values
                                            .toList()[index]['itemTitle'],
                                        itemPrice: categoryItems.values
                                            .toList()[index]['itemPrice'],
                                        storeName: storeName,
                                        showAddToWishlistButton: true,
                                      ),
                                    ),
                                  );
                                });
                          } else {
                            return ItemCard(
                                itemImage:
                                    'https://reactnativecode.com/wp-content/uploads/2018/02/Default_Image_Thumbnail.png',
                                itemTitle: 'loading',
                                itemPrice: 'loading',
                                press: () {});
                          }
                        });
                  }),
            );
        } else
          return Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController =
        TabController(length: storeCategories.length, vsync: this);
    List<Tab> listOfTabs = [
      for (var i = 0; i < storeCategories.length; i++)
        Tab(
          text: storeCategories[i],
        )
    ];
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          storeCoverAndElements(),
          Expanded(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                    controller: _tabController,
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    labelColor: Colors.black87,
                    labelStyle: TextStyle(fontSize: 13),
                    indicatorColor: Colors.black87,
                    tabs: listOfTabs,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: listOfTabs.map((Tab tab) {
                      final String label = tab.text!;
                      return itemsGridView(categoryName: label);
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
