import 'package:batatis/Costomer_Screens/All_Costomer_Screens.dart';
import 'package:batatis/Customer_Widgets/Payment.dart';
import 'package:batatis/moudles/Orders.dart';
import 'package:batatis/provider/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Customer_Widgets/Payment.dart';
import '../Views/Customer_View.dart';
import '../moudles/order_summar_model.dart';
import '/Customer_Widgets/All_customer_Widgets.dart';

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'lastNoti.dart';
import 'package:http/http.dart' as http;

class CCurrentOrder extends StatefulWidget {
  const CCurrentOrder({super.key});

  @override
  State<CCurrentOrder> createState() => CCurrentOrderState();
}


class CCurrentOrderState extends State<CCurrentOrder> {


  NotificationServices notificationServices = NotificationServices();
////////////////////////////////////////////////////////////////////////
  void initState() {
    super.initState();

    SharedPrefer.SetSharedPrefer();
    getlocation();

    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
  
  }
  static AboutOrderModel aboutOrderModel = AboutOrderModel();
  String Rname =
      ""; //ViewMenuToCustomerState.ResturantName.toString();///restaurant name from hind!!!!!!!!!!!!!!!!!!!!
  String Olocation = "";
   String rr = "" ;
String Rtoken="";
String token ="";

  double Dfee = double.parse(ViewMenuToCustomerState.ResturantFee.toString());
  String orderID = SharedPrefer.CurrentOrderId
      .toString(); //should be stored when first created and also stored when joining
  String userID = SharedPrefer.UserId
      .toString(); //"1aScWEtYkThnRLTvCggJihuMkFu1";//should be stored when loged in ??? this is random
  String status = SharedPrefer.status.toString();
      FirebaseFirestore _firestore = FirebaseFirestore.instance;

   Future<void> getlocation() async {
    if (!(SharedPrefer.CurrentOrderId == null ||
        SharedPrefer.CurrentOrderId == "")) {
      var OrdersRef = _firestore
          .collection('Orders')
          .doc(SharedPrefer.CurrentOrderId.toString());
      var getOrders = await OrdersRef.get();
      Olocation = getOrders.get("deleveryLocation");
      print(" RestaurantRef works fine $Olocation ");
      var RestaurantRef = _firestore
          .collection('Restaurants')
          .doc(SharedPrefer.CurrentOrderResturantId.toString());
      print(" RestaurantRef works fine $RestaurantRef ");
      var getRestaurant = await RestaurantRef.get();
      Rname = getRestaurant.get("Resturant Name");
      print("reatname $Rname");
      Dfee = double.parse(getRestaurant.get("Fee"));
      print("rest fee $Dfee");
       aboutOrderModel.setResturantLoc('');


      /////////////////////////sadeem/////////////////
                    rr = getOrders.get("RestaurantID");
                  getRToken();
    }
    setState(() {
       Dfee = Dfee ; 
    });
  }
Future<void> getRToken() async {

  var rRef =await _firestore.collection("Restaurants").doc(rr).get();

       token = rRef.get("Token");
       print("print laptop's token from phone $token");
}

  var ap; //service provider auth with db info
  var _fireStoreInstance = FirebaseFirestore.instance;
  bool? isLoggedIn; //check if the user log in (NOT WORKING)
  bool showB = false;
  bool showA = true;
  bool showC = false;
  bool amInotconfirmed = true;
  bool amInotPlaced = true;
  bool amIcreator = false;
  bool allOrdersConfirmed = true;
  String dateStr = "";
  String timeStr = "";
  bool amIempty=true;//check empty order sadeem


  late bool isCreator; //for memeber

  double subtotal = 0;
  double total = 0;

  Set<DocumentSnapshot> mySet = {};
 
  Future<void> islog() async {
    isLoggedIn = await ap.issignedin;
  }

  Future<void> getOstatus() async {
    var nn = await _fireStoreInstance.collection("Orders").doc(orderID).get();
    if (nn.get("status").toString() == "Preparing") amInotPlaced = false;
  }

