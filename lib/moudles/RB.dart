import 'dart:async';

import 'package:batatis/RestaurantBranch_Screens/viewMenu.dart';
import 'package:batatis/RestaurantBranch_Widgets/All_RB_Widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:batatis/Routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RB {
  late String resturantName;
  late String crNumber;
  late String resturantType;
  late String startTime;
  late String endTime;
  late String fee;
  late String address;
  late String lat;
  late String long;
  late String bankName;
  late String iban;
  late String beneficiaryName;
  RB.basic();
  RB.obj(
      String this.resturantName,
      String this.crNumber,
      String this.resturantType,
      String this.startTime,
      String this.endTime,
      String this.fee,
      String this.address,
      String this.lat,
      String this.long,
      String this.bankName,
      String this.iban,
      String this.beneficiaryName);
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<List<String>> getResturantCategories() async {
    try {
      // Reference to the Firestore collection
      CollectionReference collection =
          FirebaseFirestore.instance.collection('data');

      // Get the document by its ID
      DocumentSnapshot documentSnapshot =
          await collection.doc("IXQcurxTrK8VBofB22Cq").get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Extract the data fields as a Map
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Extract and assign the values to the list as strings
        List<String> categories =
            data.values.map((value) => value.toString()).toList();
        // print("Document exists.");
        return categories; // Return the list of categories
      } else {
        // Document with the specified ID doesn't exist
        print("Document with ID IXQcurxTrK8VBofB22Cq does not exist.");
        return []; // Return an empty list or handle the error case as needed
      }
    } catch (e) {
      print("Error getting document fields: $e");
      return []; // Return an empty list or handle the error case as needed
    }
  }

  static Future<List<String>> getMenuItemCategories() async {
    try {
      // Reference to the Firestore collection
      CollectionReference collection =
          FirebaseFirestore.instance.collection('data');

      // Get the document by its ID
      DocumentSnapshot documentSnapshot =
          await collection.doc("KmECLvg5bkHZdT5afEhk").get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Extract the data fields as a Map
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        // Extract and assign the values to the list as strings
        List<String> categories =
            data.values.map((value) => value.toString()).toList();
        //print("Document exists.");
        return categories; // Return the list of categories
      } else {
        // Document with the specified ID doesn't exist
        print("Document with ID KmECLvg5bkHZdT5afEhk does not exist.");
        return []; // Return an empty list or handle the error case as needed
      }
    } catch (e) {
      print("Error getting document fields: $e");
      return []; // Return an empty list or handle the error case as needed
    }
  }

  static Future<bool> doesEmailExist(String email) async {
    try {
      List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      // If the signInMethods list is not empty, it means the email exists.
      return signInMethods.isNotEmpty;
    } catch (e) {
      // If an error occurs, it means the email doesn't exist.
      return false;
    }
  }

  static Future<String> getparent(String subcol) async {
    try {
      var ref;
      bool flag = true;
      var parent;
      var o = await FirebaseFirestore.instance.collectionGroup("Branches");
      o.get().then((querySnapshot) {
        print("lennnnn in RB" + querySnapshot.docs.length.toString());
        // Process the documents here
        querySnapshot.docs.forEach((element) async {
          print(element.id);
          if (flag && element.id == subcol) {
            ref = element.reference;
            print("yep right here");
            print(element.reference.path.toString());
            parent = await element.reference.path.toString().split('/');
            print(parent[1]);
            viewMenuState.RestaurantId = parent[1];
            return parent[1];
            flag = false;
          }
        });
      });
      print(parent[1].toString() + "before");
      return parent[1];
    } catch (e) {
      print("error happen " + e.toString());
      return " error ";
    }
  }

/*
Future<User?> registerWithEmailAndPassword(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return FirebaseAuth.instance.currentUser;
  } catch (e) {
    print('Error registering user: $e');
    // Handle registration error as needed (e.g., show an error message).
    return null;
  }
}*/

