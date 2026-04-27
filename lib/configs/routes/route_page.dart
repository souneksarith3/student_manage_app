import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:student_manage_app/models/student_model.dart';
import 'package:student_manage_app/views/home_view.dart';
import 'package:student_manage_app/views/student_add.dart';
import 'package:student_manage_app/views/student_update.dart';

class RoutePage {
  static const home = '/home';
  static const studentAdd = '/student/add';
  static const studentUpdate = '/student/pdate';

  static final List<GetPage> routes = [
    GetPage(name: home, page: () => HomeView()),
    GetPage(name: studentAdd, page: () => StudentAdd()),
    GetPage(name: studentUpdate, page: () => StudentUpdate()),
  ];
}