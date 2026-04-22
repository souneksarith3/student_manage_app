import 'package:student_manage_app/models/student_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StudentService {
  final supabase = Supabase.instance.client;

  Future<Supabase?> addStudent(StudentModel model) async {
    return await supabase.from("student").insert([
      {
        "name": model.name,
        "gender": model.gender,
        "department": model.department,
      },
    ]);
  }

  Future<List> getStudent() async {
    return await supabase.from("student").select();
  }

  Future<Supabase?> updateStudent(int id, StudentModel model) async {
    return await supabase
        .from("student")
        .update({
          "name": model.name,
          "gender": model.gender,
          "department": model.department,
        })
        .eq("id", id);
  }

  Future<Supabase?> deleteStudent(int id) async {
    return await supabase.from("student").delete().eq("id", id);
  }

  Future<List?> getByDepartment(String department) async {
    return await supabase.from("student").select().eq("department", department);
  }
}