/*
Future<void> addRestaurantBranch({
  required String name,
  required String crNumber,
  required String type,
  required String startTime,
  required String endTime,
  required String city,
  required String neighborhood,
  required String bankName,
  required String iban,
  required String beneficiaryName,
}) async {
  try {
    final restaurantRef = _firestore.collection('Restaurants').doc(crNumber);
    final branchesRef = restaurantRef.collection('Branches');

    // Get the UID of the authenticated user
    String? uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      await branchesRef.doc().set({
        'UID': uid, // Store the UID in the document
        'Name': name,
        'Type': type,
        'StartTime': startTime,
        'EndTime': endTime,
        'City': city,
        'Neighborhood': neighborhood,
        'BankName': bankName,
        'IBAN': iban,
        'BeneficiaryName': beneficiaryName,
      });

      print('Branch added successfully');
    } else {
      // Handle the case where the user is not authenticated
      print('User is not authenticated');
    }
  } catch (e) {
    print('Error adding restaurant branch: $e');
    // Handle the error as needed (e.g., show an error message).
  }
}*/

// Function to hash the password using SHA-256

  Future<void> addRestaurantBranch({
    //need aploaf the logo //i suggest changing the collection name Restuatants->Branches
    required String email,
    required String password,
    required String resturantName,
    required String crNumber,
    required String resturantType,
    required String startTime,
    required String endTime,
    required String fee,
    required String address,
    required String lat,
    required String long,
    required String bankName,
    required String iban,
    required String beneficiaryName,
  }) async {
    try {
      // Register the restaurant using Firebase Authentication
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Access the user's UID
      final User? user = userCredential.user;
      FirebaseFirestore _firestore = FirebaseFirestore.instance;

      if (user != null) {
        // You can access the UID using user.uid
        final uid = user.uid;

        // Now you can use the UID to link additional data to this user in Firestore
        final restaurantRef = _firestore.collection('Restaurants').doc(uid);

        PhotoPicker.uploadBytes("/Restaurants/$uid/Logo");

        // Hash the password before storing it
        final hashedBankName = bankName;
        final hashedIBAN = iban;
        final hashedBeneficiaryName = beneficiaryName;

        await restaurantRef.set({
          'Resturant Name': resturantName,
          'CRnumber': crNumber,
          'Resturant Type': resturantType,
          'StartTime': startTime,
          'EndTime': endTime,
          'Address': address,
          'Fee': fee,
          'Lat': lat,
          'Long': long,
          'BankName': hashedBankName,
          'IBAN': hashedIBAN,
          'BeneficiaryName': hashedBeneficiaryName,
        });

        print('Restaurant branch added successfully');
      }
    } catch (e) {
      print('Error adding restaurant branch: $e');
      // Handle the error as needed (e.g., show an error message).
    }
  }

  static getRest(RestID) async {
    var RestRef = _firestore.collection('Restaurants');
    var TheRest = await RestRef.doc(RestID).get();
    RB Restaurant;
    if (TheRest.exists) {
      print("resturant exist $RestID");
      var resturantName = TheRest.get("Resturant Name");
      var crNumber = TheRest.get("CRnumber");
      var resturantType = TheRest.get("Resturant Type");
      var startTime = TheRest.get("StartTime");
      var endTime = TheRest.get("EndTime");
      var fee = TheRest.get("Fee");
      var address = TheRest.get("Address");
      var lat = TheRest.get("Lat");
      var long = TheRest.get("Long");
      var bankName = ""; //TheRest.get("Resturant Name");
      var iban = ""; // TheRest.get("Resturant Name");
      var beneficiaryName = ""; // TheRest.get("Resturant Name");
      Restaurant = RB.obj(resturantName, crNumber, resturantType, startTime,
          endTime, fee, address, lat, long, bankName, iban, beneficiaryName);
      return Restaurant;
    } else {
      print("resturant nonnnnnexist $RestID");
    }
    return null;
  }

  factory RB.fromJson(Map<String, dynamic> json) {
    return RB.obj(
      json["resturantName"],
      json["crNumber"],
      json["resturantType"],
      json["startTime"],
      json["endTime"],
      json["fee"],
      json["address"],
      json["lat"],
      json["long"],
      json["bankName"],
      json["iban"],
      json["beneficiaryName"],
    );
  }
  Map<String, dynamic> toJson() => {
        "resturantName": resturantName,
        "crNumber": crNumber,
        "resturantType": resturantType,
        "startTime": startTime,
        "endTime": endTime,
        "fee": fee,
        "address": address,
        "lat": lat,
        "long": long,
        "bankName": bankName,
        "iban": iban,
        "beneficiaryName": beneficiaryName,
      };
