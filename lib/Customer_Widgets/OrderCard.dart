import 'package:batatis/Costomer_Screens/ViewMenuToCustomer.dart';
import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
import 'package:flutter/material.dart';
import '../Costomer_Screens/SummaryPage.dart';
import '../Views/Customer_View.dart';

class OrderCard extends StatelessWidget {
  final String OrderID;
  final String? RestaurantId;
  final String? name;
  final String? orderDate; //name
  final String? total; //distance
  final Widget? img;
  final String? status; //status of the order not the rest

  const OrderCard({
    Key? key,
    required this.OrderID,
    this.name = "",
    this.orderDate = "",
    this.total = "",
    this.img,
    this.RestaurantId,
    this.status = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),

      child: GestureDetector(
        child: Container(
          margin: EdgeInsets.all(4.0),
          width: double.infinity,
          height: 115, // Increased the height to accommodate fee and time
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 0),
                spreadRadius: 3,
                blurRadius: 6,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Container(
                  width: 90,
                  height: 110,
                  child: img,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Text(
                            name!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Text(
                           "#${OrderID.substring(0,5)}",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                      Row(
                        children: [
                          Text(
                            orderDate!,
                            style: TextStyle(
                              fontSize: 15,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                          // SizedBox(width: 100,),
                          SizedBox(width: 60),
                          Expanded(
                            child: Text(
                              status! + "", //waiting
                              style: TextStyle(
                                fontSize: 15,
                                color: status == "Rejected"
                                    ? Colors.red
                                    : status == "Preparing"
                                        ? Batatis_Dark
                                        : status == "Out for Delivery"
                                            ? Colors.green
                                            : status == "Delivered"
                                                ? Colors.grey
                                                : black,
                              ),
                            ),
                          ),
                          //     Container( //to emphasis the current order with border
                          //     padding: EdgeInsets.only(left: 5, right: 5, bottom: 3, top: 3),
                          //     decoration: BoxDecoration(
                          //     border: Border.all(color:
                          //           status == "Preparing" ? Batatis_Dark :
                          //           status == "Out for Delivery" ? Colors.green :
                          //           Colors.white,
                          //     ),
                          //       borderRadius: BorderRadius.circular(10), // Rounded corners
                          //   ),
                          //   child: Text(
                          //     status!,
                          //     style: TextStyle(
                          //       fontSize: 15,
                          //       color: status == "Rejected" ? Colors.red :
                          //           status == "Preparing" ? Batatis_Dark :
                          //           status == "Out for Delivery" ? Colors.green :
                          //           status == "Delivered" ? Colors.grey :
                          //           Colors.black,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 0, //40
                      ),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              total! + " SR",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            width:
                                10, // Add some spacing between fee and distance
                          ),
                          // Icon(Icons., size: 20),
                          // Expanded(
                          //   child: Text(
                          //    status! + "",
                          //     style: TextStyle(fontSize: 15 , color: status=="Closed" ? Colors.red :Colors.green ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          print("order clicked " + OrderID);
          SummaryPage.orderid = OrderID;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SummaryPage(),
            ),
          );
        },
      ),
    );
  }
}
