import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:student_manage_app/controllers/student_controller.dart';
import 'package:student_manage_app/models/student_model.dart';
import 'package:student_manage_app/widgets/my_text.dart';
import 'package:student_manage_app/widgets/my_text_field.dart';
import 'package:get/get.dart';

class StudentUpdate extends StatelessWidget {
  StudentUpdate({super.key});

  StudentController controller = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(
          text: "Student Update Form",
          fontSize: 24,
          fontColor: Colors.white,
          isBold: true,
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: _buildBody,
    );
  }

  Widget get _buildBody {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/assets/image/student2.png"),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 20),
            Form(
              key: controller.updateFormKey,
              child: Column(
                spacing: 10,
                children: [
                  MyTextField(
                    controller: controller.ctlName.value,
                    validator: (value) => controller.validateName(value),
                    label: "Student name",
                  ),
                  Obx(
                    () => Row(
                      spacing: 10,
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            value: "Male",
                            title: MyText(text: "Male"),
                            groupValue: controller.ctlGender.value,
                            onChanged: (value) {
                              controller.ctlGender.value = value!;
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            value: "Female",
                            title: MyText(text: "Female"),
                            groupValue: controller.ctlGender.value,
                            onChanged: (value) {
                              controller.ctlGender.value = value!;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  MyTextField(
                    controller: controller.ctlDepartment.value,
                    validator: (value) => controller.validateDepartment(value),
                  ),

                  _buildButton,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _buildButton => Obx(
    () => controller.isLoading.value == true
        ? CircularProgressIndicator()
        : SizedBox(
            height: 54,
            width: double.infinity,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
              color: Colors.blue,
              onPressed: controller.isLoading.value == true
                  ? null
                  : () async {
                      if(controller.updateFormKey.currentState!.validate() == true) {
                        await controller.updateStudent(
                          controller.studentUpdate.id!,
                          StudentModel(
                            name: controller.ctlName.value.text,
                            gender: controller.ctlGender.value,
                            department: controller.ctlDepartment.value.text,
                          ),
                        );
                        await controller.getStudent();
                        Get.back();
                        controller.ctlName.value.clear();
                        controller.ctlDepartment.value.clear();
                        controller.ctlId.value.clear();
                        controller.ctlGender.value = "Male";
                        Get.snackbar(
                          "Success",
                          "Student Updated",
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
              child: MyText(
                text: "Update Student",
                fontSize: 20,
                fontColor: Colors.white,
              ),
            ),
          ),
  );
}
