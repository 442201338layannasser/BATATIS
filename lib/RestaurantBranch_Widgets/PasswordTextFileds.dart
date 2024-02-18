import 'package:batatis/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';
import 'package:flutter/material.dart';
import 'package:batatis/Controller.dart';

import 'package:flutter/material.dart';

class PasswordTextFiled extends StatefulWidget {
  final String text; // the text for text widgets
  String type; // type to pick which one to use
  TextEditingController controller;
  double width;
  double height;
  String allowed;
  int maxLen;
  bool isPassword;
  final Function(String) onLostFocus;

  String? Function(String? value, String? field) isvaild;

  PasswordTextFiled({
    required this.text,
    required this.controller,
    this.type = "default",
    required this.isvaild,
    this.width = 0.36,
    this.height = 0.1,
    this.maxLen = 25,
    this.allowed = r'[A-Za-z0-9]',
    this.isPassword = false,
    required this.onLostFocus,
  });

  @override
  State<PasswordTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<PasswordTextFiled> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width * Batatis.Swidth,
      height: widget.height * Batatis.Sheight,
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: grey_light,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter(RegExp(widget.allowed), allow: true),
        ],
        obscureText: _obscureText,
        maxLength: widget.maxLen,
        controller: widget.controller,
        decoration: InputDecoration(
          counterText: '',
          hintText: widget.text,
          hintStyle: TextStyle(
              color: Color.fromRGBO(127, 128, 129, 1),
              fontWeight: FontWeight.w500,
              fontSize: 16.0),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
        validator: (text) {
          return widget.isvaild(text, widget.text);
        },
      ),
    );
  }
}