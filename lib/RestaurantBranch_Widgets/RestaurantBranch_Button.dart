import 'package:batatis/main.dart';
import 'package:flutter/material.dart';
import 'colors.dart';
import 'RestaurantBranch_texts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  String type;
  double width;
  double height;

  CustomButton(
      {required this.text,
      required this.onPressed,
      this.type = "default",
      this.width = 0.22,
      this.height = 0.09});

  Widget build(BuildContext context) {
    switch (type) {
      case "Edit":
        return basebutton(width, height,
            CustomText(text: text, type: "white", fontSize: 18), Batatis_Dark);
      case "Save":
        return basebutton(width, height,
            CustomText(text: text, type: "white", fontSize: 18), green);
      case "confirm":
        {
          return basebutton(
              width,
              height,
              CustomText(text: text, type: "white", fontSize: 18),
              Batatis_Dark);
        }
      case "reject":
        {
          return basebutton(
              width,
              height,
              CustomText(text: text, type: "white", fontSize: 18),
              Batatis_Dark);
        }
      //case "reject": {return basebutton(width ,height , CustomText(text: text,type: "Subheading1B"),grey_light);}
      case "delete1":
        {
          return basebutton(
              width,
              height,
              CustomText(text: text, type: "white", color: white, fontSize: 18),
              red);
        }
      case "delete":
        {
          return basebutton(
              width,
              height,
              CustomText(
                text: text,
                type: "paragraph2",
                color: white,
              ),
              red);
        }
      case "add":
        {
          return basebutton(
              width,
              height,
              CustomText(text: text, type: "white", fontSize: 18),
              Batatis_Dark);
        }
      case "orderdatails":
        {
          return basebutton(
              width,
              height,
              CustomText(
                text: text,
                type: "white",
              ),
              Batatis_Dark);
        }
      case "acceptorder":
        {
          return basebutton(
              width,
              height,
              CustomText(
                text: text,
                type: "paragraph2",
                color: white,
              ),
              Batatis_Dark);
        }
      default:
        {
          return basebutton(
              width,
              height,
              CustomText(text: text, type: "white", fontSize: 18),
              Batatis_Dark);
        }
      // default:{return basebutton(width ,height , CustomText(text: text,type: "Subheading1B"),grey_light);}
    }
  }

  Widget basebutton(width, height, Widget, color) {
    return Container(
        width: width * Batatis.Swidth,
        height: height * Batatis.Sheight,
        margin: EdgeInsets.all(5.0),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Widget,
          style: ElevatedButton.styleFrom(backgroundColor: color),
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)));
  }
}