  @override
  Widget build(BuildContext context) {
 //   var con = context ; 
    if (SharedPrefer.CurrentOrderId != null) {
      isCreator = SharedPrefer.iscreator!;
      orderID = SharedPrefer.CurrentOrderId
          .toString(); //should be stored when first created and also stored when joining
      userID = SharedPrefer.UserId.toString();
    } else {
      isCreator = true;
      orderID = SharedPrefer.CurrentOrderId
          .toString(); //should be stored when first created and also stored when joining
      userID = SharedPrefer.UserId.toString();
    }

    getOstatus();
    Link.handleDynamicLinks(context);
   // getlocation();
    getRToken();
    ap = Provider.of<AuthProvider>(context, listen: false);
    DateTime today = DateTime.now();
    dateStr = "${today.day}/${today.month}/${today.year}";
    timeStr = "${today.hour}:${today.minute}";
    int numOfMembers = 0;
aboutOrderModel.setOrderDate(dateStr);
aboutOrderModel.setOrderTime(timeStr);
    List<Widget> cards() {
      getOstatus();
      aboutOrderModel
          .setResturantName(ViewMenuToCustomerState.ResturantName.toString());
      aboutOrderModel.setPaymentMethod('cash on delivery');
      total = 0;
      subtotal = 0;
      List<Widget> cc = [];
      List<Widget> oo = [];
      List<dynamic> items = [];
      List<dynamic> quantity = [];
      List<dynamic> prices = [];
      String namea = "";
      bool confirmed = false;
      bool creator = false;
      allOrdersConfirmed = true;
      today = DateTime.now();
      dateStr = "${today.day}/${today.month}/${today.year}";
      timeStr = "${today.hour}:${today.minute}";
      int i = -1;

      mySet = mySet.toSet();

 // sort sadeem Move the item with the specified name to the beginning of the list

  /// Convert the set to a list
  List<DocumentSnapshot> sortedList = mySet.toList();

  // Sort the list based on a specific criterion (e.g., document ID)
  sortedList.sort((a, b) {
if (a.id == userID ) {
return -1; // Move 'Bob' to the beginning
} else if (b.id == userID ) {
return 1;
} else {
return 0;
}
});

  // Convert the sorted list back to a set
 mySet = Set<DocumentSnapshot>.from(sortedList);

//////////////////////////////
      mySet.forEach((itemData) {
        i = i + 1;
        print("forEachssss ${mySet.length}");
        namea = itemData.get('name');
        items = itemData.get('items');
        quantity = itemData.get('quantity');
        prices = itemData.get('prices');

        ////////////sort sadeem
    // Create a list of indices to sort the original list1
  List<int> indices = List.generate(items.length, (index) => index);

// Sort list1 and use the indices to rearrange list2 and list3
  indices.sort((a, b) => items[a].compareTo(items[b]));

  items = indices.map((index) => items[index]).toList();
  quantity = indices.map((index) => quantity[index]).toList();
  prices = indices.map((index) => prices[index]).toList();
//////////////////////////////////////////////////////
        confirmed = itemData.get('confirmed');
        bool allowEdit=false;//sadeem edit

        if (confirmed == false) {
          allOrdersConfirmed = false;
        }
        creator = itemData.get('creator');
        double msubtotal = 0;

//////////////////////////////////

        print(itemData.id);
        if ((userID == itemData.id) && confirmed) {
          amInotconfirmed = false;
          if (creator) amIcreator = true;
        }
        //sadeem edit
   if ((userID == itemData.id) && !confirmed) {
            allowEdit=true;
            //check empty order sadeem
            if(items.isEmpty) {
              amIempty=true;
            } else {
              amIempty=false;
            }
        }
//////////////////////////////

        int j = -1;
        List<Widget> UserOrder() {
          List<Widget> ItemsDetails = [];
          items.forEach((itemData) {
            j = j + 1;
            print(prices);

            int quan =quantity[j];//sadeem edit

            double w = prices[j] * quantity[j].toDouble();
            msubtotal = msubtotal + w;

//sadeem edit

             void incrementQuantity() {
                                    setState(()async {
                                      print("inc q");
                                      if (quan < 100) {
                                        // Check if quantity is less than 100 before incrementing
                                        quan++;
                                      //  priceChanded = rprice * quantity;
                                      
                                        print(quan);
                                        await Orders.addMemberItemsSad(
                                              SharedPrefer.CurrentOrderId,
                                              SharedPrefer.UserId.toString(),
                                              itemData,
                                          
                                              );
                                      }
                                    });

                                    
                                  }

                                  void decrementQuantity() {
                                    setState(() async {
                                      if (quan > 1) {
                                        print("dec q");

                                        quan--;
                                        print(quan);
// ViewMenuToCustomerState.setstate((){
//  ViewMenuToCustomerState _newOAmount
//                                          SharedPrefer.SetNumOfOrders( SharedPrefer.numOfOrders! - 1); });
                                        
                                         await Orders.decMemberItemssad(
                                              SharedPrefer.CurrentOrderId,
                                              SharedPrefer.UserId.toString(),
                                              itemData,
                                             
                                              );
                                         
                                      }

                                     else if (quan == 1) {
                                        print("delete q");

                                        await Orders.deleteMemberItemssad(
                                              SharedPrefer.CurrentOrderId,
                                              SharedPrefer.UserId.toString(),
                                              itemData,
                                              
                                              );
                                      }  
                                    });
                                  }

            ItemsDetails.add(
              Container(
                margin: EdgeInsets.all(0),
                width: 370,
                child: Padding(
                    padding:
                        EdgeInsets.only(left: 8, right: 8, bottom: 8, top: 8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              text: 'x' + quantity[j].toString(),
                              type: "paragraph"),
                           SizedBox(width: 20), // give it width
                          Spacer(),

                          CustomText(text: items[j], type: "paragraph"),
                          // SizedBox(width: 40), // give it width
                          Spacer(),

                          CustomText(
                              text: w.toString() + ' SR', type: "paragraph"),
                          // Divider(
                          //                 color: Colors.grey,
                          //               ),
                          /////// check if its the user and show it only to him
                          /////sadeem edit
                          allowEdit?
                          SizedBox(width: 30):Container(),

                          allowEdit?

                          Container(
                                            width:
                                                70, // Adjust the width as needed
                                            padding: EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Batatis_Dark,
                                                  width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: decrementQuantity,
                                                  child: Container(
                                                    width: 18,
                                                    height: 18,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Batatis_Dark,
                                                    ),
                                                    child: Center(
                                                      child: 
                                                      quan == 1?
                                                    Icon(
                                                        Icons.delete,
                                                        color: Colors.white,
                                                        size: 14,
                                                      ):
                                                      Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                        size: 14,

                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 7.0),
                                                Text('$quan'),
                                                SizedBox(width: 7.0),
                                                InkWell(
                                                  onTap: incrementQuantity,
                                                  child: Container(
                                                    width: 18,
                                                    height: 18,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Batatis_Dark,
                                                    ),
                                                    child: Center(
                                                      child: 
                                                      Icon(
                                                        Icons.add,
                                                        color: Colors.white,
                                                        size: 14,

                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ):Container()
                        ])),
              ),
            );
          });
          subtotal = subtotal + msubtotal;
          _fireStoreInstance
              .collection("Orders")
              .doc(orderID)
              .collection("Member")
              .doc(itemData.id)
              .update({'subtotal': msubtotal});

          return ItemsDetails;
        }

        print("oo count ${oo.length}");
        cc.add(
          Container(
              child: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  color: Batatis_light.withOpacity(0.7),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //SizedBox(width:0.5)  ,

                        Text(
                          namea,
                          style: TextStyle(
                              fontFamily: 'PoppinsMedium', fontSize: 16),
                        ),
                        confirmed
                            ? Text(
                                "confirmed",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: 'PoppinsMedium',
                                    fontSize: 12),
                              )
                            : Text(
                                " not confirmed",
                                style: TextStyle(
                                    fontFamily: 'PoppinsMedium',
                                    color: red,
                                    fontSize: 12),
                              ),
                        // SizedBox(width:2)  ,
                        //CustomText(text: namea,type: "Subheading1B"),
                        //confirmed? CustomText(text:"confirmed",type: "Subheading1B"):CustomText(text:" not confirmed",type: "Subheading1B"),
                      ])),
              Column(children: UserOrder()),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 1.0),
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
              ),
            ],
          )
              //  width: 200,/////6.4 inch
              //  height: 230,//////
              //  padding: const EdgeInsets.all(8),
              //  margin:const EdgeInsets.all(10),

              ),
        );

        oo.clear();
      });

      total = subtotal + Dfee;
      mySet.clear();

      return cc;
    }

    var actions = [
      SharedPrefer.iscreator!
          ? IconButton(
              onPressed: () {
                if (SharedPrefer.status == "ongoing"){
                  showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                title :"confirmation",
                  text: "are you sure u want to cancel your order.",
                 onPressed: null ,
                 type: 'custom',
                  action :  <Widget>[
                                                  
                                                  TextButton(
                                                    onPressed: () {
                                                       Navigator.pop(
                                                    context,
                                                   
                                                  );
                                                    },
                                                    child: Text('NO'),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      if (SharedPrefer
                                                              .CurrentOrderId !=
                                                          null) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "Orders")
                                                            .doc(SharedPrefer
                                                                .CurrentOrderId)
                                                            .delete();
                                                        SharedPrefer
                                                            .DeleteCurrentOrder();
                                                      } // Close the dialog
                                                       Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                         CHomePage(),
                                                    ),
                                                  );
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                    primary:
                                        Batatis_Dark, // Change the button's background color here
                                  ),  child: const Text('cancel order',
                                    style: TextStyle(
                                      color: Colors
                                          .white, // Set the text color to white
                                    ),), 
                                                  
                                                  ),
                                                ],
            
                );
              });}else {
 showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                title :"Sorry",
                  text: "you already submitted the order you can't cancel it   ",
                 onPressed: null ,
                 type: 'reject',
                  action :  <Widget>[
                                                  
                                                  TextButton(
                                                    onPressed: () {
                                                       Navigator.pop(
                                                    context,
                                                   
                                                  );
                                                    },
                                                    child: Text('Ok'),
                                                  ),
                                                 
                                                ],
            
                );
              });

              }},
              icon: Icon(Icons.cancel))
          : IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.cancel,
                size: 1,
              )),
    ];
    return Scaffold(
      appBar: CustomAppBar(wantback: true, actions: actions),
      body: FutureBuilder(
          future: Future.wait([islog(), checkStatus(context)]),
          builder: (BuildContext context, AsyncSnapshot<void> futureSnapshot) {
            if (futureSnapshot.connectionState == ConnectionState.waiting) {
              // If the Future is still running, return a loading indicator or some other widget.
              return CircularProgressIndicator();
            } else if (futureSnapshot.hasError) {
              // If the Future encountered an error, display an error message.
            //  if(futureSnapshot.error == "Error: Bad state: cannot get a field on a DocumentSnapshotPlatform which does not exist"){print("canclled") ; }
              //   print("futiuer problem "); 
              //  canceldilog = true ; 
              //  print("futiuer problem$canceldilog "); 
              //   Navigator.pop(context); 

             // showCancledDialog(context); 
              return Text('Error: ${futureSnapshot.error}');
            } else {
              if (isLoggedIn!) {
                print("logedin good");
                //if(!(SharedPrefer.CurrentOrderId == null || SharedPrefer.CurrentOrderId == "") ){
                //If the Future completed successfully, you can start listening to a Stream.
                print("pteto here $orderID");
                return StreamBuilder(
                    stream: _fireStoreInstance
                        .collection("Orders")
                        .doc(orderID)
                        .collection("Member")
                        .orderBy('name')
                        .snapshots(),
                    builder: (BuildContext context, snapshot) {
                      print("snapsho");
                      var  con = context;
                      checkStatus(context);
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // While data is loading, show a loading indicator.
                        print("wait");
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                         print("stream problem "); 
                        // If an error occurs, display an error message.
                        return Text('no data' /*'Error: ${snapshot.error}'*/);
                      } else if (snapshot.hasData!) {
                        print("yes");

                        QuerySnapshot querySnapshot = snapshot.data!;
                        if (querySnapshot != null) {
                          print("querySnapshot not null ${mySet.length}");
                          mySet.clear();
                          print("before gooo ${querySnapshot.docs.length}");
                          querySnapshot.docs
                              .forEach((DocumentSnapshot doc) async {
                            print("gooo");
                            mySet.add(doc);
                            numOfMembers = numOfMembers + 1;
                                                        if (numOfMembers > 1) {
                              aboutOrderModel.setOrderType('Group order');
                            } else {
                              aboutOrderModel.setOrderType('Single order');
                            }

//                         names.add( await _fireStoreInstance
//     .collection('Customers')
//     .doc(doc.id)
//     .get()
//     .then((snapshot) {
//         if (snapshot.exists) {
//             var user = snapshot.get('name');
//             print("heelo")       ;
//             return user ;
//  }
//  print("noooo");
//  return 'no user';

//  })
//  );
                          });
                        }
                        // }return Text("no orders");
                      }

                      return Stack(clipBehavior: Clip.none, children: <Widget>[
                        Positioned(
                            //s bottom:10.0,
                            left: 0.0,
                            right: 0.0,
                            top: 10,
                            child: SingleChildScrollView(
                                //child:SingleChildScrollView(
                                //  scrollDirection: Axis.vertical,

                                child: Container(
                              height:
                                  520, ////////was 480///////////////////////////////
                              // SingleChildScrollView(tion: Axis.vertical,
                              //scrollDirec
                              // child:
                              // SingleChildScrollView(
                              //  child: Container(
                              //                   height: 500,

                              // child:

                              child: Scrollbar(
                                thickness: 10,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 13, right: 13, top: 0),
                                    child: Container(
                                      //  height: 500,

                                      child: Column(
                                        children: [
                                          Container(
                                            width: 370,
                                            padding: EdgeInsets.only(
                                              bottom: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 2,
                                                  blurRadius: 3,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Center(
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                      Text(
                                                        "Note: the order can only be placed after the confirmation of the included orders. ",
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'PoppinsMedium',
                                                          fontStyle:
                                                              FontStyle.normal,
                                                          // fontWeight: FontWeight.w500,
                                                          fontSize: 12,
                                                          color: red,
                                                        ),
                                                        //  overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ])),
                                              ),
                                            ),
                                          ),

                                          Container(
                                              width: 370,
                                              margin: EdgeInsets.only(
                                                top: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                    spreadRadius: 2,
                                                    blurRadius: 3,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Container(
                                                      child: Center(
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  left: 8,
                                                                  right: 8),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'About the order',
                                                                style: TextStyle(
                                                                    color:
                                                                        Batatis_Dark,
                                                                    fontFamily:
                                                                        'PoppinsMedium',
                                                                    fontSize:
                                                                        20),
                                                              ),
                                                              showC
                                                                  ? GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        print(
                                                                            'false');
                                                                        setState(
                                                                            () {
                                                                          showC =
                                                                              false;
                                                                        });
                                                                      },
                                                                      child: Icon(
                                                                          Icons
                                                                              .keyboard_arrow_up_outlined))
                                                                  : GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        print(
                                                                            'true');
                                                                        setState(
                                                                            () {
                                                                          showC =
                                                                              true;
                                                                        });
                                                                      },
                                                                      child: Icon(
                                                                          Icons
                                                                              .keyboard_arrow_down_outlined))
                                                            ],
                                                          ),
                                                        ),
                                                        showC
                                                            ? Column(children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              8),
                                                                  child:
                                                                      Container(
                                                                    //  width: Width * 0.9,
                                                                    child:
                                                                        Divider(
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                ),

                                                                // Padding(
                                                                //   padding: const EdgeInsets.only(
                                                                //       left: 8, right: 8, bottom: 8, top: 2),
                                                                //child:

                                                                SingleChildScrollView(
                                                                    child:
                                                                        Container(
                                                                  height: 110,
                                                                  //             child:
                                                                  //              SingleChildScrollView(
                                                                  // child:

                                                                  //             Container(
                                                                  //               height: 180,

                                                                  // child:
                                                                  //            SingleChildScrollView(
                                                                  // child:
                                                                  //             Container(
                                                                  //              // height: 240,

                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        left: 8,
                                                                        right:
                                                                            8,
                                                                        top: 7),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        // SizedBox(
                                                                        //       width: 50, //<-- SEE HERE
                                                                        //     ),

                                                                        Container(
                                                                          width:
                                                                              60,
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Icon(
                                                                                Icons.restaurant,
                                                                                color: Batatis_Dark,
                                                                                size: 20.0,
                                                                              ),

                                                                              //  Text(
                                                                              //         "Restaurant",
                                                                              //         style: TextStyle(
                                                                              //            // color: grey_light,
                                                                              //             fontFamily: 'PoppinsMedium',
                                                                              //                   color: Batatis_Dark,
                                                                              //             fontSize: 14),
                                                                              //       ),

                                                                              Text(
                                                                                Rname,
                                                                                style: TextStyle(color: grey_Dark, fontFamily: 'PoppinsMedium', fontSize: 12),
                                                                              ),
                                                                              //    Text(
                                                                              //                 "",
                                                                              //                 style: TextStyle(
                                                                              //                     fontSize: 12),
                                                                              //               ),

                                                                              // Text(
                                                                              //                 "",
                                                                              //                 style: TextStyle(
                                                                              //                     fontSize: 12),
                                                                              //               ),
                                                                            ],
                                                                          ),
                                                                        ),

                                                                        // SizedBox(
                                                                        //       width: 90, //<-- SEE HERE
                                                                        //     ),
                                                                        Column(
                                                                          children: [
                                                                            Icon(
                                                                              Icons.location_on,
                                                                              color: Batatis_Dark,
                                                                              size: 20.0,
                                                                            ),

                                                                            //  Text(
                                                                            //         "Location",
                                                                            //         style: TextStyle(
                                                                            //            // color: grey_light,
                                                                            //             fontFamily: 'PoppinsMedium',
                                                                            //                   color: Batatis_Dark,
                                                                            //             fontSize: 14),
                                                                            //       ),
                                                                            Container(
                                                                              width: 80,
                                                                              child: Text(
                                                                                Olocation,
                                                                                // "ggggggggggggggggggggggggggggggggggggggggggggg",
                                                                                maxLines: 3,
                                                                                overflow: TextOverflow.ellipsis, // new
                                                                                style: TextStyle(color: grey_Dark, fontFamily: 'PoppinsMedium', fontSize: 12),
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
                                                                            //  Text(
                                                                            //                 "Order Info",
                                                                            //                 style: TextStyle(
                                                                            //                    // color: grey_light,
                                                                            //                     fontFamily: 'PoppinsMedium',
                                                                            //                           color: Batatis_Dark,
                                                                            //                     fontSize: 14),
                                                                            //               ),
 Text(
                                                                              "#${orderID.substring(0,5)}",
                                                                              style: TextStyle(color: grey_Dark, fontFamily: 'PoppinsMedium', fontSize: 12),
                                                                            ),
                                                                            numOfMembers > 1
                                                                                ? Text(
                                                                                    'Group order',
                                                                                    style: TextStyle(color: grey_Dark, fontFamily: 'PoppinsMedium', fontSize: 12),
                                                                                  )
                                                                                : Text(
                                                                                    'single order',
                                                                                    style: TextStyle(color: grey_Dark, fontFamily: 'PoppinsMedium', fontSize: 12),
                                                                                  ),
                                                                           
                                                                            Text(
                                                                              dateStr,
                                                                              style: TextStyle(color: grey_Dark, fontFamily: 'PoppinsMedium', fontSize: 12),
                                                                            ),
                                                                            Text(
                                                                              timeStr,
                                                                              style: TextStyle(color: grey_Dark, fontFamily: 'PoppinsMedium', fontSize: 12),
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

                                                                            //  Text(
                                                                            //         "Payement",
                                                                            //         style: TextStyle(
                                                                            //            // color: grey_light,
                                                                            //             fontFamily: 'PoppinsMedium',
                                                                            //                   color: Batatis_Dark,
                                                                            //             fontSize: 14),
                                                                            //       ),

                                                                            Text(
                                                                              'Online Payment',
                                                                              style: TextStyle(color: grey_Dark, fontFamily: 'PoppinsMedium', fontSize: 12),
                                                                            ),

                                                                            //  Text(
                                                                            //                   '',
                                                                            //                   style: TextStyle(
                                                                            //                       color: grey_Dark,
                                                                            //                       fontFamily: 'PoppinsMedium',
                                                                            //                       fontSize: 12),
                                                                            //                 ),

                                                                            //            Text(
                                                                            //                   '',
                                                                            //                   style: TextStyle(
                                                                            //                       color: grey_Dark,
                                                                            //                       fontFamily: 'PoppinsMedium',
                                                                            //                       fontSize: 12),
                                                                            //                 ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )
                                                                    //))))
                                                                    )
                                                              ])
                                                            : Container()
                                                      ]))))),

                                          // SizedBox(
                                          //       height: 10, //<-- SEE HERE
                                          //     ),

                                          Container(
                                            width: 370,
                                            margin: EdgeInsets.only(
                                              top: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 2,
                                                  blurRadius: 3,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Center(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Members',
                                                              style: TextStyle(
                                                                  color:
                                                                      Batatis_Dark,
                                                                  fontFamily:
                                                                      'PoppinsMedium',
                                                                  fontSize: 20),
                                                            ),
                                                            showB
                                                                ? GestureDetector(
                                                                    onTap: () {
                                                                      print(
                                                                          'false');
                                                                      setState(
                                                                          () {
                                                                        showB =
                                                                            false;
                                                                      });
                                                                    },
                                                                    child: Icon(
                                                                        Icons
                                                                            .keyboard_arrow_up_outlined))
                                                                : GestureDetector(
                                                                    onTap: () {
                                                                      print(
                                                                          'true');
                                                                      setState(
                                                                          () {
                                                                        showB =
                                                                            true;
                                                                      });
                                                                    },
                                                                    child: Icon(
                                                                        Icons
                                                                            .keyboard_arrow_down_outlined))
                                                          ],
                                                        ),
                                                      ),
                                                      showB
                                                          ? Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              8),
                                                                  child:
                                                                      Container(
                                                                    //  width: Width * 0.9,
                                                                    child:
                                                                        Divider(
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                ),

                                                                // Padding(
                                                                //   padding: const EdgeInsets.only(
                                                                //       left: 8, right: 8, bottom: 8, top: 2),
                                                                //child:

                                                                SingleChildScrollView(
                                                                    child: Container(
                                                                        height: 180,
                                                                        child: Scrollbar(
                                                                          thumbVisibility:
                                                                              true,
                                                                          child: SingleChildScrollView(
                                                                              child: Container(
                                                                            height:
                                                                                180,
                                                                            child:
                                                                                SingleChildScrollView(
                                                                              child: Container(
                                                                                // height: 240,

                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    StreamBuilder(
                                                                                      stream: FirebaseFirestore.instance.collection('Orders').doc(orderID).collection("Member").orderBy('name').snapshots(),
                                                                                      builder: (context, snapshot) {
                                                                                        if (!snapshot.hasData) {
                                                                                          return CircularProgressIndicator();
                                                                                        }

                                                                                        final members = snapshot.data!.docs;

                                                                                          // sort sadeem Move the item with the specified name to the beginning of the list
                                                                                          members.sort((a, b) {
                                                                                            if (a.data()['creator'] == true ) {
                                                                                              return -1; // Move 'Bob' to the beginning
                                                                                            } else if (b.data()['creator'] == true ) {
                                                                                              return 1;
                                                                                            } else {
                                                                                              return 0;//a.data()['creator'] .compareTo(b.data()['creator'] );
                                                                                            }
                                                                                          });
                                                                                          //////////////////////////////
                                                                                        print("isCreator $isCreator");
                                                                                        return isCreator
                                                                                            ? Column(
                                                                                                children: members.map((memberDoc) {
                                                                                                  final memberData = memberDoc.data();
                                                                                                  final isCre = memberData['creator'] == true;

                                                                                                  return ListTile(
                                                                                                      leading: Icon(
                                                                                                        Icons.account_circle,
                                                                                                        color: Batatis_Dark,
                                                                                                      ),
                                                                                                      title: Row(
                                                                                                        children: [
                                                                                                          Text(memberData['name']), (isCre) ? Text(' (Host)') : Text(""),
                                                                                                          //if (isCre) Text(' (Host)'), // Display "Host" for creator
                                                                                                        ],
                                                                                                      ),
                                                                                                      trailing: !isCre
                                                                                                          ? GestureDetector(
                                                                                                              onTap: () {
                                                                                                                // Show confirmation dialog with member name
                                                                                                                showDeleteConfirmationDialog(context, memberDoc.id, memberData['name']);
                                                                                                              },
                                                                                                              child: Icon(
                                                                                                                Icons.close,
                                                                                                                color: Batatis_Dark,
                                                                                                              ),
                                                                                                            )
                                                                                                          : null);
                                                                                                }).toList(),
                                                                                              )
                                                                                            : Column(
                                                                                                children: members.map((memberDoc) {
                                                                                                  final memberData = memberDoc.data();
                                                                                                  final isCre = memberData['creator'] == true;
                                                                                                  return ListTile(
                                                                                                    leading: Icon(
                                                                                                      Icons.account_circle,
                                                                                                      color: Batatis_Dark,
                                                                                                    ),
                                                                                                    title: Row(
                                                                                                      children: [
                                                                                                        Text(memberData['name']), (isCre) ? Text(' (Host)') : Text(""),
                                                                                                        //if (isCre) Text(' (Host)'), // Display "Host" for creator
                                                                                                      ],
                                                                                                    ),
                                                                                                  );
                                                                                                }).toList(),
                                                                                              );
                                                                                      },
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )),
                                                                        )))
                                                              ],
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //             SingleChildScrollView(
                                          //                     scrollDirection: Axis.vertical,
                                          // child:
                                          Container(
                                            width: 370,
                                            margin: EdgeInsets.only(
                                              top: 10,
                                              bottom: 40,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 2,
                                                  blurRadius: 3,
                                                  offset: Offset(0,
                                                      3), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                child: Center(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8,
                                                                right: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              'Orders',
                                                              style: TextStyle(
                                                                  color:
                                                                      Batatis_Dark,
                                                                  fontFamily:
                                                                      'PoppinsMedium',
                                                                  fontSize: 20),
                                                            ),
                                                            showA
                                                                ? GestureDetector(
                                                                    onTap: () {
                                                                      print(
                                                                          'false');
                                                                      setState(
                                                                          () {
                                                                        showA =
                                                                            false;
                                                                      });
                                                                    },
                                                                    child: Icon(
                                                                        Icons
                                                                            .keyboard_arrow_up_outlined))
                                                                : GestureDetector(
                                                                    onTap: () {
                                                                      print(
                                                                          'true');
                                                                      setState(
                                                                          () {
                                                                        showA =
                                                                            true;
                                                                      });
                                                                    },
                                                                    child: Icon(
                                                                        Icons
                                                                            .keyboard_arrow_down_outlined))
                                                          ],
                                                        ),
                                                      ),
                                                      showA
                                                          ? Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          top:
                                                                              8),
                                                                  child:
                                                                      Container(
                                                                    //  width: Width * 0.9,
                                                                    child:
                                                                        Divider(
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                ),
                                                                // Padding(
                                                                //   padding: const EdgeInsets.only(
                                                                //       left: 8, right: 8, bottom: 8, top: 2),
                                                                //child:
                                                                SingleChildScrollView(
                                                                  child: Container(
                                                                      height: 180,
                                                                      child: SingleChildScrollView(
                                                                          child: Container(
                                                                              height: 180,
                                                                              child: Scrollbar(
                                                                                thumbVisibility: true,
                                                                                child: SingleChildScrollView(
                                                                                  child: Container(
                                                                                      // height: 240,

                                                                                      child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: cards(),
                                                                                  )

                                                                                      //  [] ,
                                                                                      //)
                                                                                      //   )
                                                                                      ),
                                                                                ),
                                                                              )))),
                                                                )
                                                                //  )
                                                              ],
                                                            )
                                                          : Container()
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          //),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                                //),
                                )),
                        Positioned(
                          bottom: 5.0,
                          left: 0.0,
                          right: 0.0,
                          // top: 30,
                          child: Container(
                            width: 370,
                            padding: EdgeInsets.only(
                                top: 20, left: 30, right: 30, bottom: 5),
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
                                          subtotal.toString() +
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
                                          Dfee.toString() +
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
                                amInotconfirmed
                                    ? CustomButton(
                                        text: "confirm",
                                        /*width:20,*/ onPressed: () {
                                          showDialog<String>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                amIempty? AlertDialog(
                                              title:
                                                  const Text('Empty order'),
                                              content: const Text(
                                                  'you can not confirm an empty order please add Item!'),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                    context,
                                                  ),
                                                    style: ElevatedButton.styleFrom(
                                    primary:
                                        Batatis_Dark, // Change the button's background color here
                                  ),
                                                  child: Text(
                                                    'OK',
                                                    style: TextStyle(
                                      color: Colors
                                          .white, // Set the text color to white
                                    ),
                                                    
                                                  ),
                                                ),
                                              ],
                                            ):AlertDialog(
                                              title:
                                                  const Text('Confirm orders'),
                                              content: const Text(
                                                  'Are you sure you want to confirm your orders'),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(
                                                    context,
                                                  ),
                                                  child: Text(
                                                    'cancel',
                                                    style: TextStyle(
                                                      color: Batatis_Dark,
                                                    ),
                                                  ),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () => {
                                                    _fireStoreInstance
                                                        .collection("Orders")
                                                        .doc(orderID)
                                                        .collection("Member")
                                                        .doc(userID)
                                                        .update({
                                                      'confirmed': true
                                                    }),

                                                    print("confiiiirmmmmmmm"),
                                                    Navigator.pop(
                                                      context,
                                                    ),
                                                    // reload(),
                                                  },
                                                       style: ElevatedButton.styleFrom(
                                    primary:
                                        Batatis_Dark, // Change the button's background color here
                                  ),
                                                  child: Text(
                                                    'confirm',
                                                     style: TextStyle(
                                      color: Colors
                                          .white, // Set the text color to white
                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        type: 'confirm',
                                        // height: 0.03,
                                        // width: 0.07,
                                      )
                                    : amIcreator
                                        ? amInotPlaced
                                            ? CustomButton(
                                                text: "Place order",
                                                /*width:20,*/ onPressed: () {
                                                    print("pppppppppppppppppp");

                                                  if (!allOrdersConfirmed) {
                                                        print("All the orders must be confirmed first");
                                                  showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                        title: const Text(
                                                            'Can not place the order'),
                                                        content: const Text(
                                                            'all the orders must be confirmed first'),
                                                        actions: <Widget>[
                                                         
                                                          
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
                                    ),),                                                ),]
                                    
                                                            ),
                                                          );
                                                  } else {
                                                    print("place orderrr");
                                                    showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          AlertDialog(
                                                        title: const Text(
                                                            'Confirm placing the order'),
                                                        content: const Text(
                                                            'Are you sure you want to place your order'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                              context,
                                                            ),
                                                            child: Text(
                                                              'cancel',
                                                              style: TextStyle(
                                                                color:
                                                                    Batatis_Dark,
                                                              ),
                                                            ),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                                  print("place orderrr2222");

   print(" ottttallll stringg g${total.toString()}");
SharedPrefer.Settotal(double.parse(total.toString()));
///void setnoti(){
  // FirebaseFirestore.instance.collection("Restaurants").doc(SharedPrefer.CurrentOrderResturantId).update({
  //   "noti" : true 
  // });
 await  FirebaseFirestore.instance.collection("Restaurants").doc(SharedPrefer.CurrentOrderResturantId).set(
  {'noti': true},
  SetOptions(merge: true),
);

//}
if (!(token == "None")){
            var data = {
              'to' :token,
              'notification' : {
                'title' : 'new order' ,
                'body' : 'a new order is here! please check it' ,
            },
              'android': {
                'notification': {
                  'notification_count': 23,
                },
              },
              'data' : {
                'type' : 'msj' ,
                'id' : 'sadeem'
              }
            };

            await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
            body: jsonEncode(data) ,
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization' : 'key=AAAAUqI5GM4:APA91bH3bpkC5icX3sgdIjtGj-cbO6wgQBbvZW5nE-N-GBv5OqjCNYqhvvEL6bZYvs6dNtMJFmibFXe2mOF7FLz7P71ddZyuIIZFysr9-qqPp0q8hoZAnXC2t8j6ARltVRHTPnk3szMz'
              }
            ).then((value){
              if (kDebugMode) {
                print(value.body.toString());
              }
            }).onError((error, stackTrace){
              if (kDebugMode) {
                print(error);
              }
            });}
