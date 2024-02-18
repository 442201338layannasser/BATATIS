// import 'dart:async';

// import 'package:batatis/Controller.dart';
// // import 'package:batatis/Costomer_Screens/ViewMenuToCustomer.dart';
// // import 'package:batatis/Customer_Widgets/Customer_AppBar.dart';
// // import 'package:batatis/Customer_Widgets/Customer_buttons.dart';
// // import 'package:batatis/Customer_Widgets/Customer_texts.dart';
// // import 'package:batatis/Customer_Widgets/SharedPrefer.dart';

// //import 'package:batatis/Customer_Widgets/colors.dart';
// import 'package:batatis/RestaurantBranch_Screens/All_RestaurantBranch_Screens.dart';
// import 'package:batatis/RestaurantBranch_Widgets/All_RB_Widgets.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:intl/intl.dart';
// import 'sharedPref.dart';
// /////////////////sadeem////////////////////////////
// import 'package:batatis/Costomer_Screens/lastNoti.dart';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;

// class currentorder extends StatefulWidget {
//   const currentorder({super.key});

//   @override
//   State<currentorder> createState() => _currentorderState();
// }

// List<dynamic> itemsofmember2 = [];
// List<dynamic> itemsofmember = [];

// class _currentorderState extends State<currentorder>
//     with SingleTickerProviderStateMixin {
//   ////////////////////////////sadeem/////////////////////////////////////
//   NotificationServices notificationServices = NotificationServices();
// //////////////////////////////////////////////////////////////////////////
//   static String? resturantid;
//   var snapp;
//   var h = 0;
//   bool flag = false;

//   List<DocumentSnapshot> listOforders = [];

//   List<DocumentSnapshot> member = [];
//   static List<Widget> allorders = [];
//   static List<Widget> orderdetails = [];
//   List<dynamic> itemsofmember = [];
//   List<dynamic> quantityofmember = [];
//   List<dynamic> pricesofmember = [];
//   late TabController _tabController;
//   static var js;
//   List<dynamic> result = [];
//   List<dynamic> yay = [];
//   bool showA = true; // Initialize with false to indicate initially collapsed.

//   void initState() {
//     // SharedPrefer.SetSharedPrefer();
//     super.initState();
//     islog(); // Initialize isLoggedIn here
//     loadData();
//     _tabController = TabController(length: 3, vsync: this);
//     ///////////////sadeem////////////////
//     notificationServices.requestNotificationPermission();
//     notificationServices.forgroundMessage();
//     notificationServices.firebaseInit(context);
//     notificationServices.setupInteractMessage(context);
//     //notificationServices.isTokenRefresh();

//     //////////////////////////////////////////
//   }

//   Future<void> loadData() async {
//     try {
//       await islog();
//       if (isLoggedIn) {
//         resturantid = await Controller.getUid();

//         setState(() {});
//       }
//     } catch (e) {
//       print('Error: $e');
//     }
//   }

//   bool isLoggedIn = false;

//   Future<void> islog() async {
//     isLoggedIn = await sharedPref.isUserLoggedIn();
//   }

//   Future<List<dynamic>> outfordelivery(orderid) async {
//     print("outfordelivery button ");
//     DocumentReference ordersRef =
//         FirebaseFirestore.instance.collection("Orders").doc(orderid);

//     ordersRef.update({"status": "Out for Delivery"});

//     var query = await ordersRef.get();
//     print(" tokennnsss ${query.get("tokens")}");
//     print("accept button query ");

//     print(" tokennnsss ${query.get("tokens")}");
//     List<dynamic> tt = query.get("tokens");

//     return tt;
//   }

//   Future<String> creatorname(creatorid) async {
//     try {
//       final DocumentSnapshot snapshot = await FirebaseFirestore.instance
//           .collection("Customers")
//           .doc(creatorid)
//           .get();

//       if (snapshot.exists) {
//         // Cast the data to a Map
//         Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

//         // Access the "name" field from the Map
//         String name = data["name"].toString();
//         return name;
//       } else {
//         // Handle the case where the document doesn't exist.
//         return "Document does not exist";
//       }
//     } catch (error) {
//       // Handle errors here.
//       throw "Error getting document: $error";
//     }
//   }

//   var stringelement1;
//   var stringelement2;
//   ////////////////////////////////////////////prommmleeemmmmaaaaa
//   Future<void> getmealprice(mealname) async {
//     print("layyyyyyyyyyyyyyyyyyyyyyyyyyyyyaaaaaaaaaaannn getmealprice");
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     CollectionReference collection =
//         firestore.collection('Restaurants').doc(resturantid).collection("menu");

//     QuerySnapshot querySnapshot = await collection.get();
//     final allData = querySnapshot.docs
//         .map((doc) => doc.data() as Map<String, dynamic>)
//         .toList();
//     print("iam in befor for of getprice meal$yay");

//     for (var data in allData) {
//       if (data['Name'] == mealname.toString()) {
//         yay.add(data['price']); // Use add method to add elements
//       }
//     }

//     yay.forEach((element) {
//       stringelement1 = element.toString();
//       print("stringelement1" + "$stringelement2");
//       Column(
//         children: [Text("$stringelement2" + " SR")],
//       );
//     });
//   }
// ///////////////////////////////////////////////////////////////

//   @override
//   Widget build(BuildContext context) {
//     const SizedBox(
//       height: 50,
//     );
//     allorders = [];
//     print("bulid of ordersrest");

//     allorders.add(Container(
//       width: 1200,
//       padding: const EdgeInsets.all(8),
//       margin: const EdgeInsets.fromLTRB(15, 12, 12, 12),
//       decoration: BoxDecoration(
//         color: white,
//         borderRadius: const BorderRadius.only(
//             topLeft: Radius.circular(10),
//             topRight: Radius.circular(10),
//             bottomLeft: Radius.circular(10),
//             bottomRight: Radius.circular(10)),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 4,
//           ),
//         ], /////////////////////cards creation///////////////////////////////////
//       ),
//       child: Row(
//         children: [
//           // const SizedBox(
//           //   width: 10,
//           //   height: 33,
//           // ),
//           // CustomText(
//           //   text: "       Order ID",
//           //   type: "tab",
//           // ),
//           // const SizedBox(
//           //   height: 33,
//           // ),
//           // SizedBox(
//           //   width: 30,
//           // ),
//           // CustomText(text: "             Customer Name", type: "tab"),
//           // CustomText(
//           //   text: "                            Customer Location",
//           //   type: "tab",
//           // ),
//           // CustomText(text: "                          Order Time", type: "tab"),
//           // CustomText(
//           //     text: "                        Order Details", type: "tab"),
//           // CustomText(text: "                 Action", type: "tab"),
//           const SizedBox(
//             width: 10,
//             height: 33,
//           ),
//           CustomText(
//             text: "       Order ID",
//             type: "tab",
//           ),
//           const SizedBox(
//             height: 33,
//           ),
//           SizedBox(
//             width: 90,
//           ),
//           // CustomText(text: "             Customer Name", type: "tab"),
//           CustomText(
//             text: "                            Customer Location",
//             type: "tab",
//           ),
//           const SizedBox(
//             //     height: 33,
//             width: 30,
//           ),
//           CustomText(text: "                      Order Time", type: "tab"),
//           const SizedBox(
//             //     height: 33,
//             width: 50,
//           ),
//           CustomText(
//               text: "                           Order Details", type: "tab"),
//           CustomText(text: "                 Action", type: "tab"),
//         ],
//       ),
//     ));
//     List<Widget> orders() {
//       print("iam in order why this is happning");
//       int i = -1;
//       orderdetails.clear();
//       listOforders.forEach((element)
//           //async
//           {
//         print("iam inorders the for eachhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
//         i = i + 1;
//         var j = 0;

