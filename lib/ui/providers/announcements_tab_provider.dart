import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/models/announcement_model.dart';
import 'package:http/http.dart' as http;

class AnnouncementsTabProvider extends ChangeNotifier{
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();
  List<AnnouncementModel> announcements = [];
  bool isLoading = true;

  Future<void> getAnnouncements() async {
    isLoading = true;
    announcements = [];
    notifyListeners();
    try{
      final String token = (await secureStorage.read(key: "authentication_key"))!;
      final url = Uri.parse('https://parentstarck.site/parent/get-notification');
      final response = await http.get(
      url,
      headers: {
      'Authorization': 'Bearer $token',
        },
      );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      for(int i = 0; i<data['notifications'].length;i++){
      announcements.add(AnnouncementModel.fromJson(data['notifications'][i]));
      }
      announcements.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      isLoading = false;
      notifyListeners();
    } else {
      print("Error while loading chidlren");
     }
    }
    catch(error){
    print("$error hhh");
    }
  }

}