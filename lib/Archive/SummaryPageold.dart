import 'dart:io';

import 'package:batatis/Costomer_Screens/CGroupOrderCart%20.dart';
import 'package:batatis/Costomer_Screens/ViewMenuToCustomer.dart';
import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
import 'package:batatis/Customer_Widgets/Customer_AppBar.dart';
import 'package:batatis/Customer_Widgets/Customer_texts.dart';
import 'package:batatis/Customer_Widgets/SharedPrefer.dart';
import 'package:batatis/Customer_Widgets/colors.dart';
import 'package:batatis/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:flutter/material.dart';

import '../Views/Customer_View.dart';

class oldSummaryPage extends StatelessWidget {
  final List<String> orderStatuses = [
    'waiting',
    // 'ongoing',
    'Preparing',
    'Out for Delivery',
    'Delivered',
  ];
  static var orderid = "";
  final String orderSummary = "Your order summary goes here.";

  @override
  Widget build(BuildContext context) {
    print("here summery " + orderid);
    return Scaffold(
      appBar: //CustomAppBar(),
          AppBar(
        actionsIconTheme: IconThemeData(color: white),
        leading: BackButton(
          color: white,
          onPressed: () {
            CHomePageState.changetab(1);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => CHomePage()),
              (route) => false, // Remove all routes from the stack
            );
          },
        ),
        // automaticallyImplyLeading: //wantback, //true,
        backgroundColor: Batatis_Dark,
        title: Container(
          alignment: Alignment.bottomLeft,
          ////  transformAlignment:
          child: Image.asset(
            'assets/Images/BatatisLogo.jpeg',
            alignment: Alignment.bottomLeft,
            width: 120,
            height: 145,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          OrderStatusProgressBar(),
          // orderSummaryState(orderSummary: orderSummary),
        ],
      ),
    );
  }
}

class OrderStatusProgressBar extends StatefulWidget {
  @override
  _OrderStatusProgressBar createState() => _OrderStatusProgressBar();
}

class _OrderStatusProgressBar extends State<OrderStatusProgressBar> {
  final List<String> orderStatuses = [
    'waiting',
    //  'ongoing',
    'Preparing',
    'Out for Delivery',
    'Delivered',
  ];
  late Stream _myStream;
  late Stream progressStream;
  Set<DocumentSnapshot> mySet = {};
  double total = 0;
  double Dfee =67; //this is what ruined our evaluation !!!!
  String statusCode = 'Preparing';
  //String Rname = ViewMenuToCustomerState.ResturantName.toString();///restaurant name from hind!!!!!!!!!!!!!!!!!!!!
  String Olocation = "";

  @override
  void initState() {
    _myStream = FirebaseFirestore.instance
        .collection("Orders")
        .doc(oldSummaryPage.orderid)
        .collection("Member")
        .snapshots();
    progressStream = FirebaseFirestore.instance
        .collection("Orders")
        .doc(oldSummaryPage.orderid)
        .snapshots();
    print('InitState');
    super.initState();
  }

