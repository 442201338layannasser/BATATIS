import 'package:flutter/material.dart';
import 'colors.dart';

class CustomText extends StatelessWidget {
  final String text; // the text for text widgets
  String type; // type to pick which one to use
  double fontSize;
  Color color;
  FontWeight fontWeight;
  CustomText(
      {required this.text,
      this.type = "default",
      this.fontSize = 12.0,
      this.color = const Color(000000),
      this.fontWeight = FontWeight.normal});

  Widget build(BuildContext context) {
    switch (type) {
      case "heading":
        {
          return basetext(text, black, 24.0, fontWeight: FontWeight.bold);
        }
        break;

      case "Subheading1B":
        {
          return basetext(
            text,
            black,
            18.0,
          );
        }
      case "total":
        {
          return basetext(
            text,
            Batatis_Dark,
            18.0,
          );
        }
      case "tab":
        {
          return basetext(
            text,
            black,
            16.0,
          );
        }
        break;
      case "Subheading1W":
        {
          return basetext(text, black, 18.0, fontWeight: FontWeight.bold);
        }
        break;

      case "Subheading1WB":
        {
          return basetext(text, Batatis_Dark, 40.0,
              fontWeight: FontWeight.bold);
        }
        break;

      case "Subheading2":
        {
          return basetext(
            text,
            black,
            14.0,
          );
        }
        break;

      case "paragraph":
        {
          return basetext(
            text,
            black,
            12.0,
          );
        }
        break;

      case "paragraph2":
        {
          return basetext(
            text,
            color,
            12.0,
          );
        }
        break;

      case "form":
        {
          return basetext(
            text,
            grey_Dark,
            14.0,
          );
        }
        break;

      case "warning":
        {
          return basetext(text, Color.fromRGBO(255, 0, 0, 1), 24.0,
              fontWeight: FontWeight.bold);
        }
        break;

      case "white":
        {
          return basetext(
            text,
            white,
            fontSize,
          );
        }
        break;

      case "whiteW":
        {
          return basetext(text, white, 18, fontWeight: FontWeight.bold);
        }
        break;

      default:
        {
          return basetext(text, color, fontSize, fontWeight: fontWeight);
        }
        break;
    }
  }
}

Widget basetext(text, color, size, {fontWeight = FontWeight.normal}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: size,
      fontFamily: 'Poppins',
      fontWeight: fontWeight,
      //letterSpacing: -0.30,
    ),
  );
}
