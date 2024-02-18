///import 'dart:html';

import 'package:batatis/Controller.dart';
import 'package:batatis/moudles/Orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '/RestaurantBranch_Widgets/All_RB_Widgets.dart';
import '/Views/RestaurantBranch_View.dart';
import 'package:batatis/Routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'All_RestaurantBranch_Screens.dart';
/////////////////////////////////////////////
import 'package:batatis/Costomer_Screens/lastNoti.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
/////////////////////////////////////////////////

FirebaseFirestore db = FirebaseFirestore.instance;
//Future<bool> isLoggedIn = isUserLoggedIn(); // Default to false if not found

//bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false; // Default to false if not found

//SharedPreferences prefs

// @override
// void initState() {
//   super.initState();
//   _initializeSharedPreferences();
// }

// Future<void> _initializeSharedPreferences() async {
//   prefs = await SharedPreferences.getInstance();
// }

class viewMenu extends StatefulWidget {
  const viewMenu({super.key});
  @override
  static String yoho = "";
  static String boho = "";
  State<viewMenu> createState() => viewMenuState();
}

String? uid = "";
String? RbuID = '';
String Rbid = "";
// String RestaurantId = ' ';
String msg = "";
bool isLoggedIn = true;
bool loading = true ; 

class viewMenuState extends State<viewMenu> {
  late final ap;
  void initState() {
    super.initState();
    loadData();
    // islog(); // Initialize isLoggedIn here
    //getget();
  }

  static String? RestaurantId;
  Map<String, Widget> listOfMenuItemsImages = {};
  List<DocumentSnapshot> listOfMenuItems = [];