/*
  Future<void> addRestaurantBranch({
    required String email,
    required String password,
    required String resturantName,
    required String crNumber,
    required String resturantType,
    required String startTime,
    required String endTime,
    required String address,
    required String lat,
    required String long,
    required String bankName,
    required String iban,
    required String beneficiaryName,
  }) async {
    try {
      //print("printo");

      // Register the restaurant using Firebase Authentication
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("printo");

      // Access the user's UID
      final User? user = userCredential.user;
        FirebaseFirestore _firestore = FirebaseFirestore.instance;
      if (user != null) {
        // You can access the UID using user.uid
        final uid = user.uid;
        print("auth uid " + uid);

        // Now you can use the UID to link additional data to this user in Firestore
        final restaurantRef =
            _firestore.collection('Restaurants').doc(crNumber);
        final restaurantDoc = await restaurantRef.get();

        if (restaurantDoc.exists) {
          PhotoPicker.uploadBytes(crNumber, uid, "Logo");
          // Restaurant with the given CRnumber already exists, add a branch
          final branchesRef = restaurantRef.collection('Branches').doc(uid);

          // Hash the password before storing it
          final hashedBankName = hash(bankName);
          final hashedIBAN = hash(iban);
          final hashedBeneficiaryName = hash(beneficiaryName);

          await branchesRef.set({
            'StartTime': startTime,
            'EndTime': endTime,
            'Address': address,
            'lat':lat,
            'long':long,
            'BankName': hashedBankName,
            'IBAN': hashedIBAN,
            'BeneficiaryName': hashedBeneficiaryName,
          });
          print('Branch added successfully to an existing restaurant');
        } else {
          PhotoPicker.uploadBytes(crNumber, uid, "Logo");
          // Restaurant with the given CRnumber doesn't exist, create a new one
          await restaurantRef.set({
            //'CRnumber': crNumber, we can get if from the id of resturant documents
            'Resturant Name':
                resturantName, // Initialize an empty "Branches" array
            'Resturant Type': resturantType,
          });

          // Add the branch as a field inside the "Branches" collection with UID as the document ID
          final branchesRef = restaurantRef.collection('Branches').doc(uid);

          // Hash the password before storing it
          final hashedBankName = hash(bankName);
          final hashedIBAN = hash(iban);
          final hashedBeneficiaryName = hash(beneficiaryName);

          await branchesRef.set({
            'StartTime': startTime,
            'EndTime': endTime,
            'Address': address,
            'lat':lat,
            'long':long,
            'BankName': hashedBankName,
            'IBAN': hashedIBAN,
            'BeneficiaryName': hashedBeneficiaryName,
          });
          print('New restaurant and branch added successfully');
        }
      }
    } catch (e) {
      print('Error adding restaurant branch: $e');
      // Handle the error as needed (e.g., show an error message).
    }}*/

  static Future<bool> isPasswordCorrect(String email, String password) async {
    try {
      // Sign in the user with the email and password.
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If the sign in was successful, it means the password is correct.
      return true;
    } catch (e) {
      // If an error occurs, it means the password is incorrect.
      return false;
    }
  }