//         //   await getmealprice(itemsofmember[j].toString());
//         //  print("iammm hhhhhhhhhhhheeeeeeeeeeeerrrrr innn get mealprice $yay");

//         orderdetails.add(Row(children: [
//           CustomText(
//             text: "           xq" +
//                 // quantityofmember[j]
//                 // .toString()
//                 // +
//                 "      ", //element.get('quantity'),
//             type: "Subheading1B",
//           ),
//           const SizedBox(
//             width: 250,
//           ),
//           CustomText(
//               text: "items here"
//               //itemsofmember[j++] //element.get('items')
//               ,
//               type: "Subheading1B"),
//           const SizedBox(
//             width: 230,
//           ),
//           CustomText(
//               text:
//                   //getmealprice(itemsofmember[j++]).toString()
//                   // element.get("Total")
//                   //   yay[t++],
//                   "33",
//               type: "Subheading1B"),
//         ]));
//         print("iam done with the order datails");
//       });
//       return orderdetails;
//     }

//     List<Widget> membersorders(orderdetails) {
//       print("iam in order why this is happning");
//       int i = -1;
//       int id = i + 1;
//       List<Widget> res = [];
//       // orderdetails.clear();
//       // listOforders.forEach((element)
//       //async
//       //    {
//       print("iam inorders the for eachhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
//       //i = i + 1;
//       var j = 0;
//       var items = orderdetails[0];
//       print("items $items");
//       var prices = orderdetails[1];
//       print("prices $prices");
//       var quantity = orderdetails[2];
//       print("quantity $quantity");

//       //   await getmealprice(itemsofmember[j].toString());
//       //  print("iammm hhhhhhhhhhhheeeeeeeeeeeerrrrr innn get mealprice $yay");
//       prices.forEach((price) {
//         print("pricespricespricesprices");
//         res.add(Row(children: [
//           SizedBox(
//             width: 40,
//           ),
//           CustomText(
//             text: "       x${quantity[j]}"
//             // quantityofmember[j]
//             // .toString()
//             // +
//             , //element.get('quantity'),
//             type: "Subheading1B",
//           ),
//           const SizedBox(
//             width: 250,
//           ),
//           CustomText(
//               text: "${items[j]}"
//               //itemsofmember[j++] //element.get('items')
//               ,
//               type: "Subheading1B"),
//           const SizedBox(
//             width: 220,
//           ),
//           CustomText(
//               text:
//                   //getmealprice(itemsofmember[j++]).toString()
//                   // element.get("Total")
//                   //   yay[t++],
//                   "${prices[j]} SR",
//               type: "Subheading1B"),
//         ]));
//         print("iam done with the order datails");
//         j = j + 1;
//       });
//       return res;
//     }

//     String creator = "";
//     List<Widget> cards() {
//       print("we are in cards of order rb ");
//       int i = -1;
//       int id = i + 1;
//       // quantityofmember = [1, 1, 1, 2];
//       // itemsofmember = ["BigMc", "Mcflurry", "McChicken", "Mcflurry"];

//       listOforders.forEach((element) //async
//           //  async
//           {
//         //  creator = await creatorname(element.get("Creator"));
//         //List<String> memeberTokenss =

//         ("in list of orders foreach");
//         // js = element;
//         print(
//             "we are in cards of order  for each rb ${allorders.length}  list of orders${listOforders.length}");
//         i = i + 1;
//         var j = 0;
//         id = 1 + i;

//         print("quantitesz we got ${quantityofmember}");
//         print("itemsofmember we got ${itemsofmember}");
//         // print(
//         //     "elemnt creator name ${await creatorname(element.get('Creator').toString())}");
//         //   total(element.id);
//         // allorders.add(Container(
//         //   width: 1200,
//         //   padding: const EdgeInsets.all(8),
//         //   margin: const EdgeInsets.fromLTRB(15, 12, 12, 12),
//         //   decoration: BoxDecoration(
//         //     color: white,
//         //     borderRadius: const BorderRadius.only(
//         //         topLeft: Radius.circular(10),
//         //         topRight: Radius.circular(10),
//         //         bottomLeft: Radius.circular(10),
//         //         bottomRight: Radius.circular(10)),
//         //     boxShadow: [
//         //       BoxShadow(
//         //         color: Colors.grey.withOpacity(0.5),
//         //         spreadRadius: 2,
//         //         blurRadius: 4,
//         //       ),
//         //     ], /////////////////////cards creation///////////////////////////////////
//         //   ),
//         //   child: Row(
//         //     children: [
//         //       const SizedBox(
//         //         width: 10,
//         //         height: 33,
//         //       ),
//         //       CustomText(
//         //         text: "      Order ID",
//         //         type: "tab",
//         //       ),
//         //       const SizedBox(
//         //         height: 33,
//         //       ),
//         //       CustomText(
//         //           text: "                    Customer Name", type: "tab"),
//         //       CustomText(
//         //         text: "                                Customer Location",
//         //         type: "tab",
//         //       ),
//         //       CustomText(
//         //           text: "                                  Order Time",
//         //           type: "tab"),
//         //       CustomText(text: "               Order Details", type: "tab"),
//         //       CustomText(text: "               Action", type: "tab"),
//         //     ],
//         //   ),
//         // ));
//         //    allorders.addAll([]);

