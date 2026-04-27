import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_manage_app/configs/routes/route_page.dart';
import 'package:student_manage_app/controllers/student_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://cztvjuxsfponsetkiccl.supabase.co',
    anonKey: 'sb_publishable_Ev_lP4nGJjyGLY_6e4EKRg_zmnmoyUa',
  );
  Get.put(StudentController());
  runApp(const MyApp());
  StudentController().testConnection();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      getPages: RoutePage.routes,
      initialRoute: RoutePage.home,
    );
  }
}