/*
  try {
    final restaurantRef = _firestore.collection('Restaurants').doc(crNumber);
    final restaurantDoc = await restaurantRef.get();

    if (restaurantDoc.exists) {
      // Restaurant with the given CRnumber already exists, add a new branch
      final branchesRef = restaurantRef.collection('Branches').doc();

       // Hash the password before storing it
       final hashedPassword = hash(password);
       final hashedBankName=hash(bankName);
       final hashedIBAN=hash(iban);
       final hashedbeneficiaryName=hash(beneficiaryName);

      await branchesRef.set({
        'Email': email,
        'Password': hashedPassword,
        'Name': name,
        'Type': type,
        'StartTime': startTime,
        'EndTime': endTime,
        'City': city,
        'Neighborhood': neighborhood,
        'BankName': hashedBankName,
        'IBAN': hashedIBAN,
        'BeneficiaryName': hashedbeneficiaryName,
      });
      print('Branch added successfully to existing restaurant');
    } else {
      // Restaurant with the given CRnumber doesn't exist, create a new one
      await restaurantRef.set({
        'Email': email,
        //'Password': hash(password),
        'Name': name,
        'CRnumber': crNumber,
        'Type': type,
        'StartTime': startTime,
        'EndTime': endTime,
        'City': city,
        'Neighborhood': neighborhood,
        'BankName': hash(bankName),
        'IBAN': hash(iban),
        'BeneficiaryName': hash(beneficiaryName),
      });
      print('New restaurant added successfully');
    }
  } catch (e) {
    print('Error adding restaurant branch: $e');
    // Handle the error as needed (e.g., show an error message).
  }
}*/

  Future<String?> getRestaurantName(String uid) async {
    try {
      final DocumentSnapshot snapshot =
          await _firestore.collection('Restaurants').doc(uid).get();

      if (snapshot.exists) {
        return snapshot['Resturant Name'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting restaurant name: $e');
      return null;
    }
  }

  Future<String?> getRestaurantAddress(String uid) async {
    try {
      final DocumentSnapshot snapshot =
          await _firestore.collection('Restaurants').doc(uid).get();

      if (snapshot.exists) {
        return snapshot['Address'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting restaurant address: $e');
      return null;
    }
  }

  Future<String?> getRestaurantStartTime(String uid) async {
    try {
      final DocumentSnapshot snapshot =
          await _firestore.collection('Restaurants').doc(uid).get();

      if (snapshot.exists) {
        return snapshot['StartTime'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting restaurant start time: $e');
      return null;
    }
  }

  Future<String?> getRestaurantEndTime(String uid) async {
    try {
      final DocumentSnapshot snapshot =
          await _firestore.collection('Restaurants').doc(uid).get();

      if (snapshot.exists) {
        return snapshot['EndTime'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting restaurant end time: $e');
      return null;
    }
  }

  Future<String?> getRestaurantDeliveryFee(String uid) async {
    try {
      final DocumentSnapshot snapshot =
          await _firestore.collection('Restaurants').doc(uid).get();

      if (snapshot.exists) {
        return snapshot['Fee'] as String?;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting restaurant fee: $e');
      return null;
    }
  }

  static Future<void> setPassword(String userId, String newPassword, context) async {
    try {
      // Get the user reference using the user's ID
      User? user = await FirebaseAuth.instance.authStateChanges().first;

      if (user != null) {
        // Change the user's password
        await user.updatePassword(newPassword);
        print('Password updated successfully.using');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password changed successfully'),
              backgroundColor: Colors.green,
            ),
          );
      } else {
        print('User not found.');
      }
    } catch (e) {
      print('Error updating password: $e');
      // Handle the error appropriately
    }
  }

  static Future<void> setcr(String userId, String newcr) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference restaurantsCollection =
          FirebaseFirestore.instance.collection('Restaurants');

      // Get the document reference for the specific restaurant using the userId
      DocumentReference restaurantDoc = restaurantsCollection.doc(userId);

      // Update the "Restaurant Name" field
      await restaurantDoc.update({
        'CRnumber': newcr,
      });

      print('Restaurant cr updated successfully.');
    } catch (e) {
      print('Error updating restaurant cr: $e');
      // Handle the error appropriately
    }
  }

  static Future<void> settype(String userId, String newtype) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference restaurantsCollection =
          FirebaseFirestore.instance.collection('Restaurants');

      // Get the document reference for the specific restaurant using the userId
      DocumentReference restaurantDoc = restaurantsCollection.doc(userId);

      // Update the "Restaurant Name" field
      await restaurantDoc.update({
        'Resturant Type': newtype,
      });

      print('Restaurant type updated successfully.');
    } catch (e) {
      print('Error updating restaurant type: $e');
      // Handle the error appropriately
    }
  }

  static Future<void> setRestaurantName(
      String userId, String newRestaurantName) async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference restaurantsCollection =
          FirebaseFirestore.instance.collection('Restaurants');

      // Get the document reference for the specific restaurant using the userId
      DocumentReference restaurantDoc = restaurantsCollection.doc(userId);

      // Update the "Restaurant Name" field
      await restaurantDoc.update({
        'Resturant Name': newRestaurantName,
      });

      print('Restaurant name updated successfully.');
    } catch (e) {
      print('Error updating restaurant name: $e');
      // Handle the error appropriately
    }
  }

  static Future<void> setBankName(String userId, String newBankName) async {
    try {
      CollectionReference restaurantsCollection =
          FirebaseFirestore.instance.collection('Restaurants');
      DocumentReference restaurantDoc = restaurantsCollection.doc(userId);
      await restaurantDoc.update({
        'BankName': newBankName,
      });
      print('Bank name updated successfully.');
    } catch (e) {
      print('Error updating Bank name: $e');
      // Handle the error appropriately
    }
  }

  static Future<void> setIban(String userId, String newIban) async {
    try {
      CollectionReference restaurantsCollection =
          FirebaseFirestore.instance.collection('Restaurants');
      DocumentReference restaurantDoc = restaurantsCollection.doc(userId);
      await restaurantDoc.update({
        'IBAN': newIban,
      });
      print('IBAN updated successfully.');
    } catch (e) {
      print('Error updating IBAN : $e');
      // Handle the error appropriately
    }
  }

  static Future<void> setBeneficiaryName(String userId, String newIban) async {
    try {
      CollectionReference restaurantsCollection =
          FirebaseFirestore.instance.collection('Restaurants');
      DocumentReference restaurantDoc = restaurantsCollection.doc(userId);
      await restaurantDoc.update({
        'BeneficiaryName': newIban,
      });
      print('Beneficiary Name updated successfully.');
    } catch (e) {
      print('Error updating Beneficiary Name : $e');
      // Handle the error appropriately
    }
  }

  static Future<void> setFee(String userId, String newFee) async {
    try {
      CollectionReference restaurantsCollection =
          FirebaseFirestore.instance.collection('Restaurants');
      DocumentReference restaurantDoc = restaurantsCollection.doc(userId);
      await restaurantDoc.update({
        'Fee': newFee,
      });
      print('Fee updated successfully.');
    } catch (e) {
      print('Error updating fee : $e');
      // Handle the error appropriately
    }
  }

  static Future<void> setStartTime(String userId, String newStartTime) async {
    try {
      CollectionReference restaurantsCollection =
          FirebaseFirestore.instance.collection('Restaurants');
      DocumentReference restaurantDoc = restaurantsCollection.doc(userId);
      await restaurantDoc.update({
        'StartTime': newStartTime,
      });
      print('Start Time updated successfully.');
    } catch (e) {
      print('Error updating start time : $e');
      // Handle the error appropriately
    }
  }

  static Future<void> setEndTime(String userId, String newEndTime) async {
    try {
      CollectionReference restaurantsCollection =
          FirebaseFirestore.instance.collection('Restaurants');
      DocumentReference restaurantDoc = restaurantsCollection.doc(userId);
      await restaurantDoc.update({
        'EndTime': newEndTime,
      });
      print('End Time updated successfully.');
    } catch (e) {
      print('Error updating End Time : $e');
      // Handle the error appropriately
    }
  }
}

