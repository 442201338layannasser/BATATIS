import 'package:batatis/RestaurantBranch_Screens/ASHOrders.dart';
import 'package:batatis/Archive/Orders.dart';
import 'package:batatis/RestaurantBranch_Screens/currentorders.dart';
import 'package:batatis/RestaurantBranch_Screens/pastorders.dart';
import 'package:batatis/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
//ximport 'RBNewOrders.dart';
import 'sharedPref.dart';
import '/Customer_Widgets/All_customer_Widgets.dart';
import 'package:badges/badges.dart' as badges;

class RBmainpage extends StatefulWidget {
  const RBmainpage({super.key});

  @override
  State<RBmainpage> createState() => RBmainpageState();
}

class RBmainpageState extends State<RBmainpage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController =
      _tabController = TabController(length: 3, vsync: this);

  var _fireStoreInstance = FirebaseFirestore.instance;
  static int num = 0;
  late bool _showBadge;
  static late StateSetter set;

  // void _update(int _newOAmount) {
  //   setState(() => _newOAmount = _newOAmount);
  // }

  // void updateAmount(int newValue) {
  //   _newOAmount = newValue;
  // }

  @override
  Widget build(BuildContext context) {
    set = setState;
    _showBadge = false; //num > 0;
    print("RSharedPref.RestId gggg${RSharedPref.RestId}");
    //   _fireStoreInstance.collection('Restaurants').doc(RSharedPref.RestId).snapshots().listen((DocumentSnapshot snapshot) {
    //     if (snapshot.exists) {
    // // Get the current value of the field
    //   setState(() {
    //    _showBadge =  snapshot["noti"];
    //   });

    // Handle the change or perform actions based on the new value
    //   print('Field _showBadge changed to: $_showBadge');
    // }});
    
    return Scaffold(
      body: Center(
          child: Column(children: [
        TabBar(
          labelStyle: const TextStyle(fontSize: 19, fontFamily: "Poppins"),
          controller: _tabController,
          labelColor: Batatis_Dark,
          unselectedLabelColor: grey_Dark,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: const EdgeInsets.all(5.0),
          tabs: [
            Tab(
              text: "New orders",
              icon:
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
               stream: _fireStoreInstance.collection("Restaurants").doc(RSharedPref.RestId).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Loading indicator while waiting for data
                }

                if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Text('Document does not exist'); // Handle the case where the document doesn't exist
                }

                bool _showBadge =
                    snapshot.data!.get('noti') ?? false;

          return 
          // Center(
          //   child: IconButton(
          //     icon: shouldShowUpdatedIcon
          //         ? Icon(Icons.thumb_up) // Updated icon
          //         : Icon(Icons.thumb_down), // Default icon
          //     onPressed: () {
          //       // You can perform additional actions when the button is pressed
          //     },
          //   ),
          // );
               badges.Badge(
                showBadge: _showBadge,
                badgeStyle: badges.BadgeStyle(
                  badgeColor: Color.fromARGB(255, 243, 33, 33),
                ),
                position: badges.BadgePosition.topEnd(top: -12, end: -20),
                badgeContent: Text(
                  "",
                  style: TextStyle(color: Colors.white),
                ),
                child: Icon(Icons.upcoming),
              );}),

              //             icon: new Stack(
              //   children: <Widget>[
              //     new Icon(Icons.upcoming),
              //     new Positioned(
              //       right: 0,
              //       child: new Container(
              //         padding: EdgeInsets.all(1),
              //         decoration: new BoxDecoration(
              //           color: Colors.red,
              //           borderRadius: BorderRadius.circular(6),
              //         ),
              //         constraints: BoxConstraints(
              //           minWidth: 12,
              //           minHeight: 12,
              //         ),
              //         child: new Text(
              //           '$_counter',
              //           style: new TextStyle(
              //             color: Colors.white,
              //             fontSize: 8,
              //           ),
              //           textAlign: TextAlign.center,
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              // //),
              // Tab(
              //   text: "New orders",
              //   icon: Icon(Icons.local_dining),
            ),
            Tab(
              text: "Current orders",
              icon: Icon(Icons.local_dining),
            ),
            Tab(
              text: "Past orders",
              icon: Icon(Icons.history),
            ),
          ],
        ),
        Expanded(
            child: TabBarView(
          physics: ScrollPhysics(),
          controller: _tabController,
          children: [
            //RBOrders(),
            ashRBOrders(),
            currentorder(), pastorder(),
            // Center(
            //   child:
            SingleChildScrollView(
                child: Container(
              child: Column(
                  // mainAxisAlignment:
                  //     MainAxisAlignment.spaceBetween,
                  children: []
                  // (listOfRestaurantsByNearby.isNotEmpty) ?

                  //   : [Center(child: Text("your location is not supoorted "),)]
                  ),
            )),
          ],
        )

            // child: Container(TabBar(
            //   controller: _tabController,
            //   labelColor: Batatis_Dark,
            //   unselectedLabelColor: grey_Dark,
            //   indicatorSize: TabBarIndicatorSize.tab,
            //   indicatorPadding: EdgeInsets.all(5.0),
            //   tabs: const [
            //     Tab(
            //       text: "New orders",
            //       icon: Icon(Icons.upcoming),
            //     ),
            //     Tab(
            //       text: "Current orders",
            //       icon: Icon(Icons.local_dining),
            //     ),
            //     Tab(
            //       text: "Past orders",
            //       icon: Icon(Icons.history),
            //     ),
            //   ],
            // ),
            // Expanded(
            //   child: TabBarView(
            //     physics: NeverScrollableScrollPhysics(),
            //     controller: _tabController,
            //     children: [
            //       // Center(
            //       //   child:
            //       SingleChildScrollView(
            //           child: Container(
            //         child: Column(
            //             // mainAxisAlignment:
            //             //     MainAxisAlignment.spaceBetween,
            //             children:
            //                 // (listOfRestaurantsByNearby.isNotEmpty) ?
            //                RBOrders.allorders;

            //             //   : [Center(child: Text("your location is not supoorted "),)]
            //             ),
            //       )),
            //       //   ),
            //     ],
            //   ),
            // ),
            //   child: Column(
            // children: [
            //   TabBar(
            //     controller: _tabController,
            //     labelColor: Batatis_Dark,
            //     unselectedLabelColor: grey_Dark,
            //     indicatorSize: TabBarIndicatorSize.tab,
            //     indicatorPadding: EdgeInsets.all(5.0),
            //     tabs: const [
            //       Tab(
            //         text: "New orders",
            //         icon: Icon(Icons.upcoming),
            //       ),
            //       Tab(
            //         text: "Current orders",
            //         icon: Icon(Icons.local_dining),
            //       ),
            //       Tab(
            //         text: "Past orders",
            //         icon: Icon(Icons.history),
            //       ),
            //     ],
            //   ),
            //   Expanded(
            //     child: TabBarView(
            //       physics: NeverScrollableScrollPhysics(),
            //       controller: _tabController,
            //       children: [
            //         //   ),
            //       ],
            //     ),
            //   ),

            //  ],

            //  Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: <Widget>[

            //       SvgPicture.asset('assets/Images/No_Orders.svg'),
            //       CustomText(
            //         text: "No incoming orders",
            //         color: Batatis_Dark,
            //       ),
            //     ]),
            )
      ])),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Text(""),
      // ),
    );
  }
}
