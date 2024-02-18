import 'package:batatis/Controller.dart';
import 'package:batatis/RegExp.dart';
import 'package:batatis/RestaurantBranch_Screens/All_RestaurantBranch_Screens.dart';
import 'package:batatis/RestaurantBranch_Widgets/All_RB_Widgets.dart';
import 'package:batatis/Routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RBRegisterForth extends StatefulWidget {
  const RBRegisterForth({super.key});

  @override
  State<RBRegisterForth> createState() => RBForthSignUpState();
  //final String assetName = 'assets/image.svg';
}

class RBForthSignUpState extends State<RBRegisterForth> {
  static String errorMsg = " ";
  final _RBsignupKey4 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 100),
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
                      SvgPicture.asset('assets/Images/cArrow.svg'),
                      SizedBox(width: 18), // Add horizontal space between
                      Column(children: <Widget>[
                        SvgPicture.asset('assets/Images/RB_cCreditCard.svg'),
                        CustomText(text: "Bank Info", type: "Subheading1W"),
                      ]),
                      SizedBox(width: 10),
                    ]),
              ),
              SizedBox(height: 50),
              Form(
                key: _RBsignupKey4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //  CustomText(text: "Sign In", type: "heading",),
                    CustomTextFiled(
                      text: "Bank Name",
                      controller: RBFirstSignUpState.myRBController[7],
                      isvalid: Controller.StringValidation,
                      maxLen: 15,
                      allowed: regonlycharandspacec,
                      onLostFocus: (text) {
                        // Add your code here to handle the message when the field loses focus
                        print("Field lost focus: $text");
                      },
                    ),

                    CustomTextFiled(
                      text: "International Bank Account Number (IBAN)",
                      controller: RBFirstSignUpState.myRBController[8],
                      isvalid: Controller.ibanValidation,
                      allowed: regcharandnum,
                      onLostFocus: (text) {
                        // Add your code here to handle the message when the field loses focus
                        print("Field lost focus: $text");
                      },
                    ),

                    CustomTextFiled(
                      text: "Beneficiary Name",
                      controller: RBFirstSignUpState.myRBController[9],
                      isvalid: Controller.StringValidation,
                      maxLen: 15,
                      allowed: regonlycharandspacec,
                      onLostFocus: (text) {
                        // Add your code here to handle the message when the field loses focus
                        print("Field lost focus: $text");
                      },
                    ),

                    //  Container(child: CustomText(text :errorMsg ,color: red,fontSize: 18, ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width:
                                431), // Add horizontal space between Dropdown and Button
                        CustomButton(
                          text: "Submit",
                          onPressed: () {
                            Controller.RBsignup4(
                                _RBsignupKey4,
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
    );
  }
}