class menu {
  String RestaurantId;
  //int idItem =0;
  final String Name;
  final String description;
  final String price;
  final String Cval;

  /// final String itemPic;

  menu({
    required this.RestaurantId,
    required this.Cval,
    /*required this.itemPic,*/ required this.Name,
    required this.description,
    required this.price,
  });

  final FirebaseFirestore db = FirebaseFirestore.instance;

  // CollectionReference Restaurants =  db.collection('Restaurants').doc(Rid).collection(RbID).doc('menu').collection('items');
  Future<void> addItem(setState, context) async {
    print("RestaurantId In add item " + RestaurantId.toString());
    print(RestaurantId.toString());
    CollectionReference Restaurants =
        await db.collection('Restaurants').doc(RestaurantId).collection('menu');

    print("resturants to string in add item " + Restaurants.toString());
    Restaurants.get().then((QuerySnapshot) {
      String Iid = Restaurants.doc().id;

      return Restaurants.doc(Iid).set({
        'Name': Name,
        'description': description,
        'price': price,
        'category': Cval,
      }).then((value) {
        PhotoPicker.uploadBytes("/Restaurants/$RestaurantId/$Iid");
        print("additem photo path  /Restaurants/$RestaurantId/$Iid");
        print("item Added");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("the menu item is Added"),

            backgroundColor:
                Colors.green, // Customize the Snackbar's appearance.
          ),
        );
        moveRoute(context, '/RBHomePageM');
      }).catchError((error) => print("Failed to add item: $error"));
    });
  }

  //   int count =0  ;

  //   Future<int> getDocumentCount() async {
  //   try {
  //     QuerySnapshot snapshot = await FirebaseFirestore.instance
  //         .collection('Restaurants').doc('3').collection('B1').doc('menu').collection('items') // Replace with your collection name
  //         .get();

  //      count = snapshot.size;
  //     // print(count);
  //     return count;
  //   } catch (e) {
  //     print('Error: $e');
  //     return 0; // Handle error graceful
}
