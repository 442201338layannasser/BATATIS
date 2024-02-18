import 'package:batatis/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class CustomTextFiled extends StatefulWidget {
  final String text;
  String type;
  final TextEditingController controller;
  double width, height;
  String allowed;
  int maxLen;
  bool Ispassword;
  final Function(String) onLostFocus;
  String? Function(String?, String?) isvalid;
  var value;
  bool iseditable;
  String initialValue;
  final FocusNode? focusNode; //added

  CustomTextFiled({
    required this.text,
    required this.controller,
    this.type = "default",
    this.width = 0.36,
    this.height = 0.1,
    this.maxLen = 25,
    this.allowed = r'[A-Za-z0-9]',
    this.Ispassword = false,
    this.iseditable = true,
    this.value = null,
    required this.isvalid,
    required this.onLostFocus,
    this.initialValue="test", 
    this.focusNode, // Added 
    
  });

  @override
  _CustomTextFiledState createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  String message = "";
  static var validate = "";

  @override
  void initState() {
    super.initState();
     if(widget.value != null)
      {widget.controller.text =  widget.value.toString();
      widget.value = null ;}
    widget.controller.addListener(() {
      setState(() {
        // Validate the input and update the message when the text changes
        message = widget.isvalid(widget.controller.text, widget.text) ?? "";
      });
    });
  }

  // @override
  // void dispose() {
  //   widget.controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
     
    print(Batatis.Swidth);
    switch (widget.type) {
      case "large":
        {
          return baseTextField(widget.width, widget.height, widget.controller);
        }
      case "small":
        {
          return baseTextField(0.22, 0.09, widget.controller);
        }
      case "profile":
        {
          return baseTextField(widget.width, widget.height, widget.controller);
        }
      default:
        {
          return baseTextField(widget.width, widget.height, widget.controller);
        }
    }
  }

  Widget baseTextField(
      double width, double height, TextEditingController controller) {
   
    return Container(
      padding:EdgeInsets.fromLTRB(10, 0, 0, 0) ,
      width: width * Batatis.Swidth,
      height: height * Batatis.Sheight,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: grey_light,
        borderRadius: BorderRadius.circular(30),
       
      ),
      child: Stack(
        children: [
          TextFormField(
            inputFormatters: [
              FilteringTextInputFormatter(RegExp(widget.allowed), allow: true),
            ],
          // initialValue :d ,  // widget.value == null ? "null" : widget.value,
            readOnly: !widget.iseditable,
            obscureText: widget.Ispassword,
            maxLength: widget.maxLen,
            controller: controller,
             focusNode: widget.focusNode,
            decoration: InputDecoration(
              counterText: '',
              hintText: widget.text,
              hintStyle: TextStyle(
                color: Color.fromRGBO(127, 128, 129, 1),
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
              border: InputBorder.none,
              errorStyle: TextStyle(
                color: Colors.red,
                fontSize: 10,
              ),
            ),
            validator: (text) { 
             // return validate;
              if (widget.isvalid(text, widget.text)==null) 
              return null;
              else 
              //return "Required field"; 
                      setState(() {
                        if (message=="")
                        message = "Required field"; 
                        });
                  return "";
            },
            onEditingComplete: () {
              
              // This callback is triggered when the field loses focus
              if (widget.onLostFocus != null) {
                widget.onLostFocus(controller.text);
              }
            },
          ),
          
          
        Transform.translate(

            offset: Offset(15, 40), // Adjust the Y-offset to move the text upwards
            child: Text(
              message, // Display the message here
              style: TextStyle(
                color: Colors.red, // Customize the text color
                fontSize: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}





















/*
class CustomTextFiled extends StatelessWidget{
final String text ; // the text for text widgets 
String type ;       // type to pick which one to use 
TextEditingController Controller;
double width , height ; 
String allowed ; 
int maxLen ;
bool Ispassword ; 
 final Function(String) onLostFocus;
String message=" ";
String? Function(String? , String ? ) isvaild ;

CustomTextFiled({required this.text,required this.Controller , this.type = "default" , required this.isvaild  ,this.width = 0.36 ,this.height =0.1 , this.maxLen = 25, this.allowed = r'[A-Za-z0-9]',this.Ispassword = false,  required this.onLostFocus,   });
  
  Widget build(BuildContext context){
    print(Batatis.Swidth);
    switch (type){ 
      case "large":{return baseTextfiled(width , height ,Controller,);}
      case "small":{return baseTextfiled(0.22 , 0.09 ,Controller,);}
      default:{ return baseTextfiled(width , height ,Controller,);}
    }
  }
  

  
  Widget baseTextfiled(width , height ,Controller ){

    return Container(
              width:  width * Batatis.Swidth,
              height: height * Batatis.Sheight , 
              margin: EdgeInsets.all(10.0),
              decoration: 
              BoxDecoration(
                color:grey_light ,
                borderRadius:  BorderRadius.circular(30)
              ),
                child :
                TextFormField(
                  inputFormatters: [
              FilteringTextInputFormatter(RegExp(allowed), allow: true)
            ],

            obscureText: Ispassword , 
                  maxLength: maxLen ,
                    controller: Controller ,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: this.text,
                      hintStyle: TextStyle(color: Color.fromRGBO(127, 128, 129, 1),fontWeight: FontWeight.w500,fontSize: 16.0),
                      border : InputBorder.none
                        ),
                      
                    validator:(text) {
                      return isvaild(text ,this.text) ;
                    },));
  } */