class StudentModel {
  int? id;
  String? name, gender, department;

  StudentModel({this.id, this.name, this.gender, this.department});

  List<dynamic> toList() {
    return [id, name, gender, department];
  }

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json["id"],
      name: json["name"],
      gender: json["gender"],
      department: json["department"],
    );
  }
}
