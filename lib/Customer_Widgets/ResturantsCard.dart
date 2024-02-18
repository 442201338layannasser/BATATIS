import 'package:batatis/Costomer_Screens/ViewMenuToCustomer.dart';
import 'package:flutter/material.dart';
import '../Views/Customer_View.dart';

class ResCard extends StatelessWidget {
  final String? RestaurantId;
  final String? name;
  final String? distence;
  final String? Fee;
  final String? StartTime;
  final String? EndTime;
  final Widget? img;
  final String? status;

  const ResCard({
    Key? key,
    this.name = "",
    this.distence = "",
    this.img,
    this.RestaurantId,
    this.Fee = "",
    this.StartTime = "",
    this.EndTime = "",
    this.status = "opened",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: GestureDetector(
        child: Container(
          //the Container rect around the resturant card
          // margin: EdgeInsets.all(2.0),
          width: double.infinity,
          height: 105, // Increased the height to accommodate fee and time
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
                            height: 60,
                          ),
                          Text(
                            name!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          /*Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 20,
                              color: Colors.grey, // Customize the icon color
                            ),
                            const SizedBox(width: 3),
                            Text(
                              StartTime! + " - " + EndTime!,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),*/
                        ],
                      ),
                      // const SizedBox(
                      //   height: 40,
                      // ),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.delivery_dining_sharp, size: 20),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            Fee! + "SR",
                            style: TextStyle(
                              fontSize: 15,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width:
                                15, // Add some spacing between fee and distance
                          ),
                          Icon(Icons.location_on, size: 20),
                          Expanded(
                            child: Text(
                              distence! + "Km",
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            width:
                                20, // Add some spacing between fee and distance
                          ),
                          // Icon(Icons., size: 20),
                          Expanded(
                            child: Text(
                              status! + "",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: status == "Closed"
                                      ? Colors.red
                                      : Colors.green),
                            ),
                          ),
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
          ViewMenuToCustomerState.RestaurantId = RestaurantId;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewMenuToCustomer(),
            ),
          );
        },
      ),
    );
  }
}
