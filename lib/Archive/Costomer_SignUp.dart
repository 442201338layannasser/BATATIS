import 'package:flutter/material.dart';
import '/Customer_Widgets/All_customer_Widgets.dart';
import '/RegExp.dart';
import '/Controller.dart';

 class CSignUp extends StatefulWidget{
   const CSignUp({super.key});

   @override
   State<CSignUp> createState() => CSignUpState();
 }

 class CSignUpState extends State<CSignUp>{
  //class CSignUp extends StatelessWidget{
  static String errorMsg = " "; 
  final _CsignupKey = GlobalKey<FormState>();
  
  var values = {
      'First Name': "", 
      'Last Name': "", 
      'phonenumber': "",
      'Email' : "",
      'password': "", 
    };

List<TextEditingController> myController = List.generate(6, (i) => TextEditingController());

Widget build(BuildContext context){
  
  return   Scaffold( 
    appBar: AppBar(),
    body:SingleChildScrollView(
      child: Center(
      child: Form(
        key: _CsignupKey,
        child: 
      Column(
        mainAxisAlignment : MainAxisAlignment.center,
        children: [
          CustomText(text: "Sign In", type: "heading",),
          Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [CustomTextFiled(text:"  First name" ,Controller :myController[0],isvaild: Controller.EmptyValidation,type: "small",maxlen: 15,allowed:regonlychar , ), 
                          CustomTextFiled(text:"  Last name" ,Controller :myController[1],isvaild: Controller.EmptyValidation,type: "small",maxlen: 15,allowed:regonlychar )],),
          CustomTextFiled(text:"  E-mail" ,Controller :myController[2],isvaild: Controller.EmailValidation ,allowed:r'[a-zA-Z0-9@._-]') ,  
          CustomTextFiled(text:"  Phone number" ,Controller :myController[3],isvaild: Controller.EmptyValidation , maxlen: 10,allowed: regonlynumber, ) ,

          CustomTextFiled(text:"  Password" ,Controller :myController[4],isvaild: Controller.EmptyValidation , allowed: regeverything, Ispassword: true,),
          CustomTextFiled(text:"  Re-Password" ,Controller :myController[5],isvaild:Controller.EmptyValidation, allowed: regeverything, Ispassword: true, ) ,
          Container(child: CustomText(text :errorMsg ,color: red,fontSize: 18, ),),
          CustomButton(text:"Sign up",onPressed:(){Controller.Csignup(_CsignupKey ,values ,setState , myController , context);} , type:"confirm"),             
        ],
      ),
    ))));

}
}
