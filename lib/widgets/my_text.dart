import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyText extends StatelessWidget {
  MyText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.fontColor = Colors.black,
    this.isBold = false,
  });

  String text;
  double? fontSize;
  //String? fontFamily = GoogleFonts.robotoSlab.toString();
  Color? fontColor;
  bool isBold;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.robotoSlab(
        fontSize: fontSize,
        color: fontColor,
        fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
