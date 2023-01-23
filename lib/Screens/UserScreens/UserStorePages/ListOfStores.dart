import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/UserStorePages/StorePage.dart';

class ListOfStores extends StatefulWidget {
  List<String> listOfStoreOwnerIds_UserId;
  String storeType;
  ListOfStores(
      {Key? key,
      required this.listOfStoreOwnerIds_UserId,
      required this.storeType})
      : super(key: key);

  @override
  State<ListOfStores> createState() => _ListOfStoresState(
      listOfStoreOwnerIds_UserId: listOfStoreOwnerIds_UserId,
      storetype: storeType);
}

List<String> storesnames = [];
List<String> storesimages = [];
List<String> storesowners = [];
List<List<String>> storescategories = [];
String? storetypes;

class _ListOfStoresState extends State<ListOfStores> {
  List<String> listOfStoreOwnerIds_UserId;
  String storetype;
  _ListOfStoresState(
      {required this.listOfStoreOwnerIds_UserId, required this.storetype});

  @override
  void initState() {
    super.initState();
    // getStores();
    storesnames.clear();
    storesimages.clear();
    storesowners.clear();
    storescategories.clear();
  }

  Widget StoreCard({
    required String storeName,
    required String imageURL,
    required String userId,
    required List<String> storecategories,
  }) {
    if (storeName != 'Loading') {
      storesnames.add(storeName);
      storesimages.add(imageURL);
      storesowners.add(userId);
      storescategories.add(storecategories);
      storetypes = storetype;
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StorePage(
                        storeName: storeName,
                        storeType: storetype,
                        storeOwnerUid: userId,
                        storeCategories: storecategories,
                      )));
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: 180,
                  width: 130,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(80),
                      child: Image.network((imageURL), fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                storeName,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget storeCards({required String userId}) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('StoreOwners')
          .doc(userId)
          .get(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong , try again later',
              style: TextStyle(color: Colors.white),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          storesnames.clear();
          storesimages.clear();
          storesowners.clear();
          storescategories.clear();
          return StoreCard(
            storeName: 'Loading',
            imageURL:
                'https://reactnativecode.com/wp-content/uploads/2018/02/Default_Image_Thumbnail.png',
            userId: 'userId',
            storecategories: [],
          );
        }
        if (snapshot.hasData && !snapshot.data!.exists) {
          return Center(
            child: Text('Document does not exist'),
          );
        }
        if (snapshot.hasData) {
          storesnames.clear();
          storesimages.clear();
          storesowners.clear();
          storescategories.clear();
          return StoreCard(
            storeName: snapshot.data!['storeName'],
            imageURL: snapshot.data!['storeLogo'],
            userId: userId,
            storecategories: snapshot.data!['categories'].keys.toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
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
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                EvaIcons.arrowBack,
                color: Colors.black87,
              ),
            ),
            Expanded(
              child: Text(
                '${storetype}s',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: delegate());
              },
              icon: Icon(
                EvaIcons.search,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: listOfStoreOwnerIds_UserId.length,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              return storeCards(userId: listOfStoreOwnerIds_UserId[index]);
            },
          ),
        ),
      ),
    );
  }
}

class delegate extends SearchDelegate {
  List<String> searchresults = storesnames;
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
      icon: Icon(Icons.clear, color: Colors.black87),
      onPressed: () {
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = '';
        }
      },
    );
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          storesnames.clear();
          storesimages.clear();
          storescategories.clear();
          storesowners.clear();
          close(context, null);
        });
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> suggestions = searchresults.where((searchresults) {
      final result = searchresults.toLowerCase();
      final input = query.toLowerCase();
      return result.contains(input);
    }).toList();

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: suggestions.length,
      itemBuilder: ((context, index) {
        final suggestion = suggestions[index];

        return Column(
          children: [
            ListTile(
                leading: Image.network(storesimages[index]),
                title: Text(suggestion),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StorePage(
                                storeName: suggestion,
                                storeType: storetypes as String,
                                storeOwnerUid: storesowners[index],
                                storeCategories: storescategories[index],
                              )));
                }),
          ],
        );
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      List<String> suggestions = searchresults.where((searchresults) {
        final result = searchresults.toLowerCase();
        final input = query.toLowerCase();
        return result.contains(input);
      }).toList();
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: suggestions.length,
        itemBuilder: ((context, index) {
          final suggestion = suggestions[index];
          return ListTile(
              leading: Image.network(storesimages[index]),
              title: Text(suggestion),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StorePage(
                              storeName: suggestion,
                              storeType: storetypes as String,
                              storeOwnerUid: storesowners[index],
                              storeCategories: storescategories[index],
                            )));
              });
        }),
      );
    } else {
      return Center();
    }
  }
}
