import 'package:batatis/Customer_Widgets/colors.dart';
import 'package:flutter/material.dart';


class TimePickerStart extends StatefulWidget {
  final void Function(String selectedTime) onTimeSelected;

  TimePickerStart({required this.onTimeSelected});

  @override
  _TimePickerStartState createState() => _TimePickerStartState();
}

class _TimePickerStartState extends State<TimePickerStart> {
  TimeOfDay selectedTime = TimeOfDay.now();
  

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null ) {
      setState(() {
        selectedTime = picked;
        
        val ="Start Time: "+ picked.format(context); //formate time h:mm AM/PM
        final formattedTime = picked.format(context); // Format the time as a string
        widget.onTimeSelected(formattedTime); // Call the callback with the selected time

      });
    }
  }
  
 static String val = "Branch Start Time";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       // if ()
       _selectTime(context);
        //var 
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.16,
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
                color: Color.fromRGBO(127, 128, 129, 1),
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
         ),
      
    );
  }
}
