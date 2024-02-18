import 'dart:async';
import 'package:batatis/Customer_Widgets/Link.dart';
import 'package:batatis/Customer_Widgets/OrderCard.dart';
import 'package:batatis/moudles/Orders.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/Customer_Widgets/All_customer_Widgets.dart';
import 'RecievePage.dart';

class COrder extends StatefulWidget {
  const COrder({super.key});

  @override
  State<COrder> createState() => COrderState();
}



class COrderState extends State<COrder> {
  static CollectionReference OrdersCollection =
      FirebaseFirestore.instance.collection('Orders');

  late Widget SecondBody = Center(child: CircularProgressIndicator() //Image.asset('assets/Images/Waitingpotato.gif'),
  );
List<OrderCard> listOrderCards = [];
int count = 0;
List<String> orderIDs = [];
List<String> AllexsitingorderIDs = [];
  Map<String, Widget> listOfRestaurantImages = {};

  @override
  void initState() {
    super.initState();
    print("in initiat");
    startCount();
    SharedPrefer.SetSharedPrefer();
    fetchOrdersIDs();
  }

  void startCount() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      count += 5;
       print("timer orders $count");
      if (count >= 90) {
        setState(() {
          //update the page every 100 sec
          fetchOrdersIDs();
          print("timerrr orders reloading $count");
          count = 0; // await Reset the count after 10 seconds.
        });
      }
    });
  }

  Future<void> fetchOrdersIDs() async {
    String userID = SharedPrefer.UserId.toString();
    print("here in fetch");

    orderIDs = await getOrderIDsForCustomer(userID);
    if (orderIDs.isNotEmpty) {
      listOrderCards =
          await GenrateResturansCards(); // Await the cards to be generated
    } else {
      setState(() {
        SecondBody = Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "You don't have any order yet.",
            style: TextStyle(fontSize: 15),
          ),
        ]));
      });
    }

    setState(() {});
    count = 15;
  }

  @override
  Widget build(BuildContext context) {
    Link.handleDynamicLinks(context);
    print("list of orders in orders ${listOrderCards.length}");

    
  return Scaffold(
    appBar: CustomAppBar(
   
    ),
    body: (listOrderCards.isNotEmpty)?
RefreshIndicator(
        onRefresh: fetchOrdersIDs,
        child:
   SingleChildScrollView(
    physics: AlwaysScrollableScrollPhysics(),
  child: Column(
    children:<Widget>[
     Center(
                  child: Container(
                  margin: EdgeInsets.all(10), 
                  child: Text(
                    "My Orders",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ),

    Column(
      children: listOrderCards,
    ),
    ]
  ),
)
)
: Center(
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                  margin: EdgeInsets.all(10), 
                  child: Text(
                    "My Orders",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ),
                Expanded(
                      child: SecondBody,
                    ),  
              ],
            ),
          ),
  );
  }

  Future<List<OrderCard>> GenrateResturansCards() async {
    List<OrderCard> orderCards = [];
    for (String orderID in orderIDs) {
      DocumentSnapshot orderSnapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .doc(orderID)
          .get();

      if (orderSnapshot.exists) {
        var orderTotal =
            (orderSnapshot.data() as Map<String, dynamic>)['Total'];
        String orderTotalString = orderTotal.toString();

        String restaurantID =
            (orderSnapshot.data() as Map<String, dynamic>)['RestaurantID'];
        String orderStatus =
            (orderSnapshot.data() as Map<String, dynamic>)['status'] ?? "null";
        String orderdate =
            (orderSnapshot.data() as Map<String, dynamic>)['OrderTime'] ??
                "null";
      
        List<String> dateTimeParts = orderdate.split(' ');
        String orderdateModifed = dateTimeParts[0];

        if (restaurantID != null) {
          DocumentSnapshot restaurantSnapshot = await FirebaseFirestore.instance
              .collection('Restaurants')
              .doc(restaurantID)
              .get();

          if (restaurantSnapshot.exists) {
            String restaurantName = (restaurantSnapshot.data()
                as Map<String, dynamic>)['Resturant Name'];

            if (restaurantName != null) {
              await loadResturantsImages(restaurantID);
              orderCards.add(
                OrderCard(
                    OrderID: orderID,
                    RestaurantId: restaurantSnapshot.id,
                    name: restaurantName,
                    total: orderTotalString,
                    status: orderStatus,
                    orderDate: orderdateModifed,
                    img: listOfRestaurantImages[restaurantID]),
              );
            }
          }
        }
      }
    }
    // Sort orderCards by the order date
 orderCards.sort((a, b) {
     DateTime dateA = DateTime.parse(a.orderDate!);
    DateTime dateB = DateTime.parse(b.orderDate.toString());
    return dateA.compareTo(dateB);
  });

  return orderCards.reversed.toList();
}
  

  Future<List<String>> getOrderIDsForCustomer(String customerId) async {
    List<String> orderIds = orderIDs; //[];

    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      QuerySnapshot ordersSnapshot = await OrdersCollection
      . where("status",isNotEqualTo : "waiting")
      .get();
      print("orderIds $orderIds");
      print("orderIDs $AllexsitingorderIDs");
      for (QueryDocumentSnapshot orderDoc in ordersSnapshot.docs) {
        // Check if there is a document in the "Member" collection with the same name as the customer ID
        print(orderDoc.id);
        print(AllexsitingorderIDs.contains(orderDoc.id));
        if (!(AllexsitingorderIDs.contains(orderDoc.id))) {
          print("new doc");
          AllexsitingorderIDs.add(orderDoc.id);
          DocumentSnapshot memberSnapshot = await firestore
              .collection('Orders')
              .doc(orderDoc.id)
              .collection('Member')
              .doc(customerId)
              .get();

          if (memberSnapshot.exists) {
            print("hihihihihihihi");

            var data = memberSnapshot.data() as Map<String, dynamic>?;

            if (data != null && data['subtotal'] != null) {
              var subtotal = data['subtotal'];
              print('Order ID: ${orderDoc.id}, Subtotal: $subtotal');

              var orderID = orderDoc.id;

              // Reference to the "Orders" collection
              DocumentSnapshot orderSnapshot =
                  await firestore.collection('Orders').doc(orderID).get();

              // Check if the order document exists and contains 'status'
              if (orderSnapshot.exists && orderSnapshot.data() != null) {
                var data = orderSnapshot.data() as Map<String, dynamic>?;
                if (data != null && data['status'] != null) {
                  if (data['status'] != "ongoing") {
                    orderIds.add(orderDoc.id);
                    var status = data['status'];
                    print('Order ID: $orderID, Status: $status');
                  }
                } else {
                  print('Status not found for Order ID: $orderID');
                }
              } else {
                print('Order not found with ID: $orderID');
              }
            }
          }
        } else {
          print("this document already excsit ");
        }
      }
    } catch (error) {
      print('Error retrieving order IDs: $error');
    }

    return orderIds;
  }

  Future<void> loadResturantsImages(String restID) async {
    final String imagePath = "/Restaurants/$restID/Logo";

    await PhotoPicker.getimg(imagePath);
    final String imageUrl = await PhotoPicker.geturl();

    listOfRestaurantImages[restID] = Padding(
      padding: EdgeInsets.all(0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Set the border radius here
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            width: 87,
            height: 70,
          )),
    );
  }
}
