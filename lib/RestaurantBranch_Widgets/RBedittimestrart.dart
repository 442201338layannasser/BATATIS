import 'package:batatis/RestaurantBranch_Screens/All_RestaurantBranch_Screens.dart';
import 'package:batatis/RestaurantBranch_Widgets/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RBedittimestart extends StatefulWidget {
  final void Function(String selectedTime) onTimeSelected;
  final bool isEditable;

  RBedittimestart({
    required this.onTimeSelected,
    this.isEditable = true,
  });

  @override
  RBedittimestartState createState() => RBedittimestartState();
}

class RBedittimestartState extends State<RBedittimestart> {
  @override
  void initState() {
    super.initState();
    islog();
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;

        val = picked.format(context); //formate time h:mm AM/PM
        final formattedTime =
            picked.format(context); // Format the time as a string
        widget.onTimeSelected(
            formattedTime); // Call the callback with the selected time
      });
    }
  }

  void getStarttime() async {
    //String? resturantid = await Controller.getUid();

    DocumentReference orderRef = FirebaseFirestore.instance
        .collection("Restaurants")
        .doc(RSharedPref.RestId);

    DocumentSnapshot snapshot = await orderRef.get();

    if (snapshot.exists) {
      Map<String, dynamic>? dataMap = snapshot.data() as Map<String, dynamic>?;

      if (dataMap != null) {
        dynamic emailValue = dataMap["StartTime"];

        if (emailValue != null) {
          val = emailValue.toString();
          print("iam in start $val");
        } else {}
      } else {}
    } else {}
  }

  static String val = '';
  @override
  Widget build(BuildContext context) {
    // print("iam in time picker start $val");

    return GestureDetector(
      onTap: () {
        if (widget.isEditable) _selectTime(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.13,
        height: MediaQuery.of(context).size.height * 0.1,
        margin: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: grey_light,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              val,
              style: TextStyle(
                color: black,
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
