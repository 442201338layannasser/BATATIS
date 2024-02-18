import 'dart:developer';

import 'package:batatis/RestaurantBranch_Screens/RBRegisterSecond.dart';
import 'package:batatis/RestaurantBranch_Screens/RestaurantBranch_SignIn.dart';
import 'package:batatis/RestaurantBranch_Widgets/PasswordTextFileds.dart';
import 'package:batatis/Routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/RegExp.dart';
import '/Controller.dart';
import '/RestaurantBranch_Widgets/All_RB_Widgets.dart';
import 'package:batatis/Routes.dart';

class RBRegisterFirst extends StatefulWidget {
  const RBRegisterFirst({super.key});
  //final String assetName = 'assets/image.svg';

  @override
  State<RBRegisterFirst> createState() => RBFirstSignUpState();
}

class RBFirstSignUpState extends State<RBRegisterFirst> {
  static String errorMsg = " ";
  final _RBsignupKey1 = GlobalKey<FormState>();
  static var values = {
    'email': "",
    'password': "",

    'name': "",
    'crnumber': "",
    'type': "",
    'logo': "",

    'startTime':
        '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}', // Initialize with current time
    'endTime':
        '${TimeOfDay.now().hour}:${TimeOfDay.now().minute}', // Initialize with current time
    'fee': "",
    'address': "",
    'lat': "",
    'long': "",

    'bankName': "",
    'iban': "",
    'benefName': "",
  };

  static List<TextEditingController> myRBController =
      List.generate(14, (i) => TextEditingController());

  Widget build(BuildContext context) {
    double Swidth = MediaQuery.of(context).size.width;
    double Sheight = MediaQuery.of(context).size.height;

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    void createAccount() async {
      String? email = emailController.text.trim();
      String? password = passwordController.text.trim();
      String? confirmPassword = confirmPasswordController.text.trim();

      if (email == "" || password == "" || confirmPassword == "") {
        // ignore: use_build_context_synchronously
        Global.snackBar("Please fill all the details", context, red);
        log("Please fill all the details");
      } else if (password != confirmPassword) {
        Global.snackBar("the Password does not match", context, red);
      } else {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) async {
            value.user!.sendEmailVerification();

            return value;
          });
          if (userCredential.user != null) {
            // ignore: use_build_context_synchronously
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => RBRegisterSecond()));
          }
        } on FirebaseAuthException catch (e) {
          // ignore: use_build_context_synchronously
          Global.snackBar(e.code.toString(), context, red);
          log(e.code.toString());
        }
      }
    }

    return Scaffold(
      body: Center(
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
                      SvgPicture.asset('assets/Images/Arrow.svg'),
                      SizedBox(width: 18), // Add horizontal space between icons
                      Column(children: <Widget>[
                        SvgPicture.asset('assets/Images/RB_FileSearch.svg'),
                        CustomText(
                            text: "Resturant Info", type: "Subheading1W"),
                      ]),
                      SizedBox(width: 18), // Add horizontal space between icons
                      SvgPicture.asset('assets/Images/Arrow.svg'),
                      SizedBox(width: 18), // Add horizontal space between icons
                      Column(children: <Widget>[
                        SvgPicture.asset('assets/Images/RB_Branch.svg'),
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
              SizedBox(height: 50), // Add space between icons and form

              Form(
                key: _RBsignupKey1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextFiled(
                      text: "E-mail",
                      controller: myRBController[0],
                      isvalid: Controller.EmailValidation,
                      allowed: '[a-zA-Z0-9.@]',
                      onLostFocus: (text) {
                        // Add your code here to handle the message when the field loses focus
                        print("Field lost focus: $text");
                      },
                    ),
                    CustomTextFiled(
                      text: "Password",
                      controller: myRBController[1],
                      isvalid: Controller.passValidation,
                      allowed: regeverything,
                      Ispassword: true,
                      onLostFocus: (text) {
                        // Add your code here to handle the message when the field loses focus
                        print("Field lost focus: $text");
                      },
                    ),
                    CustomTextFiled(
                      text: "Re-enter Password",
                      controller: myRBController[2],
                      isvalid: Controller.repassValidation,
                      allowed: regeverything,
                      Ispassword: true,
                      onLostFocus: (text) {
                        // Add your code here to handle the message when the field loses focus
                        print("Field lost focus: $text");
                      },
                    ),
                    SizedBox(height: 34),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 431),
                        CustomButton(
                          text: "Next",
                          onPressed: () {
                            // Add your logic here for the Next button
                            // if (_RBsignupKey1.currentState!.validate()) {
                            //   createAccount();
                            // }
                            Controller.RBsignup1(
                              _RBsignupKey1,
                              RBFirstSignUpState.values,
                              setState,
                              RBFirstSignUpState.myRBController,
                              context,
                            );
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
    );
  }
}