//         allorders.add(Container(
//             width: 1200,
//             height: 157,
//             padding: const EdgeInsets.all(8),
//             margin: const EdgeInsets.fromLTRB(20, 0, 8, 0),
//             decoration: BoxDecoration(
//                 border: Border(
//                     bottom: BorderSide(
//                         color: Batatis_Dark,
//                         width: 0.75,
//                         style: BorderStyle.solid),
//                     top: BorderSide(
//                         color: white, width: 5, style: BorderStyle.solid),
//                     right: BorderSide(
//                         color: white, width: 5, style: BorderStyle.solid),
//                     left: BorderSide(
//                         color: white, width: 5, style: BorderStyle.solid))),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     // const SizedBox(
//                     //   width: 50,
//                     //   height: 60,
//                     // ),
//                     CustomText(
//                       text: "          #$id",
//                       type: "Subheading1B",
//                     ),
//                     // CustomText(
//                     //     text: "                          creator"
//                     //     //     .toString() //element.get('items')
//                     //     ,
//                     //     type: "Subheading1B"),
//                     // const SizedBox(
//                     //   height: 33,
//                     // ),
//                     const SizedBox(
//                       height: 33,
//                       width: 40,
//                     ),
//                     Center(
//                       child: Container(
//                         transformAlignment: AlignmentDirectional.center,
//                         margin: const EdgeInsets.fromLTRB(100, 26, 20, 0),
//                         width: 300,
//                         height: 103,
//                         alignment: Alignment.center,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             CustomText(
//                               text:
//                                   "                        ${element.get("deleveryLocation")}",
//                               type: "Subheading1B",
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       //height: 33,
//                       width: 70,
//                     ),
//                     CustomText(
//                       text:
//                           "   ${element.get("OrderTime").toString().split(" ").last.split(".").first}",
//                       type: "Subheading1B",
//                     ),
//                     Container(
//                       child: Row(
//                         children: [
//                           const SizedBox(
//                             width: 150,
//                           ),
//                           Row(
//                             children: [
//                               CustomButton(
//                                   width: 0.1,
//                                   height: 0.06,
//                                   type: "orderdatails",
//                                   text: "Order Details",
//                                   onPressed: () async {
//                                     ////////////////////xxx
//                                     List<List<dynamic>> deatils =
//                                         await membersitems(element.id);
//                                     showDialog<String>(
//                                         context: context,
//                                         builder: (BuildContext context) =>
//                                             AlertDialog(
//                                               title: Center(
//                                                   child: Text("Order ID #$id")),
//                                               content: Container(
//                                                   transformAlignment:
//                                                       Alignment.center,
//                                                   width: 900,
//                                                   height: 218,
//                                                   child: Column(
//                                                     children: [
//                                                       Row(
//                                                         children: [
//                                                           Container(
//                                                             alignment: Alignment
//                                                                 .center,
//                                                             width: 800,
//                                                             padding:
//                                                                 const EdgeInsets
//                                                                     .all(8),
//                                                             margin:
//                                                                 const EdgeInsets
//                                                                     .fromLTRB(
//                                                                     50,
//                                                                     12,
//                                                                     12,
//                                                                     12),
//                                                             decoration:
//                                                                 BoxDecoration(
//                                                               color: white,
//                                                               borderRadius: const BorderRadius
//                                                                   .only(
//                                                                   topLeft:
//                                                                       Radius.circular(
//                                                                           10),
//                                                                   topRight: Radius
//                                                                       .circular(
//                                                                           10),
//                                                                   bottomLeft: Radius
//                                                                       .circular(
//                                                                           10),
//                                                                   bottomRight: Radius
//                                                                       .circular(
//                                                                           10)),
//                                                               boxShadow: [
//                                                                 BoxShadow(
//                                                                   color: Colors
//                                                                       .grey
//                                                                       .withOpacity(
//                                                                           0.5),
//                                                                   spreadRadius:
//                                                                       2,
//                                                                   blurRadius: 4,
//                                                                 ),
//                                                               ], /////////////////////cards creation
//                                                             ),
//                                                             child: Row(
//                                                               children: [
//                                                                 const SizedBox(
//                                                                   width: 40,
//                                                                   height: 33,
//                                                                 ),
//                                                                 CustomText(
//                                                                   text:
//                                                                       "Quantity",
//                                                                   type:
//                                                                       "Subheading1B",
//                                                                 ),
//                                                                 const SizedBox(
//                                                                   height: 33,
//                                                                   width: 230,
//                                                                 ),
//                                                                 CustomText(
//                                                                     text:
//                                                                         "Item Name",
//                                                                     type:
//                                                                         "Subheading1B"),
//                                                                 const SizedBox(
//                                                                   height: 33,
//                                                                   width: 230,
//                                                                 ),
//                                                                 CustomText(
//                                                                   text: "Price",
//                                                                   type:
//                                                                       "Subheading1B",
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                           )
//                                                         ],
//                                                       ),
//                                                       const SizedBox(
//                                                         height: 15,
//                                                       ),
//                                                       Container(
//                                                         alignment:
//                                                             Alignment.center,
//                                                         height: 130,
//                                                         width: 800,
//                                                         child:
//                                                             SingleChildScrollView(
//                                                           child: Scrollbar(
//                                                               child: Column(
//                                                                   children:
//                                                                       membersorders(
//                                                                           deatils))),
//                                                         ),
//                                                       ),
//                                                       // Row(
//                                                       //   children: [
//                                                       //     SizedBox(
//                                                       //       height: 50,
//                                                       //     ),
//                                                       //     CustomText(
//                                                       //       text:
//                                                       //           "                                                                           Total: ${element.get("Total")} SR",
//                                                       //       type: "total",
//                                                       //     )
//                                                       //   ],
//                                                       // )
//                                                     ],
//                                                   )),
//                                               actions: <Widget>[
//                                                 Row(
//                                                   children: [
//                                                     CustomText(
//                                                       text:
//                                                           "                                                                           Total: ${element.get("Total")} SR",
//                                                       type: "total",
//                                                     )
//                                                   ],
//                                                 ),
//                                                 TextButton(
//                                                   //cancel
//                                                   onPressed: () =>
//                                                       Navigator.pop(
//                                                     context,
//                                                   ),
//                                                   child: const Text('Ok'),
//                                                 ),
//                                               ],
//                                             ));
//                                   }),
//                               const SizedBox(
//                                 width: 20,
//                               ),
//                               CustomButton(
//                                 text: "Out for Delivery",
//                                 onPressed: () {
//                                   showDialog<String>(
//                                     context: context,
//                                     builder: (BuildContext context) =>
//                                         AlertDialog(
//                                       title: const Text('Confirmation'),
//                                       content: const Text(
//                                           'Are you sure you want to Export this Order?'),
//                                       actions: <Widget>[
//                                         TextButton(
//                                           //cancel
//                                           onPressed: () => Navigator.pop(
//                                             context,
//                                           ),
//                                           child: const Text('Cancel'),
//                                         ),
//                                         TextButton(
//                                           onPressed: () async {
//                                             print("acceptt");
//                                             List<dynamic> memeberTokenss =
//                                                 await outfordelivery(
//                                                     element.id);
//                                             print(
//                                                 "$memeberTokenss tokitokitoki");
// //////////////////////////////////////////////////////sadeem notification////////////////////////////////
//                                             //   Navigator.pop( context );

