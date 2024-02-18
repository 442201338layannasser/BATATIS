import 'package:flutter/material.dart';
import 'CLocationPicker.dart';
import 'colors.dart';

class CustomText extends StatelessWidget {
  final String text;
  String type;
  double fontSize;
  Color color;

  CustomText({
    required this.text,
    this.type = "default",
    this.fontSize = 12.0,
    this.color = const Color(0xFF000000), // Default color is black
  });

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
        break;
      case "Subheading1W":
        {
          return basetext(
            text,
            white,
            fontSize == 12.0 ?18.0 : fontSize,
          );
        }
        break;

      case "Subheading2W":
        {
          return basetext(
            text,
            white,
            fontSize,
          );
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

      case "ResturantInfo":
        {
          return basetext3(
            text,
            black,
            14.0,
          );
        }
        break;
      case "ResturantInfo":
        {
          return basetext3(
            text,
            black,
            14.0,
          );
        }
        break;

      case "Subheading2ResturantMenu":
        {
          return basetext(text, Batatis_Dark, 14.0,
              fontWeight: FontWeight.bold);
        }
      case "Opened":
        return basetext(text, Colors.green, 14.0);
      case "Closed":
        return basetext(text, Colors.red, 14.0);
      default:
        {
          return basetext(text, this.color, fontSize);
        }
        break;
    }
  }
}

Widget basetext(text, color, fontSize, {fontWeight = FontWeight.normal}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: 'Poppins',
      fontWeight: fontWeight,
    ),
  );
}

Widget basetext1(text, color, fontSize, onPressed(),
    {fontWeight = FontWeight.normal}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: 'Poppins',
      fontWeight: fontWeight,
    ),
  );
}

Widget basetext3(text, color, fontSize, {fontWeight = FontWeight.normal}) {
  return Text(
    text,
    textAlign: TextAlign.start,
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontFamily: 'Poppins',
      fontWeight: fontWeight,
    ),
  );
}
