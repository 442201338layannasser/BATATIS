import 'package:flutter/material.dart';
import 'All_RB_Widgets.dart';

class RBDivider extends StatelessWidget {
  final String text;
  @override
  RBDivider({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Batatis_Dark, fontSize: 28),
          ),
        ),
        Divider(
          color: Batatis_Dark,
          thickness: 3,
        ),
      ],
    );
  }
}
