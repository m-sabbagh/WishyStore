import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:wishy_store/Screens/UserScreens/UserStorePages/StorePage.dart';
import 'package:wishy_store/Screens/UserScreens/UserStorePages/ListOfStores.dart';

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
  Map<String, dynamic> storeData = {};

  List<String> userIdForGiftCenter = [];
  List<String> userIdForRetailStores = [];
  List<String> userIdForHealthAndBeautyStores = [];
  List<String> userIdForFitnessStores = [];
  List<String> userIdForClothingStores = [];
  List<String> userIdForJewelryStores = [];

  void passOnEveryDocumment() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('StoreOwners');
    collectionReference.get().then((value) {
      value.docs.forEach((element) {
        storeData = element.data() as Map<String, dynamic>;
        if (storeData['storeType'] == 'Gift store' &&
            storeData['storeOwnerGranted'] == true) {
          userIdForGiftCenter.add(storeData['uId']);
        }
        if (storeData['storeType'] == 'Retail store' &&
            storeData['storeOwnerGranted'] == true) {
          userIdForRetailStores.add(storeData['uId']);
        }
        if (storeData['storeType'] == 'Health and Beauty store' &&
            storeData['storeOwnerGranted'] == true) {
          userIdForHealthAndBeautyStores.add(storeData['uId']);
        }
        if (storeData['storeType'] == 'Fitness store' &&
            storeData['storeOwnerGranted'] == true) {
          userIdForFitnessStores.add(storeData['uId']);
        }
        if (storeData['storeType'] == 'Clothing store' &&
            storeData['storeOwnerGranted'] == true) {
          userIdForClothingStores.add(storeData['uId']);
        }
        if (storeData['storeType'] == 'Jewelry store' &&
            storeData['storeOwnerGranted'] == true) {
          userIdForJewelryStores.add(storeData['uId']);
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passOnEveryDocumment();
  }

  Widget storeslist(
      {required String storeType,
      required List<String> listOfUserIds,
      required String imageUrl,
      required String storeTitle}) {
    return Card(
      elevation: 4,
      shadowColor: Color.fromARGB(255, 174, 172, 172),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        trailing: Icon(
          EvaIcons.arrowIosForward,
          color: Colors.black,
        ),
        onTap: () async {
          //i want to navigatoe to the list of stores
          //and i want to send the list of user ids of the stores

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return ListOfStores(
                  listOfStoreOwnerIds_UserId: listOfUserIds,
                  storeType: storeType);
            }),
          );
        },
        // subtitle: Text(
        //   'Retail',
        //   style: TextStyle(color: Colors.white, fontSize: 20),
        // ),

        // subtitle: Image.asset(
        //   imageUrl,
        // ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            imageUrl,
          ),
        ),
        title: Text(
          storeTitle,
          style:
              TextStyle(color: Color.fromARGB(255, 16, 15, 15), fontSize: 20),
        ),
        // trailing: Icon(
        //   Icons.arrow_forward_ios,
        //   color: Colors.white,
        // ),
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
            Text('Cateogires',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            //           List<String> storeTypes = <String>[
            //   'Retail store',
            //   'Health and Beauty store',
            //   'Gift store',
            //   'Fitness store',
            //   'Clothing store',
            //   'Jewelry store',
            // ];

            children: [
              SizedBox(
                height: 10,
              ),
              storeslist(
                storeType: 'Retail store',
                listOfUserIds: userIdForRetailStores,
                imageUrl: 'images/storeCategories/retailstores.png',
                storeTitle: 'Retail stores',
              ),
              SizedBox(
                height: 10,
              ),
              storeslist(
                storeType: 'Health and Beauty store',
                listOfUserIds: userIdForHealthAndBeautyStores,
                imageUrl: 'images/storeCategories/healthandbeuaty.png',
                storeTitle: 'Health and Beauty stores',
              ),
              SizedBox(
                height: 10,
              ),
              storeslist(
                storeType: 'Gift store',
                listOfUserIds: userIdForGiftCenter,
                imageUrl: 'images/storeCategories/giftstores2.png',
                storeTitle: 'Gift stores',
              ),
              SizedBox(
                height: 10,
              ),
              storeslist(
                storeType: 'Fitness store',
                listOfUserIds: userIdForFitnessStores,
                imageUrl: 'images/storeCategories/fitness.png',
                storeTitle: 'Fitness stores',
              ),
              SizedBox(
                height: 10,
              ),
              storeslist(
                storeType: 'Clothing store',
                listOfUserIds: userIdForClothingStores,
                imageUrl: 'images/storeCategories/clothingstores.png',
                storeTitle: 'Clothing stores',
              ),
              SizedBox(
                height: 10,
              ),
              storeslist(
                storeType: 'Jewelry store',
                listOfUserIds: userIdForJewelryStores,
                imageUrl: 'images/storeCategories/jewlary2.png',
                storeTitle: 'Jewelry stores',
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
