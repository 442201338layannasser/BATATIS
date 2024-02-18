import 'package:batatis/Controller.dart';
import 'package:batatis/RegExp.dart';
import 'package:batatis/RestaurantBranch_Widgets/TimePickeEnd.dart';
import 'package:batatis/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:batatis/RestaurantBranch_Widgets/All_RB_Widgets.dart';
import 'package:intl/intl.dart';
import 'All_RestaurantBranch_Screens.dart';

class RBRegisterThird extends StatefulWidget {
  const RBRegisterThird({super.key});

  static String Address = "";
  static StateSetter? RBR3Set;
  @override
  State<RBRegisterThird> createState() => RBThirdSignUpState();
  //final String assetName = 'assets/image.svg';
}

class RBThirdSignUpState extends State<RBRegisterThird> {
  // final String assetName = 'assets/image.svg';

  static String errorMsg = " ";
  final _RBsignupKey3 = GlobalKey<FormState>();
  bool timeGo = true;
  static String startTime = " ";
  static String endTime = " ";
  static String splitted = " ";
  //bool hour1=true;
  //bool hour2=true;
  bool timeFromPicker = false;

  @override
  Widget build(BuildContext context) {
    RBRegisterThird.RBR3Set = setState;

    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 100), //add some space avove the row
              Align(
                alignment: Alignment.center,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(children: <Widget>[
                        SvgPicture.asset('assets/Images/RB_cUser.svg'),
                        CustomText(text: "User Info", type: "Subheading1W"),
                      ]),

                      SizedBox(width: 18), // Add horizontal space between icons
                      SvgPicture.asset('assets/Images/cArrow.svg'),
                      SizedBox(width: 18), // Add horizontal space between icons
                      Column(children: <Widget>[
                        SvgPicture.asset('assets/Images/RB_cFileSearch.svg'),
                        CustomText(
                            text: "Resturant Info", type: "Subheading1W"),
                      ]),
                      SizedBox(width: 18), // Add horizontal space between icons
                      SvgPicture.asset('assets/Images/cArrow.svg'),
                      SizedBox(width: 18), // Add horizontal space between icons
                      Column(children: <Widget>[
                        SvgPicture.asset('assets/Images/RB_cBranch.svg'),
                        CustomText(text: "Branch Info", type: "Subheading1W"),
                      ]),
                      SizedBox(width: 18), // Add horizontal space between icons
                      SvgPicture.asset('assets/Images/Arrow.svg'),
                      SizedBox(width: 18), // Add horizontal space between
                      Column(children: <Widget>[
                        SvgPicture.asset('assets/Images/RB_CreditCard.svg'),
                        CustomText(text: "Bank Info", type: "Subheading1W"),
                      ]),
                      SizedBox(width: 10),
                    ]),
              ),
              SizedBox(height: 37), // Add space between icons and form

              Form(
                key: _RBsignupKey3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 109), // Add space between icons and form

                        Stack(
                          children: [
                            //   if (RBFirstSignUpState.values['endTime'] ==RBFirstSignUpState.values['endTime'] )
                            TimePickerStart(
                              onTimeSelected: (selectedTime) {
                                timeFromPicker = false;

                                // You can save it, display it, or perform any other action with the selected time.
                                RBFirstSignUpState.values['startTime'] =
                                    selectedTime;
                                print("You're in start");
                                print("You choose start " + selectedTime);

                                String? startTime =
                                    RBFirstSignUpState.values?['startTime'];
                                String? endTime =
                                    RBFirstSignUpState.values?['endTime'];

                                if (endTime != null) {
                                  // Check if selectedTime doesn't end with AM or PM
                                  if (!endTime.endsWith("AM") &&
                                      !endTime.endsWith("PM")) {
                                    timeFromPicker = true;

                                    List<String> parts = endTime.split(':');
                                    if (parts.length == 2) {
                                      int hours = int.parse(parts[0]);
                                      int minutes = int.parse(parts[1]);

                                      if (0 <= hours && hours <= 11) {
                                        endTime += " AM";
                                      } else if (hours == 12) {
                                        endTime += " PM";
                                      } else if (13 <= hours && hours <= 23) {
                                        endTime =
                                            "${hours - 12}:${minutes.toString().padLeft(2, '0')} PM";
                                      }
                                    }
                                  }
                                }

                                print(startTime);
                                print(endTime);

                                if (startTime != null && endTime != null) {
                                  DateFormat formatter = DateFormat(
                                      'HH:mm a'); // Define the formatter
                                  DateTime time1 = formatter.parse(startTime);
                                  DateTime time2 = formatter.parse(endTime);

                                  print(time1);

                                  // Check if the parsed time is midnight (00:00)
                                  if (time1.hour == 0) {
                                    // Convert it to noon (12:00 PM)
                                    time1 = DateTime(1970, 01, 01, 12,
                                        time1.minute, time1.second);
                                    print(time1);
                                  }
                                  // Check if the parsed time is afternoon (12:00)
                                  else if (time1.hour == 12) {
                                    // Convert it to noon (12:00 PM)
                                    time1 = DateTime(1970, 01, 01, 00,
                                        time1.minute, time1.second);
                                    print(time1);
                                  }

                                  // Check if the parsed time is midnight (00:00)
                                  if (time2.hour == 0) {
                                    // Convert it to noon (12:00 PM)
                                    time2 = DateTime(1970, 01, 01, 12,
                                        time2.minute, time2.second);
                                    print(time2);
                                  }

                                  // Check if the parsed time is afternoon (12:00)
                                  else if (time2.hour == 12) {
                                    // Convert it to noon (12:00 PM)
                                    time2 = DateTime(1970, 01, 01, 00,
                                        time2.minute, time2.second);

                                    print(time2);
                                  }

                                  print(time1);
                                  print(time2);

                                  if (!timeFromPicker) {
                                    if (time1 == time2) {
                                      setState(() {
                                        timeGo = false;
                                        errorMsg =
                                            "start and end time can not be the same";
                                      });
                                    }

                                    if (time1.isAfter(time2)) {
                                      setState(() {
                                        timeGo = false;
                                        errorMsg =
                                            "Start time can not be after the end time";
                                      });
                                    } else {
                                      // Reset the error message when a valid time is selected

                                      setState(() {
                                        errorMsg = "";
                                        timeGo = true;
                                      });
                                    }
                                  } //timeformpicker
                                }
                              },
                            ),
                            if (errorMsg != null)
                              Transform.translate(
                                offset: Offset(25,
                                    50), // Adjust the Y-offset to move the text upwards
                                child: Text(
                                  // Display the error message conditionally
                                  errorMsg!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),

                        SizedBox(width: 10),

                        Stack(
                          children: [
                            //   if (RBFirstSignUpState.values['endTime'] ==RBFirstSignUpState.values['endTime'] )
                            TimePickerEnd(
                              onTimeSelected: (selectedTime) {
                                timeFromPicker = false;

                                // You can save it, display it, or perform any other action with the selected time.
                                RBFirstSignUpState.values['endTime'] =
                                    selectedTime;
                                print("You're in end");
                                print("You choose end " + selectedTime);

                                String? startTime =
                                    RBFirstSignUpState.values?['startTime'];
                                String? endTime =
                                    RBFirstSignUpState.values?['endTime'];

                                if (startTime != null) {
                                  // Check if selectedTime doesn't end with AM or PM
                                  if (!startTime.endsWith("AM") &&
                                      !startTime.endsWith("PM")) {
                                    List<String> parts = startTime.split(':');
                                    if (parts.length == 2) {
                                      int hours = int.parse(parts[0]);
                                      int minutes = int.parse(parts[1]);

                                      if (0 <= hours && hours <= 11) {
                                        startTime += " AM";
                                      } else if (hours == 12) {
                                        startTime += " PM";
                                      } else if (13 <= hours && hours <= 23) {
                                        startTime =
                                            "${hours - 12}:${minutes.toString().padLeft(2, '0')} PM";
                                      }
                                    }
                                  }
                                }

                                print(startTime);
                                print(endTime);

                                if (startTime != null && endTime != null) {
                                  DateFormat formatter = DateFormat(
                                      'HH:mm a'); // Define the formatter
                                  DateTime time1 = formatter.parse(startTime);
                                  DateTime time2 = formatter.parse(endTime);

                                  print(time2.hour);

                                  // Check if the parsed time is midnight (00:00)
                                  if (time1.hour == 0) {
                                    // Convert it to noon (12:00 PM)
                                    time1 = DateTime(1970, 01, 01, 12,
                                        time1.minute, time1.second);
                                    print(time1);
                                  }
                                  // Check if the parsed time is afternoon (12:00)
                                  else if (time1.hour == 12) {
                                    // Convert it to noon (12:00 PM)
                                    time1 = DateTime(1970, 01, 01, 00,
                                        time1.minute, time1.second);
                                    print(time1);
                                  }

                                  // Check if the parsed time is midnight (00:00)
                                  if (time2.hour == 0) {
                                    // Convert it to noon (12:00 PM)
                                    time2 = DateTime(1970, 01, 01, 12,
                                        time2.minute, time2.second);
                                    print(time2);
                                  }

                                  // Check if the parsed time is afternoon (12:00)
                                  else if (time2.hour == 12) {
                                    // Convert it to noon (12:00 PM)
                                    time2 = DateTime(1970, 01, 01, 00,
                                        time2.minute, time2.second);

                                    print(time2);
                                  }

                                  print(time1);
                                  print(time2);

                                  if (!timeFromPicker) {
                                    if (time1 == time2) {
                                      setState(() {
                                        timeGo = false;
                                        errorMsg =
                                            "start and end time can not be the same";
                                      });
                                    } else if (time1.isAfter(time2)) {
                                      setState(() {
                                        timeGo = false;
                                        errorMsg =
                                            "Start time can not be after the end time";
                                      });
                                    } else {
                                      // Reset the error message when a valid time is selected
                                      setState(() {
                                        errorMsg = "";
                                        timeGo = true;
                                      });
                                    }
                                  } //timefrompicker
                                }
                              },
                            ),
                            if (errorMsg != null)
                              Transform.translate(
                                offset: Offset(25,
                                    50), // Adjust the Y-offset to move the text upwards
                                child: Text(
                                  // Display the error message conditionally
                                  errorMsg!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),

                    LocationPicker(
                      width: 250,
                      height: 300,
                    ),
                    CustomText(
                      text: RBRegisterThird.Address,
                      color: Color.fromRGBO(127, 128, 129, 1),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),

                    //Text("Coordinates " + LocationPicker.value!.latitude.toString() + LocationPicker.value!.longitude.toString()),
                    //Text(RBFirstSignUpState.values['address'] = LocationPicker.value!.latitude.toString() + LocationPicker.value!.longitude.toString()),

                    // CustomTextFiled(
                    //   text: "Fee in SR",
                    //   controller: RBFirstSignUpState.myRBController[13],
                    //   isvalid: Controller.deliveryfeeValidation,
                    //  maxLen: 7,
                    //   allowed: regonlynumberandDot,
                    //   onLostFocus: (text) {
                    //     // Add your code here to handle the message when the field loses focus
                    //     print("Field lost focus: $text");
                    //   },
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width:
                                431), // Add horizontal space between Dropdown and Button
                        CustomButton(
                          text: "Next",
                          onPressed: () {
                            Controller.RBsignup3(
                                _RBsignupKey3,
                                RBFirstSignUpState.values,
                                setState,
                                RBFirstSignUpState.myRBController,
                                context,
                                timeGo);
                          },
                          type: "add",
                          width: 0.1,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