//  //////////////////////////////////////////////////////////////////////////
                                                              print(
                                                                  "waiting page");
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          WaitingPage(),
                                                                ),
                                                              );

//CurrentOrderId
                                                              _fireStoreInstance
                                                                  .collection(
                                                                      "Orders")
                                                                  .doc(orderID)
                                                                  .update({
                                                                'Total': total,
                                                                'status':
                                                                    "waiting"
                                                              });
                                                              SharedPrefer
                                                                  .SetStatus(
                                                                      orderID,
                                                                      "waiting");


                                                            },
style: ElevatedButton.styleFrom(
                                    primary:
                                        Batatis_Dark, // Change the button's background color here
                                  ),
                                                            child: Text(
                                                              'confirm',
                                                               style: TextStyle(
                                      color: Colors
                                          .white, // Set the text color to white
                                    ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  }
                                                  ;
                                                },
                                                type: 'confirm',
                                                // height: 0.03,
                                                // width: 0.07,
                                              )
                                            : Container()
                                        : Container(),
                              ],
                            ),
                          ),
                        ),
                      ]);
//
//
                    });
                //  }else{
                //   print("cart thers no order yet ");
                //    return Text(" Please start order to view your cart");
                //  }
              } else {
                print("cart not logedin");
                return Text(" Please log in to view your cart");
              }
            }
          }),
    );
  }
  Future<void> checkStatus(c)async {
    print("checkStatus");
    var StatusRef ;
 try{  
  StatusRef = await _fireStoreInstance.collection("Orders").doc(orderID).get();
 var Status = StatusRef.get("status"); 
     print("checkStatus2 ${Status}");
  if(Status != "ongoing"){
            SummaryPage.orderid = orederid ; 
              Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SummaryPage(),
            ),
          );
             SharedPrefer.DeleteCurrentOrder();
  }}
 catch(e){
   print("badstatseeee");
   if(SharedPrefer.CurrentOrderId == orderID )
      {showCancledDialog(c); 
  return ;}
// if(e=="[ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: Bad state: cannot get a field on a DocumentSnapshotPlatform which does not exist"){
//   print("badstatseeee");
// }
 }
  
  }
  void showDeleteConfirmationDialog(
      BuildContext context, String memberId, String memberName) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Confirm remove memebr'),
          content: Text('Are you sure you want to remove $memberName?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the confirmation dialog
                Navigator.of(dialogContext).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Close the confirmation dialog
                Navigator.of(dialogContext).pop();
                // Call the removeMember method to delete the member
                removeMember(memberId);
              },
              child: Text('Remove', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  removeMember(String memberId) {
    FirebaseFirestore.instance
        .collection('Orders')
        .doc(orderID)
        .collection("Member")
        .doc(memberId)
        .delete();
  }


  void showCancledDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Sorry'),
          content: Text('The order has bees canceled by the creator '),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the confirmation dialog
              SharedPrefer.DeleteCurrentOrder();
              Navigator.pop(context);
                Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CHomePage(),
            ),
          );
          
             
              },
              child: Text('Ok'),
            ),
           
          ],
        );
      },
    );
  }

 
} //class
