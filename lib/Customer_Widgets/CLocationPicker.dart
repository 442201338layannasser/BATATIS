import 'dart:collection';
import 'dart:convert';
import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../Views/Customer_View.dart';
import 'Ctoaddress.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_geocoder/geocoder.dart';
import'package:http/http.dart' as http;
class LocationPicker extends StatefulWidget {
  static LatLng? value = LatLng(24.72573904236955, 46.626756471630195);

  var width;
  var height;
  var markers;
  var selfPin;

  LocationPicker({
    Key? key,
    required this.width,
    required this.height,
    required this.markers,
    required this.selfPin, // variable to check if u want the self pin or not if u want it set it to 30 if u dont set it to 0
  }) : super(key: key);

  @override
  State<LocationPicker> createState() => LocationPickerState();
}

class LocationPickerState extends State<LocationPicker> {
  late GoogleMapController mapController;

  LocationPickerState({
    Key? key,
  });

  void _onMapCreated(GoogleMapController controller) {
    print(("creating "));
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        SizedBox(
          height: widget.height, //300,
          width: widget.width, //250,
          child: LayoutBuilder(
            builder: (context, constraints) {
              var maxWidth = constraints.biggest.width;
              var maxHeight = constraints.biggest.height;

              return Stack(
                children: <Widget>[
                  SizedBox(
                    width: maxWidth,
                    child: GoogleMap(
                        initialCameraPosition:  CameraPosition(
                          target: LocationPicker.value! ,
                          zoom: 14.5,
                        ),
                        onMapCreated: _onMapCreated,
                         onCameraIdle: () async {
                          myaddress = await getAddress(
                              LocationPicker.value?.latitude,
                              LocationPicker.value?.longitude);
                          UserLocationDialog.State!(() {
                            UserLocationDialog.deliveryadd = myaddress;
                            UserLocationDialog.lat = LocationPicker.value?.latitude; 
                            UserLocationDialog.long =  LocationPicker.value?.longitude ;
                          });
                          print(" moved " + LocationPicker.value.toString());
                        },
                        onCameraMove: (CameraPosition newPosition) async {
                          LocationPicker.value = newPosition.target;
                          //   myaddress= await getAddress(LocationPicker.value?.latitude,LocationPicker.value?.longitude);
                          //   CHomePageState.State!(()  {
                          // CHomePageState.deliveryadd=myaddress;
                          // });
                          // pos = newPosition.target.
                          //  await getAddressFromCoordinatesUsingGoogleMapsAPI(LocationPicker.value!.latitude, LocationPicker.value!.longitude);

                          print(" moved " + LocationPicker.value.toString());
                        },
                        mapType: MapType.normal,
                        myLocationButtonEnabled: false,
                        myLocationEnabled: true,
                        zoomGesturesEnabled: true,
                        padding: const EdgeInsets.all(0),
                        buildingsEnabled: true,
                        compassEnabled: true,
                        indoorViewEnabled: false,
                        mapToolbarEnabled: true,
                        minMaxZoomPreference: MinMaxZoomPreference.unbounded,
                        rotateGesturesEnabled: true,
                        scrollGesturesEnabled: true,
                        tiltGesturesEnabled: true,
                        trafficEnabled: false,
                        markers: widget.markers),
                  ),
                  Positioned(
                    bottom: maxHeight / 2,
                    right: (maxWidth - 30) / 2,
                    child: Icon(
                      Icons.person_pin_circle,
                      size: widget.selfPin, //30,
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

  late Position pos;
  static late String myaddress;

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
        print("pos not null " + LatLng(pos.latitude, pos.longitude).toString());
        //myaddress=getAddress(pos.latitude,pos.longitude);
        //final GoogleMapController controller = await mapController;
        mapController.moveCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(pos.latitude, pos.longitude),
              zoom: 14.5,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error obtaining location: $e');
    }
  }

  static Future<String> getAddress(lat, lag) async {
    String resaddress = " ";

    final coordinates = new Coordinates(lat, lag);
    var address =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = address.first.addressLine;
   
   

    print(address.toString() + " adresssssess");
    print(first.toString() + "stringggggg");
       print(address.first.locality);///city//
       print(address.first.subLocality);////neighboor//
       print(address.first.adminArea);//province
       print(address.first.subAdminArea);//Principality
       print(address.first.featureName);////7425
       print(address.first.thoroughfare);///street//
       print(address.first.subThoroughfare);////7425//

   //resaddress = address.first.locality.toString()==null?'':address.first.locality.toString() +" "+ address.first.subLocality.toString()==null?'':address.first.subLocality.toString()+" " +address.first.thoroughfare.toString()==null?'':address.first.thoroughfare.toString() +" "+address.first.subThoroughfare.toString()==null?'': address.first.subThoroughfare.toString();

    // setState(() {
   resaddress = first.toString();
    // });
    return resaddress;
  }
  static String trimAddress(address){ //RFBB6524, 6524 Muhammad Abdulghani, 3241, Ishbiliyah, Riyadh 13225, Saudi Arabia
  //RFBA7449، 7449 القوسة، 2999، حي اشبيلية، Riyadh 13225,  Saudi Arabia

  List<String> parts = address.toString().split(',');
  parts = parts + address.toString().split('،');
  //String trimedAddress = parts[2] + parts[3];
  print(parts);
  print("parttsssss ${parts.length}");
  print("parttsssss $parts");

return parts[1]; 
  }

  static Map<DocumentSnapshot<Object?>, double> getnearby(
      clat, clag, List<DocumentSnapshot> rest) {
    Map<DocumentSnapshot, double> distance = {};
    rest.forEach((element) {
      final double latitude = double.parse(element.get("Lat"));
      final double longitude = double.parse(element.get("Long"));
      double dodo = (Geolocator.distanceBetween(clat, clag, latitude, longitude)) / 1000;
      dodo=double.parse(dodo.toStringAsFixed(1));
      if (dodo <= 40  && getopenedclosed(element.get("StartTime"), element.get("EndTime")) ) {
        distance[element] = dodo;
      }
    });
        distance = SplayTreeMap<DocumentSnapshot, double>.from(
        distance, (k1, k2) => distance[k1]!.compareTo(distance[k2]!));
    
    return distance;
  }

  static bool getopenedclosed(String start, String end) {
    
    DateFormat formatter = DateFormat('HH:mm a'); // Define the formatter
    var now = DateTime.now();
    DateTime startTime =DateTime(now.year,now.month,now.day,formatter.parse(start).hour,formatter.parse(start).minute);
    DateTime endTime = DateTime(now.year,now.month,now.day,formatter.parse(end).hour,formatter.parse(end).minute);;
    
    print("nowww $now");
    print("start : $startTime end : $endTime");
    print("is before  : ${now.isBefore(endTime)}");
    print("is after  : ${now.isAfter(startTime)}");
    if (now.isAfter(startTime) && now.isBefore(endTime)) {
      return true;
    } else {
      return false;
    }
  }

  

 


}