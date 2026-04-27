import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:student_manage_app/controllers/student_controller.dart';
import 'package:student_manage_app/models/student_model.dart';
import 'package:student_manage_app/widgets/my_text.dart';
import 'package:student_manage_app/widgets/my_text_field.dart';

// ignore: must_be_immutable
class StudentAdd extends StatelessWidget {
  StudentAdd({super.key});

  StudentController stdController = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildCustomScroll);
  }

  CustomScrollView get _buildCustomScroll {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.blue,
          title: MyText(
            text: "Student adding form",
            fontSize: 24,
            fontColor: Colors.white,
            isBold: true,
          ),
          centerTitle: true,
        ),
        SliverToBoxAdapter(
          child: Material(
            child: Padding(
              padding: EdgeInsetsGeometry.all(20),
              child: Column(
                children: [
                  Container(
                    width: 220,
                    height: 220,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("lib/assets/image/student1.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  _buildStudentForm,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Form get _buildStudentForm {
    return Form(
      key: stdController.addFormKey,
      child: Column(
        spacing: 18,
        children: [
          //=======[Input Student name]=========
          MyTextField(
            label: "Student name",
            controller: stdController.ctlName.value,
            validator: (value) => stdController.validateName(value),
          ),
          //===========[Radio Button]==========
          Obx(
            () => Row(
              spacing: 10,
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    value: "Male",
                    title: MyText(text: "Male"),
                    groupValue: stdController.ctlGender.value,
                    onChanged: (value) {
                      stdController.ctlGender.value = value!;
                    },
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    value: "Female",
                    title: MyText(text: "Female"),
                    groupValue: stdController.ctlGender.value,
                    onChanged: (value) {
                      stdController.ctlGender.value = value!;
                    },
                  ),
                ),
              ],
            ),
          ),
          //===========[Department]========
          MyTextField(
            label: "Department",
            controller: stdController.ctlDepartment.value,
            validator: (value) => stdController.validateDepartment(value),
          ),
          //==========[Button]============
          _buildButton,
        ],
      ),
    );
  }

  Widget get _buildButton => Obx(
    () => stdController.isLoading.value == true
        ? CircularProgressIndicator()
        : SizedBox(
            height: 54,
            width: double.infinity,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
              color: Colors.blue,
              onPressed: stdController.isLoading.value == true
                  ? null
                  : () async {
                      if (stdController.addFormKey.currentState!.validate() ==
                          true) {
                        print("Obj");
                        await stdController.addStudent(
                          StudentModel(
                            name: stdController.ctlName.value.text,
                            gender: stdController.ctlGender.value,
                            department: stdController.ctlDepartment.value.text,
                          ),
                        );
                        await stdController.getStudent();
                        Get.back();
                        stdController.ctlName.value.clear();
                        stdController.ctlDepartment.value.clear();
                        Get.snackbar("Success", "Student Added", snackPosition: SnackPosition.BOTTOM);
                      }
                    },
              child: MyText(
                text: "Add Student",
                fontSize: 20,
                fontColor: Colors.white,
              ),
            ),
          ),
  );
}
