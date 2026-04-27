import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:student_manage_app/configs/routes/route_page.dart';
import 'package:student_manage_app/configs/services/student_service.dart';
import 'package:student_manage_app/models/student_model.dart';
import 'package:student_manage_app/widgets/my_text.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StudentController extends GetxController {
  final stdService = StudentService();

  final isLoading = false.obs;
  List<StudentModel> list = <StudentModel>[].obs;
  StudentModel studentUpdate = StudentModel();

  final ctlId = TextEditingController().obs;
  final ctlName = TextEditingController().obs;
  RxString ctlGender = "Male".obs;
  final ctlDepartment = TextEditingController().obs;
  final addFormKey = GlobalKey<FormState>();
  final updateFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    getStudent();
    ctlGender.value = studentUpdate.gender ?? "Male";
  }

  @override
  void onClose() {
    ctlId.close();
    ctlName.close();
    ctlDepartment.close();
    super.onClose();
  }

  Future<Supabase?> addStudent(StudentModel model) async {
    try {
      isLoading.value = true;
      return await stdService.addStudent(model);
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  StudentModel getStudentModel() {
    return StudentModel(
      id: int.parse(ctlId.value.text),
      name: ctlName.value.text,
      gender: ctlGender.value,
      department: ctlDepartment.value.text,
    );
  }

  Future<List<StudentModel>> getStudentList() async {
    isLoading.value = true;
    try {
      final result = await stdService.getStudent();
      return result.map<StudentModel>((e) => StudentModel.fromJson(e)).toList();
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getStudent() async {
    isLoading.value = true;
    try {
      final response = await stdService.getStudent();
      list = response
          .map<StudentModel>((e) => StudentModel.fromJson(e))
          .toList();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<StudentModel>> getStudentByDepartment(String department) async {
    isLoading.value = true;
    try {
      final result = await stdService.getByDepartment(department);
      return result!
          .map<StudentModel>((e) => StudentModel.fromJson(e))
          .toList();
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return [];
    } finally {
      isLoading.value = false;
    }
  }

  Future<Supabase?> updateStudent(int id, StudentModel newData) async {
    isLoading.value = true;
    try {
      return await stdService.updateStudent(id, newData);
    } catch (ex) {
      Get.snackbar("Error", ex.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<Supabase?> deleteStudent(int id) async {
    isLoading.value = true;
    try {
      return await stdService.deleteStudent(id);
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> testConnection() async {
    final supabase = Supabase.instance.client;
    try {
      final respone = await supabase.from("student").select().count();
      if (respone.count > 0) {
        print("Success");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter name";
    } else {
      return null;
    }
  }

  String? validateDepartment(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter name";
    } else {
      return null;
    }
  }

  void showBottumSheet(StudentModel student) {
    Get.bottomSheet(
      BottomSheet(
        onClosing: () {},
        builder: (context) => Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 6,
            children: [
              SizedBox(height: 20,),
              MyText(text: "What will you do on '${student.name}'?", fontSize: 20, isBold: true,),
              SizedBox(height: 10,),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    studentUpdate = student;
                    ctlId.value.text = studentUpdate.id.toString();
                    ctlName.value.text = studentUpdate.name.toString();
                    ctlDepartment.value.text = studentUpdate.department.toString();
                    ctlGender.value = studentUpdate.gender.toString();
                    Get.toNamed(RoutePage.studentUpdate);
                  },
                  child: MyText(text: "Update", fontColor: Colors.blue, fontSize: 18,),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    
                  },
                  child: MyText(text: "Delete", fontColor: Colors.red, fontSize: 18,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
