import 'package:batatis/Costomer_Screens/Cmainpage.dart';
import 'dart:async';
import 'package:batatis/Costomer_Screens/All_Costomer_Screens.dart';
import 'package:batatis/Costomer_Screens/SummaryPage.dart';
import 'package:batatis/RestaurantBranch_Screens/All_RestaurantBranch_Screens.dart';
//import 'package:batatis/Costomer_Screens/WaitingPage.dart';
import 'package:batatis/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Views/Customer_View.dart';
import '/Customer_Widgets/All_customer_Widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WaitingPage extends StatefulWidget {
  @override
  _WaitingPageState createState() => _WaitingPageState();
}

var orederid = SharedPrefer.CurrentOrderId.toString();

class _WaitingPageState extends State<WaitingPage> {
  int _remainingTime = 0;
  bool _orderAccepted = false;
  bool _orderCanceled = false;
  bool hasNavigated = false;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _startCountdownTimer();
  }

  @override
  void dispose() {
    // Cancel any timers or animations here
    //timer.cancel(); // Replace 'timer' with your actual timer variable
    super.dispose();
  }

  void _startCountdownTimer() {
    setState(() {
      _remainingTime = 300; // 5 minutes in seconds
    });

    Timer.periodic(Duration(seconds: 1), (timer) async {
      // var orderStatus ;
      var orederid = SharedPrefer.CurrentOrderId.toString();
      print("counting");
      if (_remainingTime % 5 == 0) {
        var orderStatus = await FirebaseFirestore.instance
            .collection('Orders')
            .doc(orederid)
            .get();
        var stastus = orderStatus.get("status");
        if (!mounted) {
          timer.cancel(); // Cancel the timer if the widget is no longer mounted
          return;
        }
        if (stastus == "Preparing") {
         
          timer.cancel();
          var link = await Link.createDynamicLinkfordriver(orederid);
          await FirebaseFirestore.instance
            .collection('Orders')
            .doc(orederid).update({"delivery link" : link});
     payment pay = payment();
      pay.makePayment(SharedPrefer.total , orederid);
          SummaryPage.orderid = orederid ; 
          SharedPrefer.SetStatus(SharedPrefer.CurrentOrderId.toString(), "Preparing");
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SummaryPage(),
            ),
          );
           SharedPrefer.DeleteCurrentOrder();
        } else if (stastus == "Rejected") {
          timer.cancel();
          showDialog<String>(
              context: context,
              builder: (context) {
                return CustomDialog(
                    type: "reject",
                    title: "",
                    text:
                        "the restaurant can not take your order now . Please try again or choose another restaurant. ",
                    action: null,
                    onPressed: () {
                      SharedPrefer.DeleteCurrentOrder();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => CHomePage()),
                        (route) => false, // Remove all routes from the stack
                      );
                    });
              });
               SharedPrefer.DeleteCurrentOrder();
        }
      }
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          timer.cancel();
          if (!_orderAccepted) {
            // Show a message if the time finishes and the order is not accepted
            showDialog<String>(
                context: context,
                builder: (context) {
                  return CustomDialog(
                    type: "reject",
                    title: "",
                    text:
                        "the restaurant didn't accept your order. Please try again or choose another restaurant. ",
                    action: null,
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('Orders')
                          .doc(orederid)
                          .update({"status": "Timedout"});
                      SharedPrefer.DeleteCurrentOrder();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => CHomePage()),
                        (route) => false, // Remove all routes from the stack
                      );
                    },
                  );
                });

            //            ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(
            //     content: Text("Sorry, the restaurant didn't accept your order. Please try again or choose another restaurant."),
            //         )
            //   );
            //        Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => ViewMenuToCustomer()),
            // );
             SharedPrefer.DeleteCurrentOrder();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        wantback: false,
      ),
      //AppBar(
      //  automaticallyImplyLeading: false,
      //   backgroundColor: Batatis_Dark,
      //   title:
      //   Container(  alignment : Alignment.bottomLeft,
      //   //  transformAlignment:
      //     child: Image.asset(

      //     'assets/Images/BatatisLogo.jpeg',
      //     alignment : Alignment.bottomLeft,
      //     width: 120,
      //     height: 145,
      //   ),),
      //  // actions:actions
      // ),

      //CustomAppBar(wantback:true,),
      key: _scaffoldKey,

      body: WaitingContent(
          _remainingTime, _orderAccepted, _orderCanceled, hasNavigated),
    );
  }
}

class WaitingContent extends StatelessWidget {
  final int remainingTime;
  final bool orderAccepted;
  final bool orderCanceled;
  bool hasNavigated;

  WaitingContent(this.remainingTime, this.orderAccepted, this.orderCanceled,
      this.hasNavigated);

  @override
  Widget build(BuildContext context) {
    if (orderAccepted) {
      return SummaryPage();
    } else if (orderCanceled) {
      return ViewMenuToCustomer(); // i want to add feedback message !! but i can't
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Waiting for the restaurant to accept the order',
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              SizedBox(
                width: 200, // Adjust the width to change the ring size
                height: 200, // Adjust the height to change the ring size
                child: CircularProgressIndicator(
                  value: (remainingTime / 300), // Show progress
                  strokeWidth: 10.0,
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(195, 138, 1, 1)),
                ),
              ),
              Text(
                '${(remainingTime ~/ 60)}:${(remainingTime % 60).toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
