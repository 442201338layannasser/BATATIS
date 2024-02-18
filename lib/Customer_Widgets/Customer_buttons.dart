import 'package:flutter/material.dart';
import 'colors.dart';
import 'Customer_texts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  String type;
  double width;
  double height;
  double fontSize;

  CustomButton(
      {required this.text,
      required this.onPressed,
      this.type = "default",
      this.width = 250,
      this.height = 60,
      this.fontSize = 12.0});

  Widget build(BuildContext context) {
    switch (type) {
      case "confirm":
        {
          return basebutton(width, height,
              CustomText(text: text, type: "Subheading1W",fontSize:fontSize ,), Batatis_Dark);
        }
        break;

      case "reject":
        {
          return basebutton(width, height,
              CustomText(text: text, type: "Subheading1B"), grey_light);
        }
        break;
      case "reject1":
        {
          return basebutton(20.0, 20.0,
              CustomText(text: text, type: "Subheading1B"), grey_light);
        }
        break;
      case "delete":
        {
          return basebutton(
              width,
              height,
              CustomText(text: text, type: "Subheading2W", fontSize: fontSize),
              red);
        }
        break;

      default:
        {
          return basebutton(
              width,
              height,
              CustomText(
                text: text,
                type: "Subheading1B",
              ),
              grey_light);
        }
        break;
    }
  }

  Widget basebutton(width, height, Widget, color) {
    return Container(
        margin: const EdgeInsets.all(5),
        width: width == 0 ? null : width,
        height: height == 0 ? null : height,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Widget,
          style: ElevatedButton.styleFrom(backgroundColor: color),
        ));
  }
}
