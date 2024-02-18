import 'dart:io';
import 'package:batatis/RestaurantBranch_Screens/RBRegisterSecond.dart';
import 'package:batatis/moudles/RB.dart';
import 'package:flutter/material.dart';
import 'package:batatis/Routes.dart';
import 'All_RestaurantBranch_Screens.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '/RegExp.dart';
import '/Controller.dart';
import 'package:batatis/RestaurantBranch_Widgets/All_RB_Widgets.dart';

import 'All_RestaurantBranch_Screens.dart';

class RBRegisterSecond extends StatefulWidget {
  RBRegisterSecond({super.key});

  @override
  State<RBRegisterSecond> createState() => RBSecondSignUpState();
}

class RBSecondSignUpState extends State<RBRegisterSecond> {
  // final String assetName = 'assets/image.svg';

  static String errorMsg = " ";
  final _RBsignupKey2 = GlobalKey<FormState>();
  static String val = " Restaurant Category";

  List<String> listOfCategory = []; // Initialize with an empty list

  @override
  void initState() {
    super.initState();
    RBFirstSignUpState.values['type'] =
        val; // Initialize 'type' with the initially selected value.
  }

  Future<void> fetchAndSetCategories() async {
    try {
      List<String> categories = await RB.getResturantCategories();
      setState(() {
        listOfCategory = categories;
        categories.sort((a, b) => a.compareTo(b));
        listOfCategory.remove('Other');
        listOfCategory.add('Other');
      });
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchAndSetCategories();

    //  print("bulidooooo");
    //print(listOfCategory);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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

                        SizedBox(
                            width: 18), // Add horizontal space between icons
                        SvgPicture.asset('assets/Images/cArrow.svg'),
                        SizedBox(
                            width: 18), // Add horizontal space between icons
                        Column(children: <Widget>[
                          SvgPicture.asset('assets/Images/RB_cFileSearch.svg'),
                          CustomText(
                              text: "Resturant Info", type: "Subheading1W"),
                        ]),
                        SizedBox(
                            width: 18), // Add horizontal space between icons
                        SvgPicture.asset('assets/Images/Arrow.svg'),
                        SizedBox(
                            width: 18), // Add horizontal space between icons
                        Column(children: <Widget>[
                          SvgPicture.asset('assets/Images/RB_Branch.svg'),
                          CustomText(text: "Branch Info", type: "Subheading1W"),
                        ]),
                        SizedBox(
                            width: 18), // Add horizontal space between icons
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
                  key: _RBsignupKey2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFiled(
                        text: "Restaurant Name",
                        controller: RBFirstSignUpState.myRBController[3],
                        isvalid: Controller.StringValidation,
                        maxLen: 15,
                        allowed: regonlycharandspacec,
                        onLostFocus: (text) {
                          // Add your code here to handle the message when the field loses focus
                          print("Field lost focus: $text");
                        },
                      ),
                      CustomTextFiled(
                        text: "Commercial Registration Number",
                        controller: RBFirstSignUpState.myRBController[4],
                        isvalid: Controller.CRnumberlength,
                        maxLen: 10,
                        allowed: regonlynumber,
                        onLostFocus: (text) {
                          // Add your code here to handle the message when the field loses focus
                          print("Field lost focus: $text");
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Category :",
                                    color: Color.fromRGBO(127, 128, 129, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  DropdownMenuWidget(
                                    items: listOfCategory,
                                    selectedValue: val,
                                    setState: setState,
                                    onChanged: (newValue) {
                                      setState(() {
                                        val = newValue;
                                        RBFirstSignUpState.values['type'] = val;
                                        const TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.0,
                                        );
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 45),
                                  CustomText(
                                    text: "Fee :",
                                    color: Color.fromRGBO(127, 128, 129, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  CustomTextFiled(
                                    width: 0.16,
                                    height: 0.1,
                                    text: "Fee in SR",
                                    controller:
                                        RBFirstSignUpState.myRBController[13],
                                    isvalid: Controller.deliveryfeeValidation,
                                    maxLen: 7,
                                    allowed: regonlynumberandDot,
                                    onLostFocus: (text) {
                                      // Add your code here to handle the message when the field loses focus
                                      print("Field lost focus: $text");
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),

                          //const SizedBox(width: 10), // Add horizontal space between Dropdown and Button
                          SizedBox(
                              width:
                                  20), // Adjust the space between "Category" and "Logo"

                          CustomText(
                            text: "Logo :",
                            color: Color.fromRGBO(127, 128, 129, 1),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          PhotoPicker(
                              img: Image.asset("assets/Images/img holder.jpg",
                                  width: 100, height: 100),
                              width: 100,
                              height: 100),

                          SizedBox(width: 160)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width:
                                  431), // Add horizontal space between Dropdown and Button
                          CustomButton(
                            text: "Next",
                            onPressed: () {
                              Controller.RBsignup2(
                                  _RBsignupKey2,
                                  RBFirstSignUpState.values,
                                  setState,
                                  RBFirstSignUpState.myRBController,
                                  context);
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
      ),
    );
  }
}
