import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyText extends StatelessWidget {
  MyText({
    super.key,
    required this.text,
    this.fontFamily,
    this.fontSize = 16,
    this.fontColor = Colors.black,
    this.isBold = false,
  });

  String text;
  double? fontSize;
  String? fontFamily = GoogleFonts.specialElite.toString();
  Color? fontColor;
  bool isBold;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontFamily: fontFamily,
        color: fontColor,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
