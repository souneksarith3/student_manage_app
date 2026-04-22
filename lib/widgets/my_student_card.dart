import 'package:flutter/material.dart';
import 'package:student_manage_app/models/student_model.dart';
import 'package:student_manage_app/widgets/my_text.dart';

// ignore: must_be_immutable
class MyStudentCard extends StatelessWidget {
  MyStudentCard({super.key, this.studentModel});

  StudentModel? studentModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 2),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Row(
        spacing: 30,
        children: [
          CircleAvatar(
            minRadius: 20,
            maxRadius: 36,
            child: Icon(Icons.person, size: 40),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyText(text: "Name", fontSize: 18, isBold: true),
              MyText(text: "Gender"),
              MyText(text: "Department"),
            ],
          ),
        ],
      ),
    );
  }
}
