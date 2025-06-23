import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/models/student_profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class StudentProfileProvider extends ChangeNotifier{
  bool isLoading = false;
  StudentProfileModel? studentProfileModel;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  Future<void> fetchStudentData(String id) async {
    try{
      isLoading = true;
      notifyListeners();
      final String token = (await secureStorage.read(key: "authentication_key"))!;
      print("Token in student profile screen $token");
    final url = Uri.parse('https://parentstarck.site/parent/get-student-all-data/$id');
    final response = await http.get(
    url,
    headers: {
    'Authorization': 'Bearer $token',
    },
    );
    if (response.statusCode == 200) {
    final data = json.decode(response.body);
    studentProfileModel = StudentProfileModel.fromJson(data);
    isLoading = false;
    notifyListeners();
    } else {
    print("Error while loading parent profile picture link");
    }
    }
    catch(error){
    print("$error hhh");
    }
  }
}