
import 'package:flutter/material.dart';
import 'package:student_manage_app/widgets/my_student_card.dart';
import 'package:student_manage_app/widgets/my_text.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCustomScroll,
      floatingActionButton: _buildFloating,
    );
  }

  CustomScrollView get _buildCustomScroll => CustomScrollView(
    slivers: [
      SliverAppBar(
        title: MyText(
          text: "Student Manage Screen",
          fontSize: 24,
          fontColor: Colors.white,
          isBold: true,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 50),
          child: Padding(
            padding: EdgeInsetsGeometry.only(bottom: 10, left: 10, right: 10),
            child: SearchBar(hintText: "Search...", backgroundColor: WidgetStatePropertyAll<Color>(Colors.white)),
          ),
        ),
        expandedHeight: 130,
        backgroundColor: Colors.blue,
      ),
      SliverToBoxAdapter(
        child: Material(
          child: Padding(
            padding: EdgeInsetsGeometry.only(left: 18, right: 18, top: 18, bottom: 20),
            child: _buildStudentList,
          ),
        ),
      ),
    ],
  );

  Column get _buildStudentList {
    return Column(
      spacing: 10,
      children: List.generate(
        15,
        (index) => GestureDetector(
          child: MyStudentCard(),
          onTap: () {
            print("Press on student $index");
          },
        ),
      ),
    );
  }

  FloatingActionButton get _buildFloating =>
      FloatingActionButton(onPressed: () {}, child: Icon(Icons.add, size: 36));
}