//                                             memeberTokenss
//                                                 .forEach((element) async {
//                                               element = element.toString();
//                                               if (!(element == "None")) {
//                                                 print("notinoti");
//                                                 var data = {
//                                                   'to': element,
//                                                   'notification': {
//                                                     'title':
//                                                         'order status update',
//                                                     'body':
//                                                         'your order is out for delivery !',
//                                                   },
//                                                   'android': {
//                                                     'notification': {
//                                                       'notification_count': 23,
//                                                     },
//                                                   },
//                                                   'data': {
//                                                     'type': 'msj',
//                                                     'id': 'sadeem'
//                                                   }
//                                                 };
//                                                 print("notinouiuiiti");
//                                                 await http.post(
//                                                     Uri.parse(
//                                                         'https://fcm.googleapis.com/fcm/send'),
//                                                     body: jsonEncode(data),
//                                                     headers: {
//                                                       'Content-Type':
//                                                           'application/json; charset=UTF-8',
//                                                       'Authorization':
//                                                           'key=AAAAUqI5GM4:APA91bH3bpkC5icX3sgdIjtGj-cbO6wgQBbvZW5nE-N-GBv5OqjCNYqhvvEL6bZYvs6dNtMJFmibFXe2mOF7FLz7P71ddZyuIIZFysr9-qqPp0q8hoZAnXC2t8j6ARltVRHTPnk3szMz'
//                                                     }).then((value) {
//                                                   if (kDebugMode) {
//                                                     print(
//                                                         value.body.toString());
//                                                   }
//                                                 }).onError((error, stackTrace) {
//                                                   if (kDebugMode) {
//                                                     print(error);
//                                                   }
//                                                 });
//                                               }
//                                               print("747378");
//                                             });
// //  //////////////////////////////////////////////////////////////////////////
//                                             setState(() {
//                                               cards();
//                                             });
//                                             Navigator.pop(
//                                               context,
//                                             );
//                                           },
//                                           child: const Text('Confirm'),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                                 type: 'acceptorder',
//                                 height: 0.06,
//                                 width: 0.12,
//                               ),
//                               const SizedBox(
//                                 width: 5,
//                                 height: 60,
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             )));
//       });

//       return allorders;
//     }