  int findStringIndexInList(String target) {
    for (int i = 0; i < orderStatuses.length; i++) {
      if (orderStatuses[i] == target) {
        print('indexis::::: $i');
        return i;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    
    print('orderIDDDDD: ${oldSummaryPage.orderid}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Order Status',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StreamBuilder(
                  stream: progressStream,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // While data is loading, show a loading indicator.
                      print("wait");
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // If an error occurs, display an error message.
                      return Text('no data' /*'Error: ${snapshot.error}'*/);
                    } else if (snapshot.hasData) {
                      DocumentSnapshot querySnapshot = snapshot.data!;
                      print("DocumentttttT: ${querySnapshot}");

                      print(querySnapshot.get('status'));
                      statusCode = querySnapshot.get('status');
                    }

                    return Row(
                      children: [
                        for (var status in orderStatuses)
                          Expanded(
                            child: Column(
                              children: [
                                CustomIcon(
                                  isCompleted: orderStatuses.indexOf(status) <=
                                      orderStatuses.indexOf(orderStatuses[
                                          findStringIndexInList(statusCode)]),
                                ),
                                Text(
                                  status,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                      ],
                    );
                  }),
              const SizedBox(
                height: 30,
              ),

              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'About the Order',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Icon(
                          Icons.restaurant,
                          color: Batatis_Dark,
                          size: 20.0,
                        ),
                        Text(
                          "Restaurant",
                          style: TextStyle(
                              // color: grey_light,
                              fontFamily: 'PoppinsMedium',
                              color: Batatis_Dark,
                              fontSize: 14),
                        ),
                        Text(
                          CCurrentOrderState.aboutOrderModel.getResturantName,
                          style: TextStyle(
                              color: grey_Dark,
                              fontFamily: 'PoppinsMedium',
                              fontSize: 12),
                        ),
                        const Text(
                          "",
                          style: TextStyle(fontSize: 12),
                        ),
                        const Text(
                          "",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Batatis_Dark,
                        size: 20.0,
                      ),
                      Text(
                        "Location",
                        style: TextStyle(
                            // color: grey_light,
                            fontFamily: 'PoppinsMedium',
                            color: Batatis_Dark,
                            fontSize: 14),
                      ),
                      Container(
                        width: 80,
                        child: Text(
                          CCurrentOrderState.aboutOrderModel.getResturantLoc,
                          // "ggggggggggggggggggggggggggggggggggggggggggggg",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis, // new
                          style: TextStyle(
                              color: grey_Dark,
                              fontFamily: 'PoppinsMedium',
                              fontSize: 12),
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.info,
                        color: Batatis_Dark,
                        size: 20.0,
                      ),
                      Text(
                        "Order Info",
                        style: TextStyle(
                            // color: grey_light,
                            fontFamily: 'PoppinsMedium',
                            color: Batatis_Dark,
                            fontSize: 14),
                      ),
                      Text(
                        CCurrentOrderState.aboutOrderModel.getOrderType,
                        style: TextStyle(
                            color: grey_Dark,
                            fontFamily: 'PoppinsMedium',
                            fontSize: 12),
                      ),
                      Text(
                        CCurrentOrderState.aboutOrderModel.getOrderDate,
                        style: TextStyle(
                            color: grey_Dark,
                            fontFamily: 'PoppinsMedium',
                            fontSize: 12),
                      ),
                      Text(
                        CCurrentOrderState.aboutOrderModel.getOrderTime,
                        style: TextStyle(
                            color: grey_Dark,
                            fontFamily: 'PoppinsMedium',
                            fontSize: 12),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.payment,
                        color: Batatis_Dark,
                        size: 20.0,
                      ),
    //                 TextButton(onPressed: (){
    //                   print("stasrt payment");
    // //  payment pay = payment();
    // //   pay.makePayment(SharedPrefer.total);
    //                 }, child: 
                      Text(
                        "Payement",
                        style: TextStyle(
                            // color: grey_light,
                            fontFamily: 'PoppinsMedium',
                           //decoration: TextDecoration.underline,

                            color: Batatis_Dark,
                            fontSize: 14),
                      ),
                      //),
                      Text(
                        CCurrentOrderState.aboutOrderModel.getPaymentMethod,
                        style: TextStyle(
                        
                            color: grey_Dark,
                            fontFamily: 'PoppinsMedium',
                            fontSize: 12),
                      ),
                      Text(
                        '',
                        style: TextStyle(
                            color: grey_Dark,
                            fontFamily: 'PoppinsMedium',
                            fontSize: 12),
                      ),
                      Text(
                        '',
                        style: TextStyle(
                            color: grey_Dark,
                            fontFamily: 'PoppinsMedium',
                            fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),

              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Order Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder(
                  stream: _myStream,
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // While data is loading, show a loading indicator.
                      print("wait");
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // If an error occurs, display an error message.
                      return Text('no data' /*'Error: ${snapshot.error}'*/);
                    } else if (snapshot.hasData) {
                      QuerySnapshot querySnapshot = snapshot.data!;
                      print("before gooo ${querySnapshot.docs.length}");
                      querySnapshot.docs.forEach((DocumentSnapshot doc) async {
                        print("gooo");
                        mySet.clear();
                        mySet.add(doc);
                        //numOfMembers = numOfMembers + 1;
                      });
                      print("Fetched QuerySnapshot: $querySnapshot");
                    }
                    return Column(
                      children: setUserOrderWidgets(),
                    ); //Text('Nothing there');
                  }),
              //orderSummary(),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> setUserOrderWidgets() {
    mySet = mySet.toSet();
    List<Widget> orderWidgets = [];

    mySet.forEach((doc) {
      orderWidgets.add(Container(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          color: Batatis_light.withOpacity(0.7),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              doc.get('name'),
              style: const TextStyle(fontFamily: 'PoppinsMedium', fontSize: 16),
            ),
            const Text(
              "confirmed",
              style: TextStyle(
                  color: Colors.green,
                  fontFamily: 'PoppinsMedium',
                  fontSize: 12),
            )
          ])));

      List<dynamic> prices = doc.get('prices');
      List<dynamic> quantity = doc.get('quantity');
      int j = -1;
      double msubtotal = 0;
      double subtotal = 0;

      List<dynamic> items = doc.get('items');
      items.forEach((itemData) {
        j = j + 1;
        double w = prices[j] * quantity[j].toDouble();
        msubtotal = msubtotal + w;
        orderWidgets.add(Container(
          margin: const EdgeInsets.all(0),
          width: 370,
          child: Padding(
              padding:
                  const EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        text: 'x' + quantity[j].toString(), type: "paragraph"),
                    //  SizedBox(width: 80), // give it width
                    const Spacer(),

                    CustomText(text: items[j], type: "paragraph"),
                    //   SizedBox(width: 80), // give it width
                    const Spacer(),

                    CustomText(text: w.toString() + ' SR', type: "paragraph"),
                    // Divider(
                    //                 color: Colors.grey,
                    //               ),
                  ])),
        ));
      });

      subtotal = subtotal + msubtotal;
 
      print("preint payment");
      orderWidgets.add(Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 1.0),
          child: Text(
            ' total: ' + msubtotal.toString() + ' SR',
            style: TextStyle(
              fontFamily: 'PoppinsMedium',
              fontStyle: FontStyle.normal,
              color: Batatis_Dark,

              // fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ));

      total = subtotal + Dfee;
      orderWidgets.add(Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 1.0),
              child: Text(
                'Subtotal: ' + subtotal.toString() + ' SR',
                style: TextStyle(
                  fontFamily: 'PoppinsMedium',
                  fontStyle: FontStyle.normal,
                  // fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 1.0),
              child: Text(
                // ignore: prefer_interpolation_to_compose_strings
                'Delivery fee: ' + Dfee.toString() + ' SR',
                style: const TextStyle(
                  fontFamily: 'PoppinsMedium',
                  fontStyle: FontStyle.normal,
                  // fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 1.0, bottom: 10),
              child: Text(
                'Total: ' + total.toString() + ' SR',
                style: TextStyle(
                  fontFamily: 'PoppinsMedium',
                  fontStyle: FontStyle.normal,
                  color: Batatis_Dark,

                  // fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ));
    });

    return orderWidgets;
  }

}

class CustomIcon extends StatelessWidget {
  final bool isCompleted;

  CustomIcon({required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: isCompleted ? 36 : 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCompleted ? Color.fromRGBO(195, 138, 1, 1) : Colors.grey,
      ),
      child: Icon(
        isCompleted ? Icons.check : Icons.remove,
        color: Colors.white,
        size: 15,
      ),
    );
  }
}
