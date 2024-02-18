import 'dart:async';
import 'dart:io';

import 'package:batatis/Costomer_Screens/CGroupOrderCart%20.dart';
import 'package:batatis/Costomer_Screens/ViewMenuToCustomer.dart';
import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
import 'package:batatis/Customer_Widgets/Customer_AppBar.dart';
import 'package:batatis/Customer_Widgets/Customer_texts.dart';
import 'package:batatis/Customer_Widgets/SharedPrefer.dart';
import 'package:batatis/Customer_Widgets/colors.dart';
import 'package:batatis/moudles/RBModels.dart';
import 'package:batatis/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:flutter/material.dart';

import '../Views/Customer_View.dart';

class SummaryPage extends StatelessWidget {
  final List<String> orderStatuses = [
    'waiting',
    // 'ongoing',
    'Preparing',
    'Out for Delivery',
    'Delivered',
  ];
  static var orderid = "";

  static StateSetter? set ;
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
 
  late Stream progressStream;
  Set<DocumentSnapshot> mySet = {};
  bool loaded = false ; 
  late  Orders? Theorder ; 
  double total = 0;
  double Dfee =0; //this is what ruined our evaluation !!!!
  String statusCode = 'waiting';
  //String Rname = ViewMenuToCustomerState.ResturantName.toString();///restaurant name from hind!!!!!!!!!!!!!!!!!!!!
  String Olocation = "";
  String stat = "";

  @override
  void initState() {
    
    progressStream = FirebaseFirestore.instance
        .collection("Orders")
        .doc(SummaryPage.orderid)
        .snapshots();
    startCount();
    fetchOrder();
    print('InitState');
    super.initState();
  }

    void dispose() {
    super.dispose();
    print("disposed");
    // Cancel the timer or dispose of any ongoing process
    _timer.cancel();
    
  }
   late Timer _timer;
int count = 0;
  void startCount() {
   _timer =  Timer.periodic(Duration(seconds: 5), (timer) {
      count++;
       print("timer summerypppppage $count");
      if (count >= 90) {
        setState(() {
          //update the page every 100 sec
          fetchOrder();
          print("timerrr orders reloading $count");
          count = 0; // await Reset the count after 10 seconds.
        });
      }
    });
  }
    Future<void> fetchOrder() async {
      
        Theorder = await Orders.getOrder(SummaryPage.orderid,membersWithItems: true) ; 
        setState(() {
          loaded = true ; 
        });
        print("ordere is hereee");
        print("ghgh fff${Theorder!.Restaurantobj.address}");
      
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
  List<Widget> BulidStatusWithArrow({ pteto = "normal"}){
    List<Widget> Status = [] ; 
    int c = 0 ;
    if(pteto == "Rejected"){     
      Status.add(Expanded(
                            child: Column(
                             
                              children: [
                                
                                Container(
      width: 36,
      height:  36 ,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:  Color.fromRGBO(195, 138, 1, 1) ,
      ),
      child: Icon(
        Icons.check ,
        color: Colors.white,
        size: 15,
      ),
    ),
                                // Text(
                                //   status,
                                //   style: TextStyle(fontSize: 12),
                                // ),
                              ],
                            ),
                          ));
      
      Status.add(Icon(Icons.arrow_forward , size: 22,)); 
      Status.add(Expanded(
                            child: Column(
                             
                              children: [
                                
                                Container(
      width: 36,
      height:  36 ,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: red ,
      ),
      child: Icon(
       Icons.close,
        color: Colors.white,
        size: 15,
      ),
    )
                                // Text(
                                //   status,
                                //   style: TextStyle(fontSize: 12),
                                // ),
                              ],
                            ),
                          ));
    }else  if(pteto == "Timedout"){     
      Status.add(Expanded(
                            child: Column(
                             
                              children: [
                                
                                Container(
      width: 36,
      height:  36 ,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:  Color.fromRGBO(195, 138, 1, 1) ,
      ),
      child: Icon(
        Icons.check ,
        color: Colors.white,
        size: 15,
      ),
    ),
                                // Text(
                                //   status,
                                //   style: TextStyle(fontSize: 12),
                                // ),
                              ],
                            ),
                          ));
      
