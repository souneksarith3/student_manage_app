import 'package:get/get.dart';
import 'package:student_manage_app/models/student_model.dart';

class StudentController extends GetxController {
  final List<StudentModel> studentList = [];

  RxBool _isLoading = false.obs;
}
