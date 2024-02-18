import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class CustomTextFiled extends StatelessWidget{
final String text ; // the text for text widgets 
String type ;       // type to pick which one to use 
TextEditingController Controller;
int maxlen ; 
String allowed ; 
double width , height ; 
bool Ispassword ; 
String? Function(String? , String ? ) isvaild ;
CustomTextFiled({required this.text, required this.Controller , this.type = "default" , required this.isvaild  ,this.width = 350.0 ,this.height =50.0 , this.maxlen = 25 ,this.allowed = r'[A-Za-z0-9]',this.Ispassword = false  });
  
  Widget build(BuildContext context){
    switch (type){ 
      case "large":{return baseTextfiled(width , height ,Controller,);}
      case "small":{return baseTextfiled(160.0 , 50.0 ,Controller,);}
      default:{ return baseTextfiled(width , height ,Controller,);}
    }}
  

  Widget baseTextfiled(width , height ,Controller ){
    return Container(
              width: width,
              height: height,
              margin: const EdgeInsets.all(13.0),
              padding: const EdgeInsets.all(5.0),
              decoration: 
              BoxDecoration(
                color:grey_light ,
                borderRadius:  BorderRadius.circular(30)
              ),
                child :
                TextFormField(
                style:  const TextStyle(fontSize: 14 ,),
                inputFormatters: [
              FilteringTextInputFormatter(RegExp(this.allowed), allow: true)
            ],
            obscureText: Ispassword , 
                  maxLength: maxlen ,
                    controller: Controller ,
                    decoration: InputDecoration(
                      counterText: '',
                      hintText: this.text,
                      hintStyle: TextStyle(color: Color.fromRGBO(127, 128, 129, 1),fontWeight: FontWeight.w500,fontSize: 16.0),

                      //hintStyle: TextStyle() ,
                      errorStyle: TextStyle(fontSize: 10 ),
                      border : InputBorder.none
                      ),
                      
                    validator:(text) {
                      
                      return isvaild(text , this.text) ;
                    },));
  }
  }