//     print("3abeeeeeeeeeeeeeeeeeeeeeeeeee6");
//     print("rest loginnn ${RSharedPref.Islogin}");
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Row(
//           children: [
//             // FutureBuilder(
//             //   future: Future.wait([islog()]),
//             //   builder:
//             //       (BuildContext context, AsyncSnapshot<void> futureSnapshot) {
//             //     if (futureSnapshot.connectionState == ConnectionState.waiting) {
//             //       // If the Future is still running, return a loading indicator or some other widget.
//             //       return Center(child: CircularProgressIndicator());
//             //     } else if (futureSnapshot.hasError) {
//             //       // If the Future encountered an error, display an error message.
//             //       return Text('Error: ${futureSnapshot.error}');
//             //     } else {
//             // if (isLoggedIn) {
//             //   print("logedin good");
//             // If the Future completed successfully, you can start listening to a Stream.
//             RSharedPref.Islogin!
//                 ? StreamBuilder(
//                     stream: FirebaseFirestore.instance
//                         .collection("Orders")
//                         .where("RestaurantID", isEqualTo: resturantid)
//                         .where("status", isEqualTo: "Preparing")
//                         .snapshots(),
//                     builder: (BuildContext context, snapshot) {
//                       print("snapshoooooorders    ");
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         // While data is loading, show a loading indicator.
//                         print("wait for me");
//                         return Center(child: CircularProgressIndicator());
//                       } else if (snapshot.hasError) {
//                         print("has error big one");
//                         // If an error occurs, display an error message.
//                         return const Text(
//                             'no data' /*'Error: ${snapshot.error}'*/);
//                       } else if (snapshot.data?.size != 0) {
//                         flag = true;
//                         print("yes has data");

//                         QuerySnapshot querySnapshot = snapshot.data!;
//                         print(
//                             "before gooo to the gooo ${querySnapshot.docs.length}");

//                         if (querySnapshot != null) {
//                           listOforders.clear();
//                           print("before gooo ${querySnapshot.docs.length}");
//                           ///////////sadeem///////////
//                           int counter = 0;

//                           ///////////////////////
//                           querySnapshot.docs
//                               .forEach((DocumentSnapshot doc) async {
//                             print("gooolistttttttttttttttttttttttttttttttttt");
//                             listOforders.add(doc);

//                             ///////////sadeem////////////
//                             counter = counter + 1;
//                             RBmainpageState.set(() {
//                               RBmainpageState.num = 89;
//                             });
//                             //    update(counter),
//                             ////////////////////////////
//                             // await membersitems(doc.id);
//                             // listOforders.forEach((element) {

//                             //   membersitems(element.id);
//                             //   print("membersitems executed");
//                             // });
//                           });
//                         }
//                       } else {
//                         flag = false;
//                         // return Column(
//                         //     mainAxisAlignment: MainAxisAlignment.center,
//                         //     crossAxisAlignment: CrossAxisAlignment.center,
//                         //     children: <Widget>[
//                         //       SvgPicture.asset('assets/Images/No_Orders.svg'),
//                         //       CustomText(
//                         //         text: "No incoming orders",
//                         //         color: Batatis_Dark,
//                         //       ),
//                         //     ]);
//                       }

//                       return flag
//                           ?
//                           // Text(
//                           //     "we in the right place layan u have a lot of workk to do ");
//                           Column(children: cards())
//                           : Center(
//                               child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.center,
//                                   children: <Widget>[
//                                     Container(
//                                         margin: EdgeInsets.fromLTRB(
//                                             560, 100, 400, 0),
//                                         child: SvgPicture.asset(
//                                             'assets/Images/No_Orders.svg')),
//                                     Container(
//                                       margin:
//                                           EdgeInsets.fromLTRB(550, 10, 400, 0),
//                                       child: CustomText(
//                                         text: "No current orders",
//                                         color: Batatis_Dark,
//                                       ),
//                                     ),
//                                   ]),
//                             );
//                     },
//                   )
//                 : Text("not logged in please log in")

//             //   },
//             // ),
//           ],
//         ),
//       ),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {},
//       //   child: Text(counter.toString()),
//       // ),
//     );
//   }

// //List<String>
//   Future<List<List<dynamic>>> membersitems(orderid) async {
//     var memberid;
//     var members;
//     var quirymember1;
//     List<String> Tokenss = []; //for tokens

//     QuerySnapshot<Map<String, dynamic>> quirymember = await FirebaseFirestore
//         .instance
//         .collection("Orders")
//         .doc(orderid)
//         .collection("Member")
//         .get();
//     members = quirymember.docs.toList();
//     String stringelement1;
//     String stringelement2;
//     String stringelement3;
//     members.forEach((element) async {
//       print(" members.forEach((element) 201");
//       memberid = element.id;

//       //////sadeem notification////////////////////////////////
//       // var tokenn = await FirebaseFirestore.instance
//       //     .collection("Customers")
//       //     .doc(memberid)
//       //     .get();
//       // String token = tokenn.get("Token");
//       // Tokenss.add(token);
//       ///////////////////////////////
//       ///
//       // print(" id : $memberid   thw whole thing ${element.get("items")}");
//       itemsofmember = element.get("items") + itemsofmember;
//       //itemsofmember.addAll(items);
//       print(" id : $memberid   thw whole thing ${itemsofmember}");
//       print(" members.forEach((element) 205");
//       quantityofmember = element.get("quantity") + quantityofmember;
//       print(" members.forEach((element) 207");
//       pricesofmember = element.get("prices");
//       print(" members.forEach((element) 209");
//       //itemsofmember.forEach((element) {
//       // getmealprice(element.toString());

//       //   stringelement1 = element.toString();
//       //   print("stringelement1" + "$stringelement1");
//       //   Column(
//       //     children: [Text("$stringelement1")],
//       //   );
//       // });
//       // pricesofmember.forEach((element) {
//       //   stringelement3 = element.toString();
//       //   print("stringelement3" + "$stringelement3");
//       //   Column(
//       //     children: [Text("$stringelement3")],
//       //   );
//       // });
//       // quantityofmember.forEach((element) {
//       //   stringelement2 = element.toString();
//       //   print("stringelement2" + "$stringelement2");
//       //   Column(
//       //     children: [Text("$stringelement2")],
//       //   );
//       // });
//     });
//     print("all the details $itemsofmember $pricesofmember  $quantityofmember");
//     // return Tokenss;
//     return [itemsofmember, pricesofmember, quantityofmember];
//   }
// }
import 'dart:async';

import 'package:batatis/Controller.dart';
//import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
// import 'package:batatis/Costomer_Screens/ViewMenuToCustomer.dart';
// import 'package:batatis/Customer_Widgets/Customer_AppBar.dart';
// import 'package:batatis/Customer_Widgets/Customer_buttons.dart';
// import 'package:batatis/Customer_Widgets/Customer_texts.dart';
// import 'package:batatis/Customer_Widgets/SharedPrefer.dart';

//import 'package:batatis/Customer_Widgets/colors.dart';
import 'package:batatis/RestaurantBranch_Screens/All_RestaurantBranch_Screens.dart';
import 'package:batatis/RestaurantBranch_Widgets/All_RB_Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../Customer_Widgets/Link.dart';
import '../RestaurantBranch_Screens/sharedPref.dart';
/////////////////sadeem////////////////////////////
import 'package:batatis/Costomer_Screens/lastNoti.dart';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class currentorder extends StatefulWidget {
  const currentorder({super.key});

  @override
  State<currentorder> createState() => _currentorderState();
}

List<dynamic> itemsofmember2 = [];
List<dynamic> itemsofmember = [];

class _currentorderState extends State<currentorder>
    with SingleTickerProviderStateMixin {
  ////////////////////////////sadeem/////////////////////////////////////
  NotificationServices notificationServices = NotificationServices();
//////////////////////////////////////////////////////////////////////////
  static String? resturantid;
  var snapp;
  var h = 0;
  bool flag = false;

  List<DocumentSnapshot> listOforders = [];

  List<DocumentSnapshot> member = [];
  static List<Widget> allorders = [];
  static List<Widget> orderdetails = [];
  List<dynamic> itemsofmember = [];
  List<dynamic> quantityofmember = [];
  List<dynamic> pricesofmember = [];
  late TabController _tabController;
  static var js;
  List<dynamic> result = [];
  List<dynamic> yay = [];
  bool showA = true; // Initialize with false to indicate initially collapsed.

  void initState() {
    // SharedPrefer.SetSharedPrefer();
    super.initState();
    islog(); // Initialize isLoggedIn here
    loadData();
    _tabController = TabController(length: 3, vsync: this);
    ///////////////sadeem////////////////
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    //notificationServices.isTokenRefresh();

    //////////////////////////////////////////
  }

  Future<void> loadData() async {
    try {
      await islog();
      if (isLoggedIn) {
        resturantid = await Controller.getUid();

        setState(() {});
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  bool isLoggedIn = false;

  Future<void> islog() async {
    isLoggedIn = await sharedPref.isUserLoggedIn();
  }

  Future<List<dynamic>> outfordelivery(orderid) async {
    print("outfordelivery button ");
    DocumentReference ordersRef =
        FirebaseFirestore.instance.collection("Orders").doc(orderid);

    ordersRef.update({"status": "Out for Delivery"});

    var query = await ordersRef.get();
    print(" tokennnsss ${query.get("tokens")}");
    print("accept button query ");

    print(" tokennnsss ${query.get("tokens")}");
    List<dynamic> tt = query.get("tokens");

    Link.sendToDriver(query.get("delivery link"));
    return tt;
  }

  Future<String> creatorname(creatorid) async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("Customers")
          .doc(creatorid)
          .get();

      if (snapshot.exists) {
        // Cast the data to a Map
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

        // Access the "name" field from the Map
        String name = data["name"].toString();
        return name;
      } else {
        // Handle the case where the document doesn't exist.
        return "Document does not exist";
      }
    } catch (error) {
      // Handle errors here.
      throw "Error getting document: $error";
    }
  }

  var stringelement1;
  var stringelement2;
  ////////////////////////////////////////////prommmleeemmmmaaaaa
  Future<void> getmealprice(mealname) async {
    print("layyyyyyyyyyyyyyyyyyyyyyyyyyyyyaaaaaaaaaaannn getmealprice");
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection =
        firestore.collection('Restaurants').doc(resturantid).collection("menu");

    QuerySnapshot querySnapshot = await collection.get();
    final allData = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
    print("iam in befor for of getprice meal$yay");

    for (var data in allData) {
      if (data['Name'] == mealname.toString()) {
        yay.add(data['price']); // Use add method to add elements
      }
    }

    yay.forEach((element) {
      stringelement1 = element.toString();
      print("stringelement1" + "$stringelement2");
      Column(
        children: [Text("$stringelement2" + " SR")],
      );
    });
  }
///////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    const SizedBox(
      height: 50,
    );
    allorders = [];
    print("bulid of ordersrest");

    allorders.add(Container(
      width: 1200,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.fromLTRB(15, 12, 12, 12),
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
          ),
        ], /////////////////////cards creation///////////////////////////////////
      ),
      child: Row(
        children: [
          // const SizedBox(
          //   width: 10,
          //   height: 33,
          // ),
          // CustomText(
          //   text: "       Order ID",
          //   type: "tab",
          // ),
          // const SizedBox(
          //   height: 33,
          // ),
          // SizedBox(
          //   width: 30,
          // ),
          // CustomText(text: "             Customer Name", type: "tab"),
          // CustomText(
          //   text: "                            Customer Location",
          //   type: "tab",
          // ),
          // CustomText(text: "                          Order Time", type: "tab"),
          // CustomText(
          //     text: "                        Order Details", type: "tab"),
          // CustomText(text: "                 Action", type: "tab"),
          const SizedBox(
            width: 10,
            height: 33,
          ),
          CustomText(
            text: "       Order ID",
            type: "tab",
          ),
          const SizedBox(
            height: 33,
          ),
          SizedBox(
            width: 90,
          ),
          // CustomText(text: "             Customer Name", type: "tab"),
          CustomText(
            text: "                            Customer Location",
            type: "tab",
          ),
          const SizedBox(
            //     height: 33,
            width: 30,
          ),
          CustomText(text: "                      Order Time", type: "tab"),
          const SizedBox(
            //     height: 33,
            width: 50,
          ),
          CustomText(
              text: "                           Order Details", type: "tab"),
          CustomText(text: "                 Action", type: "tab"),
        ],
      ),
    ));
    List<Widget> orders() {
      print("iam in order why this is happning");
      int i = -1;
      orderdetails.clear();
      listOforders.forEach((element)
          //async
          {
        print("iam inorders the for eachhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
        i = i + 1;
        var j = 0;

        //   await getmealprice(itemsofmember[j].toString());
        //  print("iammm hhhhhhhhhhhheeeeeeeeeeeerrrrr innn get mealprice $yay");

        orderdetails.add(Row(children: [
          CustomText(
            text: "           xq" +
                // quantityofmember[j]
                // .toString()
                // +
                "      ", //element.get('quantity'),
            type: "Subheading1B",
          ),
          const SizedBox(
            width: 250,
          ),
          CustomText(
              text: "items here"
              //itemsofmember[j++] //element.get('items')
              ,
              type: "Subheading1B"),
          const SizedBox(
            width: 230,
          ),
          CustomText(
              text:
                  //getmealprice(itemsofmember[j++]).toString()
                  // element.get("Total")
                  //   yay[t++],
                  "33",
              type: "Subheading1B"),
        ]));
        print("iam done with the order datails");
      });
      return orderdetails;
    }

    List<Widget> membersorders(orderdetails) {
      print("iam in order why this is happning");
      int i = -1;
      int id = i + 1;
      List<Widget> res = [];
      // orderdetails.clear();
      // listOforders.forEach((element)
      //async
      //    {
      print("iam inorders the for eachhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
      //i = i + 1;
      var j = 0;
      var items = orderdetails[0];
      print("items $items");
      var prices = orderdetails[1];
      print("prices $prices");
      var quantity = orderdetails[2];
      print("quantity $quantity");

      //   await getmealprice(itemsofmember[j].toString());
      //  print("iammm hhhhhhhhhhhheeeeeeeeeeeerrrrr innn get mealprice $yay");
      prices.forEach((price) {
        print("pricespricespricesprices");
        res.add(Row(children: [
          SizedBox(
            width: 40,
          ),
          CustomText(
            text: "       x${quantity[j]}"
            // quantityofmember[j]
            // .toString()
            // +
            , //element.get('quantity'),
            type: "Subheading1B",
          ),
          const SizedBox(
            width: 250,
          ),
          CustomText(
              text: "${items[j]}"
              //itemsofmember[j++] //element.get('items')
              ,
              type: "Subheading1B"),
          const SizedBox(
            width: 220,
          ),
          CustomText(
              text:
                  //getmealprice(itemsofmember[j++]).toString()
                  // element.get("Total")
                  //   yay[t++],
                  "${prices[j]} SR",
              type: "Subheading1B"),
        ]));
        print("iam done with the order datails");
        j = j + 1;
      });
      return res;
    }

    String creator = "";
    List<Widget> cards() {
      print("we are in cards of order rb ");
      int i = -1;
      int id = i + 1;
      // quantityofmember = [1, 1, 1, 2];
      // itemsofmember = ["BigMc", "Mcflurry", "McChicken", "Mcflurry"];

      listOforders.forEach((element) //async
          //  async
          {
        //  creator = await creatorname(element.get("Creator"));
        //List<String> memeberTokenss =

        ("in list of orders foreach");
        // js = element;
        print(
            "we are in cards of order  for each rb ${allorders.length}  list of orders${listOforders.length}");
        i = i + 1;
        var j = 0;
        int id = 1 + i;

        print("quantitesz we got ${quantityofmember}");
        print("itemsofmember we got ${itemsofmember}");
        // print(
        //     "elemnt creator name ${await creatorname(element.get('Creator').toString())}");
        //   total(element.id);
        // allorders.add(Container(
        //   width: 1200,
        //   padding: const EdgeInsets.all(8),
        //   margin: const EdgeInsets.fromLTRB(15, 12, 12, 12),
        //   decoration: BoxDecoration(
        //     color: white,
        //     borderRadius: const BorderRadius.only(
        //         topLeft: Radius.circular(10),
        //         topRight: Radius.circular(10),
        //         bottomLeft: Radius.circular(10),
        //         bottomRight: Radius.circular(10)),
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.grey.withOpacity(0.5),
        //         spreadRadius: 2,
        //         blurRadius: 4,
        //       ),
        //     ], /////////////////////cards creation///////////////////////////////////
        //   ),
        //   child: Row(
        //     children: [
        //       const SizedBox(
        //         width: 10,
        //         height: 33,
        //       ),
        //       CustomText(
        //         text: "      Order ID",
        //         type: "tab",
        //       ),
        //       const SizedBox(
        //         height: 33,
        //       ),
        //       CustomText(
        //           text: "                    Customer Name", type: "tab"),
        //       CustomText(
        //         text: "                                Customer Location",
        //         type: "tab",
        //       ),
        //       CustomText(
        //           text: "                                  Order Time",
        //           type: "tab"),
        //       CustomText(text: "               Order Details", type: "tab"),
        //       CustomText(text: "               Action", type: "tab"),
        //     ],
        //   ),
        // ));
        //    allorders.addAll([]);

        allorders.add(Container(
            width: 1200,
            height: 157,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.fromLTRB(20, 0, 8, 0),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Batatis_Dark,
                        width: 0.75,
                        style: BorderStyle.solid),
                    top: BorderSide(
                        color: white, width: 5, style: BorderStyle.solid),
                    right: BorderSide(
                        color: white, width: 5, style: BorderStyle.solid),
                    left: BorderSide(
                        color: white, width: 5, style: BorderStyle.solid))),
            child: Column(
              children: [
                Row(
                  children: [
                    // const SizedBox(
                    //   width: 50,
                    //   height: 60,
                    // ),
                    CustomText(
                      text: "          #$id",
                      type: "Subheading1B",
                    ),
                    // CustomText(
                    //     text: "                          creator"
                    //     //     .toString() //element.get('items')
                    //     ,
                    //     type: "Subheading1B"),
                    // const SizedBox(
                    //   height: 33,
                    // ),
                    const SizedBox(
                      height: 33,
                      width: 40,
                    ),
                    Center(
                      child: Container(
                        transformAlignment: AlignmentDirectional.center,
                        margin: const EdgeInsets.fromLTRB(100, 26, 20, 0),
                        width: 300,
                        height: 103,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text:
                                  "                        ${element.get("deleveryLocation")}",
                              type: "Subheading1B",
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      //height: 33,
                      width: 70,
                    ),
                    CustomText(
                      text:
                          "   ${element.get("OrderTime").toString().split(" ").last.split(".").first}",
                      type: "Subheading1B",
                    ),
                    Container(
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 150,
                          ),
                          Row(
                            children: [
                              CustomButton(
                                  width: 0.1,
                                  height: 0.06,
                                  type: "orderdatails",
                                  text: "Order Details",
                                  onPressed: () async {
                                    ////////////////////xxx
                                    List<List<dynamic>> deatils =
                                        await membersitems(element.id);
                                    showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertDialog(
                                              title: Center(
                                                  child: Text("Order ID #$id")),
                                              content: Container(
                                                  transformAlignment:
                                                      Alignment.center,
                                                  width: 900,
                                                  height: 218,
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: 800,
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8),
                                                            margin:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    50,
                                                                    12,
                                                                    12,
                                                                    12),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: white,
                                                              borderRadius: const BorderRadius
                                                                  .only(
                                                                  topLeft:
                                                                      Radius.circular(
                                                                          10),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  spreadRadius:
                                                                      2,
                                                                  blurRadius: 4,
                                                                ),
                                                              ], /////////////////////cards creation
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                const SizedBox(
                                                                  width: 40,
                                                                  height: 33,
                                                                ),
                                                                CustomText(
                                                                  text:
                                                                      "Quantity",
                                                                  type:
                                                                      "Subheading1B",
                                                                ),
                                                                const SizedBox(
                                                                  height: 33,
                                                                  width: 230,
                                                                ),
                                                                CustomText(
                                                                    text:
                                                                        "Item Name",
                                                                    type:
                                                                        "Subheading1B"),
                                                                const SizedBox(
                                                                  height: 33,
                                                                  width: 230,
                                                                ),
                                                                CustomText(
                                                                  text: "Price",
                                                                  type:
                                                                      "Subheading1B",
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 130,
                                                        width: 800,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Scrollbar(
                                                              child: Column(
                                                                  children:
                                                                      membersorders(
                                                                          deatils))),
                                                        ),
                                                      ),
                                                      // Row(
                                                      //   children: [
                                                      //     SizedBox(
                                                      //       height: 50,
                                                      //     ),
                                                      //     CustomText(
                                                      //       text:
                                                      //           "                                                                           Total: ${element.get("Total")} SR",
                                                      //       type: "total",
                                                      //     )
                                                      //   ],
                                                      // )
                                                    ],
                                                  )),
                                              actions: <Widget>[
                                                Row(
                                                  children: [
                                                    CustomText(
                                                      text:
                                                          "                                                                           Total: ${element.get("Total")} SR",
                                                      type: "total",
                                                    )
                                                  ],
                                                ),
                                                ElevatedButton(
                                                  //cancel
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                    context,
                                                  ),
                                                   style: ElevatedButton.styleFrom(
                                    primary:
                                        Batatis_Dark, // Change the button's background color here
                                  ),
                                                  child: const Text('Ok',
                                    style: TextStyle(
                                      color: Colors
                                          .white, // Set the text color to white
                                    ),), 
                                                ),
                                              ],
                                            ));
                                  }),
                              const SizedBox(
                                width: 20,
                              ),
                              CustomButton(
                                text: "Out for Delivery",
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Confirmation'),
                                      content: const Text(
                                          'Are you sure you want to export this order?'),
                                      actions: <Widget>[
                                        TextButton(
                                          //cancel
                                          onPressed: () => Navigator.pop(
                                            context,
                                          ),
                                          child: const Text('Cancel'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () async {
                                            print("acceptt");
                                            List<dynamic> memeberTokenss =
                                                await outfordelivery(
                                                    element.id);
                                            print(
                                                "$memeberTokenss tokitokitoki");
//////////////////////////////////////////////////////sadeem notification////////////////////////////////
                                            //   Navigator.pop( context );

                                            memeberTokenss
                                                .forEach((element) async {
                                              element = element.toString();
                                              if (!(element == "None")) {
                                                print("notinoti");
                                                var data = {
                                                  'to': element,
                                                  'notification': {
                                                    'title':
                                                        'order status update',
                                                    'body':
                                                        'your order is out for delivery !',
                                                  },
                                                  'android': {
                                                    'notification': {
                                                      'notification_count': 23,
                                                    },
                                                  },
                                                  'data': {
                                                    'type': 'msj',
                                                    'id': 'sadeem'
                                                  }
                                                };
                                                print("notinouiuiiti");
                                                await http.post(
                                                    Uri.parse(
                                                        'https://fcm.googleapis.com/fcm/send'),
                                                    body: jsonEncode(data),
                                                    headers: {
                                                      'Content-Type':
                                                          'application/json; charset=UTF-8',
                                                      'Authorization':
                                                          'key=AAAAUqI5GM4:APA91bH3bpkC5icX3sgdIjtGj-cbO6wgQBbvZW5nE-N-GBv5OqjCNYqhvvEL6bZYvs6dNtMJFmibFXe2mOF7FLz7P71ddZyuIIZFysr9-qqPp0q8hoZAnXC2t8j6ARltVRHTPnk3szMz'
                                                    }).then((value) {
                                                  if (kDebugMode) {
                                                    print(
                                                        value.body.toString());
                                                  }
                                                }).onError((error, stackTrace) {
                                                  if (kDebugMode) {
                                                    print(error);
                                                  }
                                                });
                                              }
                                              print("747378");
                                            });
//  //////////////////////////////////////////////////////////////////////////
                                            setState(() {
                                              cards();
                                            });
                                            Navigator.pop(
                                              context,
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                    primary:
                                        Batatis_Dark, // Change the button's background color here
                                  ),
                                                  child: const Text('Confirm',
                                    style: TextStyle(
                                      color: Colors
                                          .white, // Set the text color to white
                                    ),), 
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                type: 'acceptorder',
                                height: 0.06,
                                width: 0.12,
                              ),
                              const SizedBox(
                                width: 5,
                                height: 60,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )));
      });

      return allorders;
    }

    print("3abeeeeeeeeeeeeeeeeeeeeeeeeee6");
    print("rest loginnn ${RSharedPref.Islogin}");
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          children: [
            // FutureBuilder(
            //   future: Future.wait([islog()]),
            //   builder:
            //       (BuildContext context, AsyncSnapshot<void> futureSnapshot) {
            //     if (futureSnapshot.connectionState == ConnectionState.waiting) {
            //       // If the Future is still running, return a loading indicator or some other widget.
            //       return Center(child: CircularProgressIndicator());
            //     } else if (futureSnapshot.hasError) {
            //       // If the Future encountered an error, display an error message.
            //       return Text('Error: ${futureSnapshot.error}');
            //     } else {
            // if (isLoggedIn) {
            //   print("logedin good");
            // If the Future completed successfully, you can start listening to a Stream.
            RSharedPref.Islogin!
                ? StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("Orders")
                        .where("RestaurantID", isEqualTo: resturantid)
                        .where("status", isEqualTo: "Preparing")
                        .snapshots(),
                    builder: (BuildContext context, snapshot) {
                      print("snapshoooooorders    ");
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // While data is loading, show a loading indicator.
                        print("wait for me");
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        print("has error big one");
                        // If an error occurs, display an error message.
                        return const Text(
                            'no data' /*'Error: ${snapshot.error}'*/);
                      } else if (snapshot.data?.size != 0) {
                        flag = true;
                        print("yes has data");

                        QuerySnapshot querySnapshot = snapshot.data!;
                        print(
                            "before gooo to the gooo ${querySnapshot.docs.length}");

                        if (querySnapshot != null) {
                          listOforders.clear();
                          print("before gooo ${querySnapshot.docs.length}");
                          ///////////sadeem///////////
                          int counter = 0;

                          ///////////////////////
                          querySnapshot.docs
                              .forEach((DocumentSnapshot doc) async {
                            print("gooolistttttttttttttttttttttttttttttttttt");
                            listOforders.add(doc);

                            ///////////sadeem////////////
                            counter = counter + 1;
                            RBmainpageState.set(() {
                              RBmainpageState.num = RSharedPref.numOfOrders!;
                            });
                            //    update(counter),
                            ////////////////////////////
                            // await membersitems(doc.id);
                            // listOforders.forEach((element) {

                            //   membersitems(element.id);
                            //   print("membersitems executed");
                            // });
                          });
                        }
                      } else {
                        flag = false;
                        // return Column(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     crossAxisAlignment: CrossAxisAlignment.center,
                        //     children: <Widget>[
                        //       SvgPicture.asset('assets/Images/No_Orders.svg'),
                        //       CustomText(
                        //         text: "No incoming orders",
                        //         color: Batatis_Dark,
                        //       ),
                        //     ]);
                      }

                      return flag
                          ?
                          // Text(
                          //     "we in the right place layan u have a lot of workk to do ");
                          Column(children: cards())
                          : Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.fromLTRB(
                                            560, 100, 400, 0),
                                        child: SvgPicture.asset(
                                            'assets/Images/No_Orders.svg')),
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(550, 10, 400, 0),
                                      child: CustomText(
                                        text: "No current orders",
                                        color: Batatis_Dark,
                                      ),
                                    ),
                                  ]),
                            );
                    },
                  )
                : Text("not logged in please log in")

            //   },
            // ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Text(counter.toString()),
      // ),
    );
  }

