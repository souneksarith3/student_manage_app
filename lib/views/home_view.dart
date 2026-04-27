import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_manage_app/configs/routes/route_page.dart';
import 'package:student_manage_app/controllers/student_controller.dart';
import 'package:student_manage_app/widgets/my_student_card.dart';
import 'package:student_manage_app/widgets/my_text.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final StudentController stdController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar,
      body: _buildBody,
      floatingActionButton: _buildFloating,
    );
  }

  PreferredSizeWidget get _buildAppbar {
    return AppBar(
      backgroundColor: Colors.blue,
      title: MyText(
        text: "Student List View",
        fontColor: Colors.white,
        fontSize: 24,
        isBold: true,
      ),
      centerTitle: true,
      toolbarHeight: 80,
      bottom: PreferredSize(
        preferredSize: Size(double.infinity, 40),
        child: Container(
          height: 48,
          margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
          child: SearchBar(
            leading: Icon(Icons.search),
            hintText: "Search...",
            hintStyle: WidgetStatePropertyAll(GoogleFonts.robotoSlab()),
          ),
        ),
      ),
    );
  }

  Widget get _buildBody {
    return Obx(
      () => stdController.isLoading.value == true
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: stdController.list.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: ()=> stdController.showBottumSheet(stdController.list[index]),
                    child: MyStudentCard(
                      studentModel: stdController.list[index],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget get _buildFloating {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed(RoutePage.studentAdd);
      },
      backgroundColor: Colors.blue,
      child: Icon(Icons.add, color: Colors.white, size: 36),
    );
  }
}
