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

class _ListOfStoresState extends State<ListOfStores> {
  List<String> listOfStoreOwnerIds_UserId;
  String storetype;
  _ListOfStoresState(
      {required this.listOfStoreOwnerIds_UserId, required this.storetype});

  // void getStores() async {
  //   //take the user id from the list
  //   //walk on every documment with the user id and get the store name and store logo
  //   //add the store name and store logo to the list of store cards

  //   for (int i = 0; i < listOfStoreOwnerIds_UserId.length; i++) {
  //     await FirebaseFirestore.instance
  //         .collection('StoreOwners')
  //         .doc(listOfStoreOwnerIds_UserId[i])
  //         .get()
  //         .then((value) {
  //       // print(value.data()!['storeName']);
  //       // print(value.data()!['storeLogo']);
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // getStores();
  }

  Widget StoreCard({
    required String storeName,
    required String imageURL,
    required String userId,
    required List<String> storecategories,
  }) {
    return GestureDetector(
      onTap: () {
        //send the user id to the store page
        //send the store type
        //send the store name
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
      // child: Stack(
      // alignment: Alignment.center,
      // children: [
      //   Container(
      //     height: 180,
      //     width: 130,
      //     child: ClipRRect(
      //       borderRadius: BorderRadius.circular(20),
      //       child: SizedBox.fromSize(
      //         size: Size.fromRadius(80),
      //         child: Image.network((imageURL), fit: BoxFit.cover),
      //       ),
      //     ),
      //   ),
      //   Positioned(
      //     bottom: 0,
      //     child: Container(
      //       color: Colors.black,
      //       child: Text(
      //         storeName,
      //         style: TextStyle(
      //           fontSize: 15,
      //           color: Colors.white,
      //         ),
      //       ),
      //     ),
      //   ),
      // ],
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
    //suppsoed to be a list of storecards
    return Scaffold(
      // backgroundColor: Colors.red,
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
              onPressed: () {},
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
