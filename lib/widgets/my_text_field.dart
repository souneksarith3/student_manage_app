import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_manage_app/widgets/my_text.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    super.key,
    this.controller,
    this.label,
    this.validator,
  });

  final TextEditingController? controller;
  final String? label;
  final String? Function(String? value)? validator;
  
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        label: MyText(text: label ?? "", fontColor: Colors.grey.shade600,),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
        )
      ),
    );
  }
}