      Status.add(Icon(Icons.arrow_forward , size: 22,)); 
      Status.add(Expanded(
                            child: Column(
                             
                              children: [
                                
                                Container(
      width: 36,
      height:  36 ,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey ,
      ),
      child: Icon(
       Icons.timer_off,
        color: Colors.white,
        size: 15,
      ),
    )
                                // Text(
                                //   status,
                                //   style: TextStyle(fontSize: 12),
                                // ),
                              ],
                            ),
                          ));
    }else
      {for (var status in orderStatuses)
                          {
                            if(c != 0 ){
                           c = c+1 ;
                           Status.add(Icon(Icons.arrow_forward , size: 22,));}
                             c = c+1 ;
                            Status.add(Expanded(
                            child: Column(
                             
                              children: [
                                CustomIcon(
                                  isCompleted: orderStatuses.indexOf(status) <=
                                      orderStatuses.indexOf(orderStatuses[
                                          findStringIndexInList(statusCode)]),
                                ),
                                // Text(
                                //   status,
                                //   style: TextStyle(fontSize: 12),
                                // ),
                              ],
                            ),
                          ));
                          
                          }}
    return Status ; 
  } @override


  @override
  Widget build(BuildContext context) {
    SummaryPage.set =  setState;
   // var Subtotal =  double.parse( Theorder!.Total) - double.parse(Theorder!.Restaurantobj.fee );
    print("rebuliding summery page");
    print('orderIDDDDD: ${SummaryPage.orderid}');
    return 
    loaded ? 
    RefreshIndicator(
        onRefresh: fetchOrder,
        child:
   SingleChildScrollView(
    physics: AlwaysScrollableScrollPhysics(),
  child:
    Column(
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
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              !(Theorder!.status == "Rejected" || Theorder!.status == "Timedout")?
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
                    //   if(SummaryPage.orderid ==SharedPrefer.CurrentOrderId )
                    //  {
                    //      SharedPrefer.SetStatus(SummaryPage.orderid, statusCode.toString());
                     
                    //    }
                    }

                     return
                    
                    Column(children: [
                       Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: BulidStatusWithArrow()   ),
                       Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [Text(
                                  "  Waiting",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "        Preparing",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "  Out for Delivery",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "  Delivered",
                                  style: TextStyle(fontSize: 12),
                                ),
                                
                                
                                 ]  ),
                    ],);
                  }
                  ) 
                  :  Column(children: [
                       Row(
                    //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: BulidStatusWithArrow(pteto: Theorder!.status)   ),
                       Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [Text(
                                  "  Waiting",
                                  style: TextStyle(fontSize: 12),
                                ),
                                Text(
                                  "        ${Theorder!.status}",
                                  style: TextStyle(fontSize: 12),
                                ),])])
                  // Container(
                  //       // margin: EdgeInsets.fromLTRB(79, 5, 5, 5),
                  //       // padding: EdgeInsets.all(2),
                  //       decoration: BoxDecoration(
                  //         border: Border.all(color: Colors.red),
                  //         borderRadius: const BorderRadius.only(
                  //             topLeft: Radius.circular(10),
                  //             topRight: Radius.circular(10),
                  //             bottomLeft: Radius.circular(10),
                  //             bottomRight: Radius.circular(10)), // Green border
                  //         color: Colors.white, // White background
                  //       ),
                  //       child: Text(
                  //         "Rejected",
                  //         style: TextStyle(
                  //           color: Colors.red,
                  //           fontSize: 20.0 // Green text color
                  //         ),
                  //       ),
                  //     ),
,
              const SizedBox(
                height: 30,
              ),
