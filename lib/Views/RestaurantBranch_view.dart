import 'package:batatis/RestaurantBranch_Screens/All_RestaurantBranch_Screens.dart';
import 'package:batatis/RestaurantBranch_Screens/RBAccount.dart';
import 'package:batatis/RestaurantBranch_Screens/RBeditprofile.dart';
import 'package:batatis/RestaurantBranch_Screens/RestaurantBranch_SignIn.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/RestaurantBranch_Widgets/All_RB_Widgets.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cloud_firestore/cloud_firestore.dart';

class RBHomePage extends StatefulWidget {
  RBHomePage({Key? key, required this.body}) : super(key: key);
  Widget body = RBmainpage();

  @override
  State<RBHomePage> createState() => RBHomePageState(Thebody: body);
}

class RBHomePageState extends State<RBHomePage> {
  //////////////////sadeem//////////////
  final FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;
  Widget Thebody = RBmainpage();
  RBHomePageState({required this.Thebody});
  Color aa = white;
  Color bb = Batatis_Dark;
  Color cc = Batatis_Dark;
  Color dd = white;

  static int num = 0;
  late bool _showBadge;
  static late StateSetter set;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    set = setState;
    _showBadge = num > 0;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Batatis_Dark,
        title: Image.asset(
          'assets/Images/Batatis_logo.jpeg',
          width: 200,
          height: 100,
        ),
        actions: [
          TextButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(aa)),
            child: badges.Badge(
              showBadge: _showBadge,
              badgeStyle: badges.BadgeStyle(
                badgeColor: Color.fromARGB(255, 243, 33, 33),
              ),
              position: badges.BadgePosition.topEnd(top: -18, end: -16),
              badgeContent: Text(
                num.toString(),
                style: TextStyle(color: white),
              ),
              child: Text(
                'Orders',
                style: TextStyle(color: bb),
              ),
            ),
            onPressed: () {
              setState(() {
                aa = white;
                bb = Batatis_Dark;
                cc = Batatis_Dark;
                dd = white;
                Thebody = RBmainpage();
              });
            },
          ),
          ////////////// DONT DELETE THIS IT IS FOR THE NEXT SPRINT!!!!!!!!!!!!
          // TextButton(
          // // IconButton(
          // //   icon: const Icon(Icons.home),
          //  child:  Text('Orders'),
          //   onPressed: () {
          //     setState(() {
          //       Thebody = order();
          //     });
          //   },
          // ),
          SizedBox(
            width: 5,
          ),
          TextButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(cc)),
            child: Text(
              'Menu',
              style: TextStyle(color: dd),
            ),
            onPressed: () {
              setState(() {
                aa = Batatis_Dark;
                bb = white;
                cc = white;
                dd = Batatis_Dark;
                Thebody = viewMenu();
              });
            },
          ),
          const SizedBox(
            width: 5,
          ),
          PopupMenuButton(
              offset: const Offset(0, 27),
              itemBuilder: (context) => [
                    PopupMenuItem(
                        child: Row(
                          children: [
                            Icon(
                              Icons.account_circle,
                              size: 18,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Profile'),
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            aa = Batatis_Dark;
                            bb = white;
                            cc = Batatis_Dark;
                            dd = white;
                            Thebody = RBeditprofile();
                          });
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => RBeditprofile()));
                        }),
                    PopupMenuItem(
                        child: GestureDetector(
                      onTap: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Confirm Log Out'),
                            content: const Text(
                                'Are you sure you want to log out?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(
                                  context,
                                ),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => {
                                  FirebaseAuth.instance
                                      .signOut()
                                      .then((value) async {
                                    print("Sign out Successfully");

// ScaffoldMessenger.of(context).showSnackBar(SnackBar( content: Text('Sign out Successfully!'), backgroundColor: red,));
                                    Navigator.of(context)
                                        .pushReplacement(MaterialPageRoute(
                                      builder: (context) => SignInPage(),
                                    ));
////////////////////////////////sadeem//////need helllpppppp/////////////////////////////////////

                                    // await _firebasefirestore
                                    //     .collection("Restaurants")
                                    //     .doc(response.user!.uid)
                                    //     .update({'Token': 'None'});

                                    // print("token weeeeebbbbb:None");

/////////////////////////////////////////////////////////////////////////////////////////////////
                                    sharedPref.setUserLoggedIn(false);
                                  }),
                                  Navigator.pop(
                                    context,
                                  ),
                                },
                                child: Text(
                                  'Sign out',
                                  style: TextStyle(color: red),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.logout,
                                size: 18,
                                color: Colors.red,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Sign out',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
                  ],
              child: Icon(
                Icons.menu,
                color: white,
              )),
          const SizedBox(
            width: 8,
          ),
//           IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () {
//               // FirebaseAuth.instance.signOut().then((value) {
//               //   Navigator.pushNamedAndRemoveUntil(
//               //       context, "/RBHomePage", (Route<dynamic> route) => false);
//               // });
// //showMenu(
//               //context: context,
//               // items: [
//               // PopupMenuItem(
//               // child: Text('Logout'),
//               //    onTap: () async {
// //FirebaseAuth.instance.signOut().then((value) {
//               //   Navigator.pushNamedAndRemoveUntil(context, "/RBHomePage", (Route<dynamic> route) => false);
//               // });
//
//               //   await FirebaseAuth.instance.signOut();
//               //   Navigator.of(context).pushNamed('/RBHomePage');
//               //  },
//               // ),
//               //  ], position: null,
//               // );
//             },
//           ),
        ],
      ),
      body: Thebody,
      bottomNavigationBar: Container(
        color: grey_light,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Copyright © 2023 BATATIS',
              style: TextStyle(
                color: black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget hh() {
    return Text("this feature will be in the next version");
  }

  Widget menu() {
    return viewMenu();
  }
}
