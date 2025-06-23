import 'attendance_record.dart';

class StudentProfileModel{
  String? fullName;
  String? code;
  String? grade;
  String? age;
  String? balance;
  String? profilePicture;
  List<AttendanceRecord>? attendanceRecords;
  StudentProfileModel.fromJson(Map<String, dynamic> json) {
    print(json);
    fullName = "${json["student"]['firstName']} ${json["student"]['lastName']}" ?? '';
    age = json["student"]['age'].toString() ?? '';
    code = json["student"]["studentCode"]??'';
    grade = json["student"]['grade'].toString() ?? '';
    balance = json["student"]["balance"].toString()??'';
    profilePicture = json["student"]['profilePicture'] ?? '';
    if (json["student"]["attendances"] != null) {
      attendanceRecords = [];
      json["student"]["attendances"].forEach((v) {
        attendanceRecords?.add(AttendanceRecord.fromJson(v));
      });
    }

  }

  StudentProfileModel({required this.fullName, required this.age, required this.code, required this.grade, required this.profilePicture, required this.attendanceRecords});
}