///////////////////////////////////////////////////////////////// here ash go
              Container(
                alignment : Alignment.centerLeft,
                margin: EdgeInsets.only(
       left : 16.0
                  ),
                child: Text(
                  'About the Order',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            
   
   
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    child: 
                    Column(
                      children: [
                        Icon(
                          Icons.restaurant,
                          color: Batatis_Dark,
                          size: 30.0,
                        ),
                        // Text(
                        //   "Restaurant",
                        //   style: TextStyle(
                        //       // color: grey_light,
                        //       fontFamily: 'PoppinsMedium',
                        //       color: Batatis_Dark,
                        //       fontSize: 14),
                        // ),
                        Text(
                          Theorder!.Restaurantobj.resturantName , //CCurrentOrderState.aboutOrderModel.getResturantName,
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
                        size: 30.0,
                      ),
                      // Text(
                      //   "Location",
                      //   style: TextStyle(
                      //       // color: grey_light,
                      //       fontFamily: 'PoppinsMedium',
                      //       color: Batatis_Dark,
                      //       fontSize: 14),
                      // ),
                      Container(
                        width: 80,
                        child: Text(
                          Theorder!.Restaurantobj .address ,//CCurrentOrderState.aboutOrderModel.getResturantLoc,
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
                        size: 30.0,
                      ),
                      Text(
                        "#${Theorder!.orderId}",//"Order Info",
                        style: TextStyle(
                            color: grey_Dark,
                            fontFamily: 'PoppinsMedium',
                            fontSize: 12),
                      ),
                     
                      Text(
                       Theorder!.OrderTime.substring(0,10) , /// CCurrentOrderState.aboutOrderModel.getOrderDate,
                        style: TextStyle(
                            color: grey_Dark,
                            fontFamily: 'PoppinsMedium',
                            fontSize: 12),
                      ),
                      Text(
                       Theorder!.OrderTime.substring(11,16),
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
                        size: 30.0,
                      ),
                  
                      Text(
                         Theorder!.PaymentMethod != "Paid" ? "Cash on Delievery" : "Paid",// CCurrentOrderState.aboutOrderModel.getPaymentMethod,
                        style: TextStyle(
                            color:  Theorder!.PaymentMethod != "Paid" ? grey_Dark : Colors.green,
                            fontFamily: 'PoppinsMedium',
                            fontSize: 12),
                      ),//
                     ( Theorder!.PaymentMethod != "Paid" && SharedPrefer.UserId! == Theorder!.creatorId &&(statusCode == "Preparing" ||statusCode == "Out for Delivery" )) ?
                      //&& SummaryPage.orderid == SharedPrefer.CurrentOrderId
                      CustomButton(text: "Pay", onPressed: (){
                        print(" i think this is the right total ${Theorder!.Total}");
                        payment pay = payment();
      pay.makePayment(Theorder!.Total , SummaryPage.orderid);} , type: "confirm",width: 80,height: 23,fontSize: 14,)
                      
                      
                      :Text(
                        '',
                        style: TextStyle(
                            color: grey_Dark,
                            fontFamily: 'PoppinsMedium',
                            fontSize: 12),
                      ),
                      //  if (Theorder!.PaymentMethod == "Paid")  Text(
                      //   '',
                      //   style: TextStyle(
                      //       color: grey_Dark,
                      //       fontFamily: 'PoppinsMedium',
                      //       fontSize: 12),
                      // )
                    ],
                  ),
                ],
              ),

               Container(
                alignment : Alignment.centerLeft,
                margin: EdgeInsets.all(
               16.0
                  ),
                child: Text(
                  'Order Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
           
  //            Stack(
  // children: [
                // Container(
                //   color: black,
                //   height: 254,
                //   child:   SingleChildScrollView(child : 
                  Column(
                      children: setUserOrderWidgets(),
              //      )) ,
   )
,
     
  // ])
            ],
          ),
        ),
      ],
    ))): Center(child:  CircularProgressIndicator());
  }

  List<Widget> setUserOrderWidgets() {
    mySet = mySet.toSet();
    List<Widget> orderWidgets = [];
     List<Widget> allWidgets = [];
  var ItemsMembers = Theorder!.ItemsWithMembers;
  //var members = ItemsMembers.keys.toList() ; 
  
       ItemsMembers.forEach((member,memberitems) {
      orderWidgets.add(Container(
          padding: const EdgeInsets.only(
            left: 8,
            right: 8,
          ),
          margin:  const EdgeInsets.only(  left: 16,
            right: 16,),
          color: Batatis_light.withOpacity(0.7),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              member,
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

      List<dynamic> prices = memberitems.prices ;//.get('prices');
      List<dynamic> quantity = memberitems.quantitys ; //.get('quantity');
      int j = -1;
      double msubtotal = 0;
      double subtotal = 0;

      List<dynamic> items = memberitems.items ;  //.get('items');
      items.forEach((itemData) {
        j = j + 1;
        double w = prices[j] * quantity[j].toDouble();
        msubtotal = msubtotal + w;
        orderWidgets.add(
          Container(
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
      orderWidgets.add(
       
        
        Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.only(right: 1.0),
           margin:  const EdgeInsets.only(  left: 16,
            right: 16,),
          child: Text(
            ' Total: ' + msubtotal.toString() + ' SR',
            style: TextStyle(
              fontFamily: 'PoppinsMedium',
              fontStyle: FontStyle.normal,
              color: Batatis_Dark,

              // fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      )
      
      );

      
    });
 
//total =Theorder!.Total;
// var Subtotal =  double.parse( Theorder!.Total) - double.parse(Theorder!.Restaurantobj.fee );
//       orderWidgets.add(Column(
//         children: [
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: EdgeInsets.only(left: 1.0),
//               child: Text(
//                 'Subtotal: ' + Subtotal.toString() + ' SR',
//                 style: TextStyle(
//                   fontFamily: 'PoppinsMedium',
//                   fontStyle: FontStyle.normal,
//                   // fontWeight: FontWeight.w500,
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: EdgeInsets.only(left: 1.0),
//               child: Text(
//                 // ignore: prefer_interpolation_to_compose_strings
//                 'Delivery fee: ' + Theorder!.Restaurantobj.fee + ' SR',
//                 style: const TextStyle(
//                   fontFamily: 'PoppinsMedium',
//                   fontStyle: FontStyle.normal,
//                   // fontWeight: FontWeight.w500,
//                   fontSize: 14,
//                 ),
//               ),
//             ),
//           ),
//           const Divider(
//             color: Colors.grey,
//           ),
//           Align(
//             alignment: Alignment.centerLeft,
//             child: Padding(
//               padding: EdgeInsets.only(left: 1.0, bottom: 10),
//               child: Text(
//                 'Total: ' +  Theorder!.Total + ' SR',
//                 style: TextStyle(
//                   fontFamily: 'PoppinsMedium',
//                   fontStyle: FontStyle.normal,
//                   color: Batatis_Dark,

//                   // fontWeight: FontWeight.w500,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ));
var Subtotal =  double.parse( Theorder!.Total) - double.parse(Theorder!.Restaurantobj.fee );
allWidgets.add( Container(
                //  color: black,
                  height: 250,
                  child:   SingleChildScrollView(child : 
                  Column(
                      children: orderWidgets,
                    )) ,
   ));
allWidgets.add(  Positioned(
                           bottom: 0.0,
                           left: 0.0,
                           right: 0.0,
                           //top: 30,
                          child: Container(
                            width: 400,
                            padding: EdgeInsets.only(
                                top: 20,
                                 left: 30,
                                 right: 30,
                                  bottom: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 6,
                                  blurRadius: 4,
                                  offset: Offset(
                                      6, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 1.0),
                                    child: Text(
                                      'Subtotal: ' +
                                          Subtotal.toString() +
                                          ' SR',
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
                                      'Delivery fee: ' +
                                         Theorder!.Restaurantobj.fee +
                                          ' SR',
                                      style: TextStyle(
                                        fontFamily: 'PoppinsMedium',
                                        fontStyle: FontStyle.normal,
                                        // fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 1.0, bottom: 10),
                                    child: Text(
                                      'Total: ' +  Theorder!.Total + ' SR',
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
                             
                          ]),
                        ),));
    return allWidgets;
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
 //         Column(children: [  Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceAround,
    //             children: [ Icon(
    //                       Icons.restaurant,
    //                       color: Batatis_Dark,
    //                       size: 30.0,
    //                     ),
    //                      Icon(
    //                     Icons.location_on,
    //                     color: Batatis_Dark,
    //                     size: 30.0,
    //                   ),
    //                      Icon(
    //                     Icons.info,
    //                     color: Batatis_Dark,
    //                     size: 30.0,
    //                   ),   Icon(
    //                     Icons.payment,
    //                     color: Batatis_Dark,
    //                     size: 30.0,
    //                   ),
    //                     ],),
    //                   Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                     Text(
    //                       "    ${Theorder!.Restaurantobj.resturantName}" , //CCurrentOrderState.aboutOrderModel.getResturantName,
    //                       style: TextStyle(
    //                           color: grey_Dark,
    //                           fontFamily: 'PoppinsMedium',
    //                           fontSize: 12),
    //                     ),
    //                     SizedBox(width: 10,),
    //                     Container(
    //                     width: 80,
    //                     child: Text(
    //                       Theorder!.Restaurantobj .address ,//CCurrentOrderState.aboutOrderModel.getResturantLoc,
    //                       maxLines: 3,
    //                       overflow: TextOverflow.ellipsis, // new
    //                       style: TextStyle(
    //                           color: grey_Dark,
    //                           fontFamily: 'PoppinsMedium',
    //                           fontSize: 12),textAlign: TextAlign.center ,
    //                     ),),
    //                    SizedBox(width: 10,),
    //                      Column(
    //                     //  mainAxisAlignment: MainAxisAlignment,
    //                     crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   // Icon(
    //                   //   Icons.info,
    //                   //   color: Batatis_Dark,
    //                   //   size: 20.0,
    //                   // ),
    //                   Text(
    //                     "#${Theorder!.orderId}",//"Order Info",
    //                     style: TextStyle(
    //                         color: grey_Dark,
    //                         fontFamily: 'PoppinsMedium',
    //                         fontSize: 12),
    //                   ),
                     
    //                   Text(
    //                   "${ Theorder!.OrderTime.substring(0,10)}" , /// CCurrentOrderState.aboutOrderModel.getOrderDate,
    //                     style: TextStyle(
    //                         color: grey_Dark,
    //                         fontFamily: 'PoppinsMedium',
    //                         fontSize: 12), 
    //                   ),
    //                   Text(
    //                    Theorder!.OrderTime.substring(11,16),
    //                     style: TextStyle(
    //                         color: grey_Dark,
    //                         fontFamily: 'PoppinsMedium',
    //                         fontSize: 12),
    //                   ),
    //                 ],
    //               ),
    //                  Column(
    //                 children: [
                    
    // //                 TextButton(onPressed: (){
    // //                   print("stasrt payment");
    // // //  payment pay = payment();
    // // //   pay.makePayment(SharedPrefer.total);
    // //                 }, child: 
    //                   // Text(
    //                   //   "Payement",
    //                   //   style: TextStyle(
    //                   //       // color: grey_light,
    //                   //       fontFamily: 'PoppinsMedium',
    //                   //      //decoration: TextDecoration.underline,

    //                   //       color: Batatis_Dark,
    //                   //       fontSize: 14),
    //                   // ),
    //                   //),
    //                   Text(
    //                      Theorder!.PaymentMethod != "Paid" ? "Cash on Delievery" : "Paid",// CCurrentOrderState.aboutOrderModel.getPaymentMethod,
    //                     style: TextStyle(
    //                         color: grey_Dark,
    //                         fontFamily: 'PoppinsMedium',
    //                         fontSize: 12),
    //                   ),//
    //                  ( Theorder!.PaymentMethod != "Paid" && SharedPrefer.UserId! == Theorder!.creatorId &&(statusCode == "Preparing" ||statusCode == "Out for Delivery" )) ?
    //                   //&& SummaryPage.orderid == SharedPrefer.CurrentOrderId
    //                   CustomButton(text: "Pay", onPressed: (){
    //                     print(" i think this is the right total ${Theorder!.Total}");
    //                     payment pay = payment();
    //   pay.makePayment(Theorder!.Total , SummaryPage.orderid);} , type: "confirm",width: 80,height: 23,fontSize: 14,)
                      
                      
    //                   :Text(
    //                     '',
    //                     style: TextStyle(
    //                         color: grey_Dark,
    //                         fontFamily: 'PoppinsMedium',
    //                         fontSize: 12),
    //                   ),
    //                   //  if (Theorder!.PaymentMethod == "Paid")  Text(
    //                   //   '',
    //                   //   style: TextStyle(
    //                   //       color: grey_Dark,
    //                   //       fontFamily: 'PoppinsMedium',
    //                   //       fontSize: 12),
    //                   // )
    //                 ],
    //               ),
    

    //                   ],)  
                        
    //                     ],)
   
   