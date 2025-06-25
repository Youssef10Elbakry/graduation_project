import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../models/user_profile_model.dart';

class UserProfileProvider with ChangeNotifier {
  UserProfile? userProfile;
  bool isLoading = false;
   bool isUpdating = false;

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

  Future<bool> updateUserProfile(String token, {
    required String fullName,
    required String age,
    required String numberOfChildren,
    required String phoneNumber,
    required String email,
  }) async {
    isUpdating = true;
    notifyListeners();

    try {
      final response = await http.put(
        Uri.parse('https://parentstarck.site/parent/updateProfile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': fullName,
          'age': int.tryParse(age) ?? 0,
          'numberOfChildren': int.tryParse(numberOfChildren) ?? 0,
          'phoneNumber': phoneNumber,
          'email': email,
        }),
      );

      if (response.statusCode == 200) {
        // Update local userProfile with new data
        userProfile = UserProfile(
          fullName: fullName,
          age: age,
          numberOfChildren: numberOfChildren,
          phoneNumber: phoneNumber,
          email: email,
          profilePhoto: userProfile?.profilePhoto ?? '',
        );
        return true;
      } else {
        throw Exception('Failed to update profile');
      }
    } catch (error) {
      print('Update Error: $error');
      return false;
    } finally {
      isUpdating = false;
      notifyListeners();
    }
  }
}