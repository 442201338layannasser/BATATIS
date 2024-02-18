// class ToAddress(){




// }
// import 'package:geocoding/geocoding.dart';

// void getadd()async{
// List<Placemark> placemarks = await placemarkFromCoordinates(45 , 24);
// String palcename = placemarks.first.administrativeArea.toString() + ", " +  placemarks.first.street.toString();
// print("placeename " + palcename);
// }
///////////////////////////////////////////////////////////////////////////////////
// import 'dart:convert';
// import 'package:batatis/RestaurantBranch_Screens/All_RestaurantBranch_Screens.dart';
// import 'package:http/http.dart' as http;

// Future<String> getAddressFromCoordinatesUsingGoogleMapsAPI(double latitude, double longitude) async {
//   final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyAdZRQZEyjfMF83zsHFOA875MQxkn9xFAs';
//   final response = await http.get(Uri.parse(url));

//   if (response.statusCode == 200) {
//     print("sustatusssss  2000");
//     final json = jsonDecode(response.body);
//     print(json);
//     final results = json['results'] ;
//     print(results);
//     if (results.isNotEmpty) {
//       print("addddresss" + results.first['formatted_address'].toString());
//     RBRegisterThird.RBR3Set!((){
//         RBRegisterThird.Address = results.first['formatted_address'].toString() ; 
//     });
//       RBFirstSignUpState.values["address"] = results.first['formatted_address'];
//       RBFirstSignUpState.values["lat"] = latitude.toString();
//       RBFirstSignUpState.values["long"] = longitude.toString();

//       return results.first['formatted_address'];
//     } else {
//       print("unknown");
//       return 'Unknown address';
//     }
//   } else {
//     print("exception");
//     throw Exception('Failed to fetch address from Google Maps API');
//   }
// }