  Future<void> loadData() async {
    try {
       islog();
      if (isLoggedIn) {
        RestaurantId = RSharedPref.RestId ; //await Controller.getUid();
        await fetchRestaurantsMenu();
        await loadMenuItemsImages();

        setState(() {
          loading = false ; 
          // GenrateResturansCards() ;
          // restaurantsMarkers = GenrateMarkers(listOfRestaurants);
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> fetchRestaurantsMenu() async {
    final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Restaurants')
        .doc(RestaurantId)
        .collection("menu")
        .get();
    listOfMenuItems = querySnapshot.docs.toList();
  }

  Future<void> loadMenuItemsImages() async {
    for (final doc in listOfMenuItems) {
      final String imagePath = "/Restaurants/$RestaurantId/${doc.id}";
      print("hereee $imagePath");
      await PhotoPicker.getimg(imagePath);
      final String imageUrl = await PhotoPicker.geturl();

      listOfMenuItemsImages[doc.id] = CachedNetworkImage(
        imageUrl: imageUrl,
        width: 87,
        height: 70,
      );
    }
  }

//  void reload() {
//     Navigator.pop(context, "/RBHomePageM"); // pop current page
//     Navigator.pushNamed(context, "/RBHomePageM"); // push it back in
//   }

//   Future<void> getget() async{
//     uid = await Controller.getUid();
//     viewMenu.boho = uid! ;
//     await Controller.getRBUid(uid);
//    RbuID = viewMenu.yoho ;
//      print("in getget" + uid! );
//       print("ingetogeto " + RbuID! );

//       Rbid =RbuID!;
//  print(RbuID);
//    Rid =uid! ;
//    print(uid!);

//   }

//   Future<void> getValue() async {

// await FirebaseFirestore.instance
//             .collection('Restaurants')
//             .doc(Rid)
//             .collection('Branches')
//             .doc(Rbid)
//             .collection('menu').snapshots();

// }claaaassss

  // Set<DocumentSnapshot> mySet = {};
  // //var mySet = <DocumentSnapshot>{};

  // List<String> urls = [] ;
  @override
  Widget build(BuildContext context) {
    List<Widget> cards() {
      List<Widget> cc = [];
      int i = -1;
      // mySet = mySet.toSet() ;
      listOfMenuItems.forEach((itemData) {
        i = i + 1;
        Widget img = listOfMenuItemsImages[itemData.id]!;
        cc.add(
          Container(
            width: 200,
            height: 230,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                img,
                CustomText(text: itemData.get('Name'), type: "Subheading1B"),
                Container(
                  child: CustomText(
                      text: itemData.get('description'), type: "paragraph"),
                  height: 30,
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                ),
                Tooltip(
                  child: CustomText(
                    text: 'more',
                    color: Batatis_Dark,
                  ),
                  decoration: BoxDecoration(color: Batatis_Dark),
                  richMessage: TextSpan(
                    text: itemData.get('description'),
                    // textStyle: TextStyle(color: Colors.white),
                  ),
                ),
                CustomText(
                    text: itemData.get('price') + ' SR', type: "paragraph"),
                CustomButton(
                  text: "Delete",
                  /*width:20,*/ onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Confirm Deletion'),
                        content: const Text(
                            'Are you sure you want to delete this item?'),
                        actions: <Widget>[
                          TextButton(
                            //cancel
                            onPressed: () => Navigator.pop(
                              context,
                            ),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            //delete tiem
                            onPressed: () => {
                              print("object"),
                              FirebaseFirestore
                                  .instance //("/$Rid/Branches/$Rbid/${doc.id}.png"
                                  .collection('Restaurants')
                                  // .doc(Rid)
                                  // .collection('Branches')
                                  .doc(RestaurantId)
                                  .collection('menu')
                                  .doc(itemData.id)
                                  .delete(),
                                  setState(() {
                                    loading = true ; 
                                    loadData();
                                  }),
                              Navigator.pop(
                                context,
                              ),
                              //  reload(),
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(color: red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  type: 'delete',
                  height: 0.03,
                  width: 0.07,
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: white,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  //offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
          ),
        );
        print("after cc");
      });
//     urls.clear();
// mySet.clear() ;
      return cc;
    }

    return !loading
        ? SingleChildScrollView(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Center(
                    child: Container(
                        width: 1100,
                        // height: 1000,
                        margin: const EdgeInsets.all(90),
                        child: Column(children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  // alignment: Alignment.centerLeft,
                                  margin: const EdgeInsets.only(
                                    bottom: 20,
                                  ),
                                  child: CustomText(
                                      text: 'MENU', type: "Subheading1WB"),
                                ),
                                // SizedBox(width: 500), // Add horizontal space between Dropdown and Button

                                Container(
                                  //alignment: Alignment.centerRight,
                                  //  alignment: Alignment(0.2, 0.6),

                                  margin: const EdgeInsets.only(
                                    bottom: 20,
                                  ),
                                  child: CustomButton(
                                    text: "Add Item",
                                    onPressed: ()  {
                                    
                                      moveRoute(context, "/RBHomePageAdd");
                                    },
                                    type: "add",
                                  ),
                                ),
                              ]),
                          //  Row(

                          CustomText(
                            text: msg,
                            color: Batatis_Dark,
                          ),
                          Wrap(
                            // orientation: Orientation.horizontal,
                            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: cards(),
                          )
                        ])))))
        : Center(child: CircularProgressIndicator());
  }

  //////////////////////////

//     return
//     Scaffold(
//       body:
//        FutureBuilder(
//   future: Future.wait([getget(),islog() ]),
//   builder: (BuildContext context, AsyncSnapshot<void> futureSnapshot) {
//     if (futureSnapshot.connectionState == ConnectionState.waiting) {
//       // If the Future is still running, return a loading indicator or some other widget.
//       return CircularProgressIndicator();
//     } else if (futureSnapshot.hasError) {
//       // If the Future encountered an error, display an error message.
//       return Text('Error: ${futureSnapshot.error}');
//     } else {
//       if(isLoggedIn!){
//       // If the Future completed successfully, you can start listening to a Stream.
//       return StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('Restaurants')
//             // .doc(Rid)
//             // .collection('Branches')
//             .doc(Rid)
//             .collection('menu').snapshots(),
//          builder: (BuildContext context, snapshot/*8AsyncSnapshot<YourStreamDataType> streamSnapshot*/)
//          {
//           print("236   Restaurants/$Rid/menu");
//          // print(snapsho);
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             // While data is loading, show a loading indicator.
//             print("wait");
//             return CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             print("eroorrrrr");
//             // If an error occurs, display an error message.
//             return Text('no data' /*'Error: ${snapshot.error}'*/);
//           }
//            else   if (snapshot.hasData!) { msg="";

//           QuerySnapshot querySnapshot =  snapshot.data! ;
//           if(querySnapshot != null)
//           querySnapshot.docs.forEach((DocumentSnapshot doc) async {

//             await PhotoPicker.getimg("/Restaurants/$Rid/${doc.id}");

//             String  url = await PhotoPicker.geturl() ;
//             print("phoot333 ");
//             mySet.add(doc);
//             if (url  == " "){
//             await PhotoPicker.getimg("/Restaurants/$Rid/${doc.id}");//"/Restaurants/$Rid/$Iid"
//            // await PhotoPicker.getimg("/$Rid/Branches/$Rbid/${doc.id}.png");
//             url = await PhotoPicker.geturl();}
//            else {
//                urls.add(url);

//            }
// });}else msg = 'no item exit';
//           return  SingleChildScrollView(
//               child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child:  Center(
//                       child: Container(
//                           width: 1100,
//                          // height: 1000,
//                           margin: const EdgeInsets.all(90),
//                           child: Column(children: [

//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children:[
//                               Container(
//                              // alignment: Alignment.centerLeft,
//                               margin:const  EdgeInsets.only(
//                                 bottom: 20,
//                               ),
//                               child:  CustomText(text: 'THE MENU',type: "Subheading1WB"),

//                             ),
//                              // SizedBox(width: 500), // Add horizontal space between Dropdown and Button

//                             Container(
//                              //alignment: Alignment.centerRight,
//                               //  alignment: Alignment(0.2, 0.6),

//                               margin:const  EdgeInsets.only(
//                                 bottom: 20,
//                               ),
//                               child:  CustomButton(
//                                 text: "Add Item",
//                                 onPressed: () {
//                                    moveRoute(context, "/RBHomePageAdd");
//                                 },
//                                 type: "add",
//                               ),
//                             ),
//                            ]),
//                             //  Row(

//                               CustomText(text: msg,color: Batatis_Dark,),
//                              Wrap(
//                               // orientation: Orientation.horizontal,
//                               //       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children:  cards(),
//                             )
//                           ])))));
//         },
//         // {
//         //   if (streamSnapshot.connectionState == ConnectionState.waiting) {
//         //     // If the Stream is still waiting for data, return a loading indicator.
//         //     return CircularProgressIndicator();
//         //   } else if (streamSnapshot.hasError) {
//         //     // If the Stream encountered an error, display an error message.
//         //     return Text('Stream Error: ${streamSnapshot.error}');
//         //   } else {
//         //     // If the Stream has data, display it in your widget.
//         //     return YourWidgetWithData(streamSnapshot.data);
//         //   }
//         // },
//       );
//         }else { Navigator.pushNamed(context, "/SignInPage");return Text(" "); }

//     }
//   },
// )

//             //.snapshots(),
//     //  builder: builder)

//       // StreamBuilder<QuerySnapshot>(
//       //   stream:

// //         builder:
// //         (context, snapshot)  {
// //          // print(snapsho);
// //           if (snapshot.connectionState == ConnectionState.waiting) {
// //             // While data is loading, show a loading indicator.
// //             print("wait");
// //             return CircularProgressIndicator();
// //           } else if (snapshot.hasError) {
// //             print("eroorrrrr");
// //             // If an error occurs, display an error message.
// //             return Text('no data' /*'Error: ${snapshot.error}'*/);
// //           }
// //                                       else   if (snapshot.hasData!) { msg="";

// // print("passs");
// //           QuerySnapshot querySnapshot =  snapshot.data! ;
// //           print("pasooooo222" + querySnapshot.docs.length.toString());
// //           if(querySnapshot != null)
// //           querySnapshot.docs.forEach((DocumentSnapshot doc) async {
// //            print("bbbphoot ");
// //             await PhotoPicker.getimg("/$Rbid/Branches/$Rid/${doc.id}.png");
// //            print("phoot ");
// //             String  url = await PhotoPicker.geturl() ;
// //             print("phoot333 ");
// //             mySet.add(doc);
// //             if (url  == " "){
// //             await PhotoPicker.getimg("/$Rid/Branches/$Rbid/${doc.id}.png");
// //             url = await PhotoPicker.geturl();}
// //            else {
// //                urls.add(url);

// //            }
// // });}else msg = 'no item exit';
// //           return  SingleChildScrollView(
// //               child: SingleChildScrollView(
// //                   scrollDirection: Axis.horizontal,
// //                   child:  Center(
// //                       child: Container(
// //                           width: 1100,
// //                          // height: 1000,
// //                           margin: const EdgeInsets.all(90),
// //                           child: Column(children: [

// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //                               children:[
// //                               Container(
// //                              // alignment: Alignment.centerLeft,
// //                               margin:const  EdgeInsets.only(
// //                                 bottom: 20,
// //                               ),
// //                               child:  CustomText(text: 'THE MENU',type: "Subheading1WB"),

// //                             ),
// //                              // SizedBox(width: 500), // Add horizontal space between Dropdown and Button

// //                             Container(
// //                              //alignment: Alignment.centerRight,
// //                               //  alignment: Alignment(0.2, 0.6),

// //                               margin:const  EdgeInsets.only(
// //                                 bottom: 20,
// //                               ),
// //                               child:  CustomButton(
// //                                 text: "Add Item",
// //                                 onPressed: () {
// //                                    moveRoute(context, "/addItem");
// //                                 },
// //                                 type: "add",
// //                               ),
// //                             ),
// //                            ]),
// //                             //  Row(
// //                               Text(msg),
// //                              Wrap(
// //                               // orientation: Orientation.horizontal,
// //                               //       mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                               children:  cards(),
// //                             )
// //                           ])))));
// //         },
//       );
  // }else { Navigator.pushNamed(context, "/SignInPage");return Text("nothing to show "); }

//return Text('not logged in');
// pop current page
}

void islog()  {
  isLoggedIn = RSharedPref.Islogin!;//await sharedPref.isUserLoggedIn();
}

//const viewMenu({super.key});
