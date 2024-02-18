import 'package:batatis/RestaurantBranch_Screens/RBRegisterFirst.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class EditWidget extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final Function(String) onChanged;
  final StateSetter setState;
  final bool iseditable;
  EditWidget({
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.setState,
    this.iseditable = false,
  });
  Color gg = Colors.black;
  @override
  Widget build(BuildContext context) {
    if (iseditable) {
      return PopupMenuButton<String>(
        itemBuilder: (BuildContext context) {
          return items.map<PopupMenuEntry<String>>((String value) {
            return PopupMenuItem<String>(
              //  textStyle: TextStyle(color: Colors.red),
              //labelTextStyle: TextStyle(color: Colors.green) ,
              value: value,
              child: Text(value),
            );
          }).toList();
        },
        onSelected: (
          String newValue,
        ) {
          setState(() {
            gg = Colors.black;
          });

          onChanged(newValue);
        },
        elevation: 0,
        tooltip: "",
        child: Container(
          width: MediaQuery.of(context).size.width * 0.13,
          height: MediaQuery.of(context).size.height * 0.1,
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: grey_light,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                selectedValue,
                style: TextStyle(
                  color: gg, //Color.fromRGBO(127, 128, 129, 1),
                  fontWeight: FontWeight.normal,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: MediaQuery.of(context).size.width * 0.13,
        height: MediaQuery.of(context).size.height * 0.1,
        margin: EdgeInsets.all(0),
        decoration: BoxDecoration(
          color: grey_light,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              selectedValue,
              style: TextStyle(
                color: gg, //Color.fromRGBO(127, 128, 129, 1),
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      );
    }
  }
}
