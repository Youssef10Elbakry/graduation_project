import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgotPasswordService {
  static const String baseUrl = 'https://parentstarck.site/parent';

  // Send forgot password request
  static Future<Map<String, dynamic>?> sendForgotPasswordRequest(String email) async {
    final url = Uri.parse('$baseUrl/forgetPassword');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'pinAuth': data['pinAuth'].toString(), // Ensure it's passed as a string
        'token': data['token'],
      };
    } else {
      return null;
    }
  }

  // ✅ Update password using pinAuth as STRING (not int)
  static Future<bool> updatePassword(String password, String otp, String token) async {
    final url = Uri.parse('$baseUrl/updatePassword');

    print('=== DEBUG: updatePassword ===');
    print('Sending password: $password');
    print('Sending pinAuth as string: $otp');
    print('Token: $token');

    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'password': password,
        'pinAuth': otp, // ✅ Pass as string
      }),
    );

    print('Update Password status: ${response.statusCode}');
    print('Update Password response body: ${response.body}');

    return response.statusCode == 200;
  }
}
