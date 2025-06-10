import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/models/child_model.dart';
import 'package:http/http.dart' as http;

class HomeTabProvider extends ChangeNotifier{
bool isLoadingChildren = true;
bool insightsVisible = false;
bool isLoadingInsights = true;
int attendancePercentage = 0;
int expendiences = 0;
double presentPercentage = 0;
double absentPercentage = 0;
double latePercentage = 0;
String childId = "";
String parentProfilePictureLink = "";
String parentUsername = "";
List<ChildModel> children = [];
final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

Future<void> getParentProfileData() async {
  try{
    final String token = (await secureStorage.read(key: "authentication_key"))!;
    final url = Uri.parse('https://parentstarck.site/parent/dashboard');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      parentProfilePictureLink = data['parent']['profilePicture'];
      parentUsername = data['parent']['username'];
      print("Parent Profile Picture Link: $parentProfilePictureLink");
      print("Parent Profile Username: $parentUsername");
      notifyListeners();
    } else {
      print("Error while loading parent profile picture link");
    }
  }
  catch(error){
    print("$error hhh");
  }
}

Future<void> getChildren() async {
  children = [];
  isLoadingChildren = true;
  notifyListeners();
  try{
    final String token = (await secureStorage.read(key: "authentication_key"))!;
    print("Token in Home Tab Provider: $token");
    final url = Uri.parse('https://parentstarck.site/parent/dashboard');
    print("I am here parse");
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      for(int i = 0; i<data['childs'].length;i++){
        children.add(ChildModel.fromJson(data['childs'][i]));
        print(children[i].username);
      }
      print("children: $children");
      isLoadingChildren = false;
      notifyListeners();
    } else {
      print("Error while loading chidlren");
    }
  }
  catch(error){
    print(error);
  }
}
Future<void> onChildTapped(String id)async {
  try {
    isLoadingInsights = true;
    attendancePercentage = 0;
    expendiences = 0;
    presentPercentage = 0;
    absentPercentage = 0;
    latePercentage = 0;
    childId = id;
    final String token = (await secureStorage.read(key: "authentication_key"))!;
    print("Token in Home Tab Provider: $token");
    final url = Uri.parse(
        'https://parentstarck.site/parent/get_child_insights/$id');
    print("I am here parse");
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      int total = data['totalAbsent'] + data['totalLate'] +
          data['totalPresent'];
      if(total<=0) {
        attendancePercentage = 0;
        expendiences = data['totalExpenses'];
        insightsVisible = true;
        notifyListeners();
      return;}
      presentPercentage = (data['totalPresent']/total)*100;
      absentPercentage = (data['totalAbsent']/total)*100;
      latePercentage = (data['totalLate']/total)*100;
      attendancePercentage =
          ((((data['totalLate'] * 0.5) + data['totalPresent']) / total) * 100)
              .toInt();
      expendiences = data['totalExpenses'];
    }
    else {
      print("Error in Loading Insights");
    }
    insightsVisible = true;
    isLoadingInsights = false;
    notifyListeners();
  }
  catch (error) {
    print(error);
  }
}

}
