// class ToAddress(){




// }
// import 'package:geocoding/geocoding.dart';

// void getadd()async{
// List<Placemark> placemarks = await placemarkFromCoordinates(45 , 24);
// String palcename = placemarks.first.administrativeArea.toString() + ", " +  placemarks.first.street.toString();
// print("placeename " + palcename);
// }
import 'dart:convert';
import 'package:batatis/RestaurantBranch_Screens/All_RestaurantBranch_Screens.dart';
import 'package:http/http.dart' as http;

Future<String> getAddressFromCoordinatesUsingGoogleMapsAPI(double latitude, double longitude) async {
  final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyAdZRQZEyjfMF83zsHFOA875MQxkn9xFAs';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print("sustatusssss  2000");
    final json = jsonDecode(response.body);
    print(json);
    final results = json['results'] ;
    print(results);
    if (results.isNotEmpty) {
      print("addddresss" + results.first['formatted_address'].toString());
    RBRegisterThird.RBR3Set!((){
        RBRegisterThird.Address = results.first['formatted_address'].toString() ; 
    });
      RBFirstSignUpState.values["address"] = results.first['formatted_address'];
      RBFirstSignUpState.values["lat"] = latitude.toString();
      RBFirstSignUpState.values["long"] = longitude.toString();

      return results.first['formatted_address'];
    } else {
      print("unknown");
      return 'Unknown address';
    }
  } else {
    print("exception");
    throw Exception('Failed to fetch address from Google Maps API');
  }

}


Future<String> getAddressFromCoordinatesUsingGoogleMapsAPI2(double latitude, double longitude) async {
  final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=AIzaSyAdZRQZEyjfMF83zsHFOA875MQxkn9xFAs';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print("sustatusssss  2000");
    final json = jsonDecode(response.body);
    print(json);
    final results = json['results'] ;
    print(results);
    if (results.isNotEmpty) {
      print("addddresss" + results.first['formatted_address'].toString());
// RBeditprofileState.set((){
//   RBeditprofileState.address =  results.first['formatted_address'];
// });
      return results.first['formatted_address'];
    } else {
      print("unknown");
      return 'Unknown address';
    }
  } else {
    print("exception");
    throw Exception('Failed to fetch address from Google Maps API');
  }

}
Future<Map<String, double>> getCoordinatesFromAddressUsingGoogleMapsAPI(String address) async {
  final apiKey = 'AIzaSyAdZRQZEyjfMF83zsHFOA875MQxkn9xFAs'; // Replace with your API key
  final encodedAddress = Uri.encodeQueryComponent(address);
  final url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$apiKey';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      final results = json['results'];

      if (results.isNotEmpty) {
        final location = results.first['geometry']['location'];
        final latitude = location['lat'].toDouble();
        final longitude = location['lng'].toDouble();

        // Assuming you have a callback function to update UI or store the coordinates
        // RBRegisterThird.RBR3Set(() {
        //   RBRegisterThird.Latitude = latitude;
        //   RBRegisterThird.Longitude = longitude;
        // });

        return {'latitude': latitude, 'longitude': longitude};
      } else {
        print("Unknown address");
        throw Exception('Unknown address');
      }
    } else {
      print("Failed to fetch coordinates. Status code: ${response.statusCode}");
      throw Exception('Failed to fetch coordinates from Google Maps API');
    }
  } catch (e) {
    print("Exception: $e");
    throw Exception('Error occurred while fetching coordinates');
  }
}

