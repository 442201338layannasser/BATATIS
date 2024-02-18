import 'dart:convert';
import 'package:batatis/Costomer_Screens/OTPscreen.dart';
import 'package:batatis/Customer_Widgets/All_customer_Widgets.dart';
import 'package:batatis/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:shared_preferences/shared_preferences.dart";
import 'package:batatis/model/UserModel.dart';
///////////////notification//////////////
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthProvider extends ChangeNotifier {
  bool _issignedin = false;
  bool get issignedin => _issignedin;
  bool _isloading = false;
  bool get isloading => _isloading;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;

  AuthProvider() {
    checksignin();
  }
  Future setsignin() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _issignedin = true;
    notifyListeners();
  }

  Future setdataintodatabase(phonenumber) async {
    await FirebaseAuth.instance.signInWithCredential(phonenumber);
    try {} catch (e) {}
  }

  Future getdatafromfirestore() async {
    await _firebasefirestore
        .collection("Customers")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) {
      _userModel = UserModel(
        phonenumber: snapshot['phonenumber'],
      );
    });
  }

// Future getdatafromfirestore2() async {
//     await _firebasefirestore
//         .collection("Customers")
//         .doc("6aE6h2cAGza2p6y7Kw9lHmHNo8p2")
//         .get()
//         .then((DocumentSnapshot snapshot) {
//       _userModel = UserModel(
//         phonenumber: snapshot['phonenumber'],
//       );
//     });
//   }
  void verifyotp({
    required BuildContext context,
    required String verificationid,
    required String userotp,
    required Function onsuccess,
  }) async {
    _isloading = true;
    notifyListeners();
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationid, smsCode: userotp);
      User? user = (await _firebaseAuth.signInWithCredential(creds)).user!;

      if (user != null) {
        _uid = user.uid;
        onsuccess();
      }
      _isloading = false;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
      _isloading = false;
      notifyListeners();
    }
  }

  void checksignin() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _issignedin = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  void signinwithphonenumber(BuildContext context, String phonenumber) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phonenumber,
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
        },
        verificationFailed: (error) {
          throw Exception(error.message);
        },
        codeSent: (verificationId, forceResendingToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Otpscreen(
                  verificationId: verificationId,
                  forceResendingToken: forceResendingToken),
            ),
          );
        },
        codeAutoRetrievalTimeout: (verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  void resendotp(
      BuildContext context, String phonenumber, int? ResendingToken) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phonenumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {},
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {},
          codeAutoRetrievalTimeout: (verificationId) {},
          forceResendingToken: ResendingToken);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message.toString());
    }
  }

  Future SetSignedIn(number) async {
    var name = await getname();
   

    ////////////////////////////////sadeem///////////////////////////////////////////
    var fcmToken = await FirebaseMessaging.instance.getToken();

    print("sadeeeeeeeeeeeeeeeeeeeeeeemmmmmmmmmmmmmmmmmmm");

    await _firebasefirestore
        .collection("Customers")
        .doc(_firebaseAuth.currentUser!.uid)
        .update({'Token': fcmToken});
    print("token mobiiillleee:");
    print("eeeee" + fcmToken.toString());
     SharedPrefer.SetLogin(_firebaseAuth.currentUser!.uid, name,fcmToken, number);
//////////////////////////////////////////////////////////////////////////////////////
  }

  Future<bool> checkexistinguser(phonenum) async {
    final QuerySnapshot querySnapshot = await _firebasefirestore
        .collection('Customers')
        .where('phonenumber', isEqualTo: phonenum)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      print("hmmm number is used ");
      return true;
    } else {
      print("lucky day  number isnt used ");
      return false;
    }
  }

  Future usersignout() async {
    SharedPreferences s = await SharedPreferences.getInstance();

    await _firebaseAuth.signOut();
    _issignedin = false;
    await SharedPrefer.SetSignedOut();
    notifyListeners();
    s.clear();
  }

  Future<String> getname() async {
    var name = "Batatis customer";
    await _firebasefirestore
        .collection("Customers")
        .doc(_firebaseAuth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot) async {
      name = await snapshot.get('name');
    });
    return name;
  }

  Future saveuserdatatosp() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString(
      "user_model",
      jsonEncode(userModel.tomap()),
    );
  }

  Future SetUserLocation(String address, String lat, String long) async {
    SharedPreferences s = await SharedPreferences.getInstance();

    await s.setString("address", address);
    await s.setString("lat", lat);
    await s.setString("long", long);
  }

  static String? add = "";
  Future GetUserAddress() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    add = await s.getString("address");
  }

  // }
}
