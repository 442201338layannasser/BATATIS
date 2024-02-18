import 'package:batatis/Costomer_Screens/All_Costomer_Screens.dart';
import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Views/Customer_View.dart';
import 'colors.dart';

class UserLocationDialog extends StatelessWidget {
  UserLocationDialog();

  @override
  //to send to database
  static StateSetter? State;
  static String deliveryadd = "No selected location";
  static double? lat = 0;
  static double? long = 0;
  static String finaldeliveryadd = ""; // to shared prefrence
  Set<Marker> userMarkers = {};

  Widget build(BuildContext context) {
    return StatefulBuilder(
      // StatefulBuilder
      builder: (context, setState) {
        State = setState;
        if (SharedPrefer.UserLat != "" && SharedPrefer.UserLong != null) {
          //check if the shared prefrenses has lat and long recorded
          LocationPicker.value = LatLng(
              double.parse(SharedPrefer.UserLat.toString()),
              double.parse(SharedPrefer.UserLong
                  .toString())); // display the recorded place as default
        }
        return AlertDialog(
            insetPadding: EdgeInsets.all(0),
            //contentPadding: EdgeInsets.all(0),
            //title: const Text('Confirm Log Out'),
            content: Container(
                width: 350,
                height: 645,
                child: Stack(
                  children: [
                    Positioned(
                      top: 50,
                      left: 0,
                      right: 0,
                      child: LocationPicker(
                        width: 400.0,
                        height: 450.0,
                        markers: userMarkers,
                        selfPin: 30.0,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              "Select Location",
                              style: TextStyle(
                                  color: Batatis_Dark,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.cancel),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                          width: 400,
                          padding: EdgeInsets.all(0),
                          margin: EdgeInsets.only(bottom: 0),
                          // color: red,
                          child: Column(
                            children: [
                              Row(children: [
                                Icon(
                                  Icons.pin_drop,
                                  size: 32, /*color: Batatis_Dark,*/
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    padding: EdgeInsets.only(bottom: 10),
                                    width: 300,
                                    child: Text(
                                      deliveryadd,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 18, /*color: Batatis_Dark,*/
                                      ),
                                    )),
                              ]),
                              CustomButton(
                                text: "confirm delivery location",
                                onPressed: () async {
                                  finaldeliveryadd = deliveryadd;
                                  print(  "finaldeliveryadd    $finaldeliveryadd");
                                await  SharedPrefer.SetUserLocation(finaldeliveryadd,
                                      lat.toString(), long.toString());
                                 
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(context,  MaterialPageRoute(
                                     builder: (context) => const CHomePage ()));
                               
                                  CmainpageState.state(() {
                                    CmainpageState.isOkay = true;
                                

                                    //     SharedPrefer.SetUserLocation(finaldeliveryadd, LocationPicker.value!.latitude.toString(), LocationPicker.value!.longitude.toString());
                                  });
                                },
                                type: "confirm",
                              ),
                            ],
                          )),
                    ),

                    // LocationPicker(width : MediaQuery.of(context).size.width , height : MediaQuery.of(context).size.height,markers:userMarkers),
                  ],
                ))
            // actions: <Widget>[
            //    TextButton(
            //     onPressed: () =>  Navigator.pop(
            //        context,
            //     ),
            //     child: const Text('Cancel'),
            );
      },
    );
  }
}
