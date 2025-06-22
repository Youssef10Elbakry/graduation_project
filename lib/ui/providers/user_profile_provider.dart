import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/user_profile_model.dart';

class UserProfileProvider with ChangeNotifier {
  UserProfile? userProfile;
  bool isLoading = false;

  Future<void> fetchUserData(String token) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        Uri.parse('https://parentstarck.site/parent/profileData'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        userProfile = UserProfile.fromJson(data);
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      isLoading = false;
      notifyListeners();
    }

  }
}