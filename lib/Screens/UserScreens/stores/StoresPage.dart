import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:wishy_store/Screens/UserScreens/stores/store1.dart';

class UserStorePage extends StatefulWidget {
  const UserStorePage({Key? key}) : super(key: key);
  static String id = 'user_store_page';

  @override
  State<UserStorePage> createState() => _UserStorePageState();
}

class _UserStorePageState extends State<UserStorePage> {
  Widget RRRR() {
    return GestureDetector(
      onTap: () {
        setState(() {
          Navigator.pushNamed(context, StoreOne.id);
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Retail',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    'view all',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RRRR(),
                    SizedBox(
                      width: 20,
                    ),
                    RRRR(),
                    SizedBox(
                      width: 20,
                    ),
                    RRRR(),
                    SizedBox(
                      width: 20,
                    ),
                    RRRR(),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Retail',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    'view all',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    RRRR(),
                    SizedBox(
                      width: 20,
                    ),
                    RRRR(),
                    SizedBox(
                      width: 20,
                    ),
                    RRRR(),
                    SizedBox(
                      width: 20,
                    ),
                    RRRR(),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Retail',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  Text(
                    'view all',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RRRR(),
                    SizedBox(
                      width: 20,
                    ),
                    RRRR(),
                    SizedBox(
                      width: 20,
                    ),
                    RRRR(),
                    SizedBox(
                      width: 20,
                    ),
                    RRRR(),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
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