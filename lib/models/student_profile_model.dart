class StudentProfileModel{
  String fullName;
  String code;
  String grade;
  String age;

  // factory StudentProfileModel.fromJson(Map<String, dynamic> json) {
  //   print(json);
  //   return StudentProfileModel(
  //     fullName: json["parent"]['username'] ?? '',
  //     age: json["parent"]['age'].toString() ?? '',
  //     numberOfChildren: json["parent"]['numberOfChildren'].toString() ?? '',
  //     phoneNumber: json["parent"]['phoneNumber'] ?? '',
  //     email: json["parent"]['email'] ?? '',
  //     profilePhoto: json["parent"]['profilePhoto'] ?? '', // Parse the photo link
  //   );
  // }

  StudentProfileModel({required this.fullName, required this.age, required this.code, required this.grade});
}