//List<String>
  Future<List<List<dynamic>>> membersitems(orderid) async {
    var memberid;
    var members;
    var quirymember1;
    List<String> Tokenss = []; //for tokens

    QuerySnapshot<Map<String, dynamic>> quirymember = await FirebaseFirestore
        .instance
        .collection("Orders")
        .doc(orderid)
        .collection("Member")
        .get();
    members = quirymember.docs.toList();
    String stringelement1;
    String stringelement2;
    String stringelement3;
    members.forEach((element) async {
      print(" members.forEach((element) 201");
      memberid = element.id;

      //////sadeem notification////////////////////////////////
      // var tokenn = await FirebaseFirestore.instance
      //     .collection("Customers")
      //     .doc(memberid)
      //     .get();
      // String token = tokenn.get("Token");
      // Tokenss.add(token);
      ///////////////////////////////
      ///
      // print(" id : $memberid   thw whole thing ${element.get("items")}");
      itemsofmember = element.get("items") + itemsofmember;
      //itemsofmember.addAll(items);
      print(" id : $memberid   thw whole thing ${itemsofmember}");
      print(" members.forEach((element) 205");
      quantityofmember = element.get("quantity") + quantityofmember;
      print(" members.forEach((element) 207");
      pricesofmember = element.get("prices");
      print(" members.forEach((element) 209");
      //itemsofmember.forEach((element) {
      // getmealprice(element.toString());

      //   stringelement1 = element.toString();
      //   print("stringelement1" + "$stringelement1");
      //   Column(
      //     children: [Text("$stringelement1")],
      //   );
      // });
      // pricesofmember.forEach((element) {
      //   stringelement3 = element.toString();
      //   print("stringelement3" + "$stringelement3");
      //   Column(
      //     children: [Text("$stringelement3")],
      //   );
      // });
      // quantityofmember.forEach((element) {
      //   stringelement2 = element.toString();
      //   print("stringelement2" + "$stringelement2");
      //   Column(
      //     children: [Text("$stringelement2")],
      //   );
      // });
    });
    print("all the details $itemsofmember $pricesofmember  $quantityofmember");
    // return Tokenss;
    return [itemsofmember, pricesofmember, quantityofmember];
  }
}
