
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_geocoder/geocoder.dart';

import 'RBeditprofile.dart';
import 'toaddress.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:flutter_geocoder/geocoder.dart';
import 'dart:convert';import'package:http/http.dart' as http;

import 'RBRegisterFirst.dart';

class LocationPicker extends StatefulWidget {
 static LatLng value = LatLng(0, 0);
  
  var width;
  var height;
 var editing ;//= true ; 
var setter ; 
 // StateSetter setState ; 

  LocationPicker({
    Key? key,
   // required this.setState
   required this.width,
   required this.height,
   this.editing = true,
    this.setter = null,
   //this.value = const LatLng(24.72573904236955, 46.626756471630195)
   
  }) : super(key: key);

  //LatLng? value;
  @override //setState1 : setState
  State<LocationPicker> createState() => LocationPickerState();
}

class LocationPickerState extends State<LocationPicker> {
  late GoogleMapController mapController;
  //StateSetter setState1 ; 
LocationPickerState({
    Key? key,
    //required this.setState1
    });
  //final LatLng _center = const LatLng(-33.86, 151.20);

  void _onMapCreated(GoogleMapController controller) {
    print(("creating "));
    mapController = controller;
    //  controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(24.72573904236955, 46.626756471630195),14.5));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
              child: Column(children: [
                SizedBox(
                  height: widget.height , //300,
                  width:  widget.width , //250,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      var maxWidth = constraints.biggest.width;
                      var maxHeight = constraints.biggest.height;

                      return Stack(
                        children: <Widget>[
                          SizedBox(
                            width: maxWidth,
                            child: GoogleMap(
                              //     onTap: (n) {
                              //       print("on tap");
                              //        con.animateCamera(CameraUpdate.newLatLngZoom(LatLng(24.3212, 46.765434),1));
                              //       print("on tap after ");

                              // },
                              initialCameraPosition: CameraPosition(
                                target: LocationPicker.value,
                                zoom: 14.5,
                              ),
                              onMapCreated: _onMapCreated,
                              //     (controller) {
                              //       // _controller.complete(controller as FutureOr<webGM.GoogleMapController>?);
                              //       // con = controller ;
                              //       // print("on create " + con.toString()
                              //       // );
                              // _onMapCreated();
                              //     },
                              onCameraMove: (CameraPosition newPosition) async {
                                LocationPicker.value = newPosition.target;
                                //pos = newPosition.target. ; 
                                await getAddressFromCoordinatesUsingGoogleMapsAPI(LocationPicker.value!.latitude, LocationPicker.value!.longitude);
                            //    await getAddressFromCoordinatesUsingGoogleMapsAPI2(LocationPicker.value!.latitude, LocationPicker.value!.longitude);
                              
                                print( " moved " + LocationPicker.value.toString()); 

                                //    bool flag = true ;
                                //     if(pos !=null)
                                // {  print("pos not null !!!!");
                                // flag = false ;
                                //   widget.value = LatLng(pos!.latitude , pos!.longitude);
                                //   }
                                // else if( flag) widget.value = newPosition.target;
                                //     print("moving");
                                //     setState(() {
                                //     loc = widget.value!.latitude.toString() +"\n"+ widget.value!.longitude .toString() ;

                                //     });
                              },
                               onCameraIdle: () async {
                                print("ideal");
                             var myaddress = await getAddressFromCoordinatesUsingGoogleMapsAPI2
(
                              LocationPicker.value.latitude,
                              LocationPicker.value.longitude);
                            print("myaddress $myaddress");
                            if(widget.setter !=null) { 
                              widget.setter((){
                                
                                  RBeditprofileState.address = myaddress ;

                            });
                              }
                              },
                              mapType: MapType.normal,
                              myLocationButtonEnabled: true,
                              myLocationEnabled: true,
                              zoomGesturesEnabled: true,
                              padding: const EdgeInsets.all(0),
                              buildingsEnabled: true,
                              compassEnabled: true,
                              indoorViewEnabled: false,
                              mapToolbarEnabled: true,
                              minMaxZoomPreference:
                                  MinMaxZoomPreference.unbounded,
                              rotateGesturesEnabled: widget.editing , //false,
                              scrollGesturesEnabled:widget.editing ,// false,
                              tiltGesturesEnabled: widget.editing, // false,
                              trafficEnabled: false,
                          
                           markers: {}
                          //   Marker(markerId: MarkerId("1"), position : LatLng(24.72573904236955, 46.626756471630195),infoWindow : InfoWindow(title: "hohoho\n click to go to resturant" , onTap: () {
                          //    print("object");
                          //  },))},
                            ),
                          ),
                         
                          Positioned(
                            bottom: maxHeight / 2,
                            right: (maxWidth - 30) / 2,
                            child: const Icon(
                              Icons.person_pin_circle,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Container(
                              color: Colors.white,
                              child: IconButton(
                                onPressed: () async {
                                  print("pressed");
                                  await _determinePosition();
                                  print("already back ");
                                },
                                icon: const Icon(Icons.my_location),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                )
              ]),
            );
  }

  late Position pos  ;
  Future<void> _determinePosition() async {
    
    print("get my loc ");
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'Location services are disabled.';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Location permissions are denied.';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'Location permissions are permanently denied.';
      }

      pos = await Geolocator.getCurrentPosition();
      if (pos != null) {
       print("we in current ");
       await getAddressFromCoordinatesUsingGoogleMapsAPI(pos.latitude, pos.longitude);
         //String address = await getAddress(pos.latitude, pos.longitude);
           //print(address);
           
        // setState1(() async {
        //   //RBFirstSignUpState.myRBController[5].text = address ; 
        //   print(pos.latitude);
        // LocationPicker.value = LatLng(pos.latitude, pos.longitude) ; 
         
        // });
       
        print("pos not null " +LatLng(pos.latitude, pos.longitude).toString() );
        //final GoogleMapController controller = await mapController;
        mapController.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(pos.latitude, pos.longitude),//moved LatLng(24.789357432519342, 46.77602752825608)
              zoom: 14.5,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error obtaining location: $e');
    }
  }

// static Future<String> getAddress(lat, lag) async {
//     String resaddress = " ";

//     final coordinates = new Coordinates(lat, lag);
//     var address =
//         await Geocoder.local.findAddressesFromCoordinates(coordinates);
//     var first = address.first.addressLine;
   
   

//     print(address.toString() + " adresssssess");
//     print(first.toString() + "stringggggg");
//        print(address.first.locality);///city//
//        print(address.first.subLocality);////neighboor//
//        print(address.first.adminArea);//province
//        print(address.first.subAdminArea);//Principality
//        print(address.first.featureName);////7425
//        print(address.first.thoroughfare);///street//
//        print(address.first.subThoroughfare);////7425//

//    //resaddress = address.first.locality.toString()==null?'':address.first.locality.toString() +" "+ address.first.subLocality.toString()==null?'':address.first.subLocality.toString()+" " +address.first.thoroughfare.toString()==null?'':address.first.thoroughfare.toString() +" "+address.first.subThoroughfare.toString()==null?'': address.first.subThoroughfare.toString();

//     // setState(() {
//    resaddress = first.toString();
//     // });
//     return resaddress;
//   }

//  Future<Map<String, dynamic>>  getAddresslatlong() async {
// Map<String,dynamic> res = {};  
// res["lat"] = LocationPicker.value.latitude;
// res["long"] = LocationPicker.value.longitude;
// res["address"] =  await getAddressFromCoordinatesUsingGoogleMapsAPI(LocationPicker.value!.latitude, LocationPicker.value!.longitude);
//           return res ;                     
//  }

static getAddresslatlong(restid) async {
  print("getAddresslatlong");
var address =  await getAddressFromCoordinatesUsingGoogleMapsAPI2(LocationPicker.value!.latitude, LocationPicker.value!.longitude);

var lat = LocationPicker.value.latitude ; 
var long = LocationPicker.value.longitude;
print("new location add $address , lat $lat , long $long ");
await FirebaseFirestore.instance.collection("Restaurants").doc(restid).update({
  "Lat":lat.toString(),
  "Long":long.toString(),
  "Address":address

 });
 print("saved goody");
// Map<String,dynamic> res = {};  
// res["lat"] = LocationPicker.value.latitude;
// res["long"] = LocationPicker.value.longitude;
// res["address"] =  await getAddressFromCoordinatesUsingGoogleMapsAPI(LocationPicker.value!.latitude, LocationPicker.value!.longitude);
         // return res ;                     
 }
static void convertLocation() async {

  final apiKey = 'AIzaSyBdfHnK91LWNwztf2NQO6xfNN6ZSdp0yFA';

  final arabicLocation = 'RBBE6644، 6644 الساعد، 3274، حي ظهرة البديعة، Riyadh 12982, Saudi Arabia';
 
  final endpoint = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?address=$arabicLocation&key=$apiKey&language=en');
 
  final response = await http.get(endpoint);
 
  if (response.statusCode == 200) {

    final json = jsonDecode(response.body);

    final englishName = json['results'][0]['formatted_address'];

    print('English Name: $englishName');

  } else {

    print('Geocoding failed with status: ${response.statusCode}');

  }

}}

 //void _getAddress() async {
  // Get the address of the current user's location.
  //final address = await getAddress(LocationPicker.value!.latitude, LocationPicker.value!.longitude);

  // Set the state of the text field.
  //setState1(() {
   // RBFirstSignUpState.myRBController[5].text = address;
  //});
//}
//   // Get the address of the user's location.
//   final address = await getAddress(position.latitude, position.longitude);

//   // Display the address in the text field.
//   addressController.text = address;
// }

//     LayoutBuilder(
//     builder: (context, constraints) {
//       var maxWidth = constraints.biggest.width;
//       var maxHeight = constraints.biggest.height;
//        return  Stack(
//           children: <Widget>[
//         Container(
//           height: 350 ,
//           width: 400 ,
//           child: GoogleMap(
//           onMapCreated: _onMapCreated,
//           initialCameraPosition: CameraPosition(
//             target: LatLng(24.72573904236955, 46.626756471630195),
//             zoom: 14.5,
//           ),

//         onCameraMove: (CameraPosition newPosition) {
//          // widget.value = newPosition.target;
//         print("moving");
//         }

//         ),
//         ),
//         Positioned(
//             bottom: maxHeight / 2,
//             right: (maxWidth - 30) / 2,
//             child: const Icon(
//               Icons.person_pin_circle,
//               size: 300,
//               color: Colors.black,
//             ),
//           ),

//         ]);  }),
//   )); } //);
//   }
// //}
///}


// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//  //import 'package:flutter_geocoder/geocoder.dart';
// //  import 'package:geocoder/geocoder.dart';
// //import 'package:geocoding/geocoding.dart';
// import 'RBRegisterFirst.dart';

// class LocationPicker extends StatefulWidget {
//   static LatLng? value = LatLng(0, 0);
//   //StateSetter setState ; 
//   var width ; 
//   var height ;  
//   LocationPicker({
//     Key? key,
//    // required this.setState
//     required this.height,
//     required this.width 
//   }) : super(key: key);

//   //LatLng? value;
//   @override
//   State<LocationPicker> createState() => LocationPickerState();
// }

// class LocationPickerState extends State<LocationPicker> {
//   late GoogleMapController mapController;

//   //final LatLng _center = const LatLng(-33.86, 151.20);

//   void _onMapCreated(GoogleMapController controller) {
//     print(("creating "));
//     mapController = controller;
//     //  controller.animateCamera(CameraUpdate.newLatLngZoom(LatLng(24.72573904236955, 46.626756471630195),14.5));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//               child: Column(children: [
//                 SizedBox(
//                   height: widget.height,
//                   width: widget.width,
//                   child: LayoutBuilder(
//                     builder: (context, constraints) {
//                       var maxWidth = constraints.biggest.width;
//                       var maxHeight = constraints.biggest.height;

//                       return Stack(
//                         children: <Widget>[
//                           SizedBox(
//                             width: maxWidth,
//                             child: GoogleMap(
//                               //     onTap: (n) {
//                               //       print("on tap");
//                               //        con.animateCamera(CameraUpdate.newLatLngZoom(LatLng(24.3212, 46.765434),1));
//                               //       print("on tap after ");

//                               // },
//                               initialCameraPosition: CameraPosition(
//                                 target: LatLng(
//                                     24.72573904236955, 46.626756471630195),
//                                 zoom: 14.5,
//                               ),
//                               onMapCreated: _onMapCreated,
//                               //     (controller) {
//                               //       // _controller.complete(controller as FutureOr<webGM.GoogleMapController>?);
//                               //       // con = controller ;
//                               //       // print("on create " + con.toString()
//                               //       // );
//                               // _onMapCreated();
//                               //     },
//                               onCameraMove: (CameraPosition newPosition) async {
//                                 LocationPicker.value = newPosition.target;
//                                String address = await getAddress(LocationPicker.value!.latitude, LocationPicker.value!.longitude);
//                                 // setState(() {
//                                 //   print(address);
//                                 //   RBFirstSignUpState.myRBController[5].text = address ; 
                                  
//                                 // });
//                                 print( " moved " + LocationPicker.value.toString()); 
//                                 print("address" + address);
//                                 //    bool flag = true ;
//                                 //     if(pos !=null)
//                                 // {  print("pos not null !!!!");
//                                 // flag = false ;
//                                 //   widget.value = LatLng(pos!.latitude , pos!.longitude);
//                                 //   }
//                                 // else if( flag) widget.value = newPosition.target;
//                                 //     print("moving");
//                                 //     setState(() {
//                                 //     loc = widget.value!.latitude.toString() +"\n"+ widget.value!.longitude .toString() ;

//                                 //     });
//                               },
//                               mapType: MapType.normal,
//                               myLocationButtonEnabled: true,
//                               myLocationEnabled: true,
//                               zoomGesturesEnabled: true,
//                               padding: const EdgeInsets.all(0),
//                               buildingsEnabled: true,
//                               compassEnabled: true,
//                               indoorViewEnabled: false,
//                               mapToolbarEnabled: true,
//                               minMaxZoomPreference:
//                                   MinMaxZoomPreference.unbounded,
//                               rotateGesturesEnabled: true,
//                               scrollGesturesEnabled: true,
//                               tiltGesturesEnabled: true,
//                               trafficEnabled: false,
//                             ),
//                           ),
//                           Positioned(
//                             bottom: maxHeight / 2,
//                             right: (maxWidth - 30) / 2,
//                             child: const Icon(
//                               Icons.person_pin_circle,
//                               size: 30,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Positioned(
//                             bottom: 10,
//                             left: 10,
//                             child: Container(
//                               color: Colors.white,
//                               child: IconButton(
//                                 onPressed: () async {
//                                   print("pressed");
//                                   await _determinePosition();
//                                   print("already back ");
//                                 },
//                                 icon: const Icon(Icons.my_location),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 )
//               ]),
//             );
//   }

//   late Position pos  ;
//   Future<void> _determinePosition() async {
    
//     print("get my loc ");
//     try {
//       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         throw 'Location services are disabled.';
//       }

//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           throw 'Location permissions are denied.';
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         throw 'Location permissions are permanently denied.';
//       }

//       pos = await Geolocator.getCurrentPosition();
//       if (pos != null) {
//        print("we in current ");
//          //String address = await getAddress(pos.latitude, pos.longitude);
//            //print(address);
           
//         // widget.setState(() async {
//         //   //RBFirstSignUpState.myRBController[5].text = address ; 
//         //   print(pos.latitude);
//         // LocationPicker.value = LatLng(pos.latitude, pos.longitude) ; 
         
//         // });
       
//         print("pos not null " +LatLng(pos.latitude, pos.longitude).toString() );
//         //final GoogleMapController controller = await mapController;
//         mapController.moveCamera(
//           CameraUpdate.newCameraPosition(
//             CameraPosition(
//               target: LatLng(pos.latitude, pos.longitude),//moved LatLng(24.789357432519342, 46.77602752825608)
//               zoom: 14.5,
//             ),
//           ),
//         );
//       }
//     } catch (e) {
//       print('Error obtaining location: $e');
//     }
//   }

// static Future<String> getAddress(lat,lag) async {

//                   String resaddress = " " ; 
//                  // final coordinates = new Coordinates(lat, lag);
//                  print("lattt" + lat.toString());
//                  print("laggggg" + lag.toString());
//                   // var address = await placemarkFromCoordinates(52.2165157, 6.9437819); //Geocoder.local.findAddressesFromCoordinates(coordinates);
//                   // var first = address.first;
//                   // print(address.toString() + " adresssssess");
//                   // print(first .toString() + "stringggggg");
                  
//                   // setState(() {
//                   //   resaddress = first.addressLine.toString();
//                   // });
//  return resaddress ; 
//                 }}
 

//  //void _getAddress() async {
//   // Get the address of the current user's location.
//   //final address = await getAddress(LocationPicker.value!.latitude, LocationPicker.value!.longitude);

//   // Set the state of the text field.
//   //setState1(() {
//    // RBFirstSignUpState.myRBContPositionroller[5].text = address;
//   //});
// //}
// //   // Get the address of the user's location.
// //   final address = await getAddress(position.latitude, position.longitude);

// //   // Display the address in the text field.
// //   addressController.text = address;
// // }

// //     LayoutBuilder(
// //     builder: (context, constraints) {
// //       var maxWidth = constraints.biggest.width;
// //       var maxHeight = constraints.biggest.height;
// //        return  Stack(
// //           children: <Widget>[
// //         Container(
// //           height: 350 ,
// //           width: 400 ,
// //           child: GoogleMap(
// //           onMapCreated: _onMapCreated,
// //           initialCameraPosition: CameraPosition(
// //             target: LatLng(24.72573904236955, 46.626756471630195),
// //             zoom: 14.5,
// //           ),

// //         onCameraMove: (CameraPosition newPosition) {
// //          // widget.value = newPosition.target;
// //         print("moving");
// //         }

// //         ),
// //         ),
// //         Positioned(
// //             bottom: maxHeight / 2,
// //             right: (maxWidth - 30) / 2,
// //             child: const Icon(
// //               Icons.person_pin_circle,
// //               size: 300,
// //               color: Colors.black,
// //             ),
// //           ),

// //         ]);  }),
// //   )); } //);
// //   }
// // //}
// ///}
