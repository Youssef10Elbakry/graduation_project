import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgotPasswordService {
  static const String baseUrl = 'https://parentstarck.site/parent';

  // Send forgot password request, get pinAuth and token
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
        'pinAuth': data['pinAuth'].toString(),
        'token': data['token'],
      };
    } else {
      return null;
    }
  }

  // Update password with Authorization header including the Bearer token
  static Future<bool> updatePassword(String password, String otp, String token) async {
    final url = Uri.parse('$baseUrl/updatePassword');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'password': password,
        'pinAuth': int.tryParse(otp),
      }),
    );

    print('Update Password status: ${response.statusCode}');
    print('Update Password response body: ${response.body}');

    return response.statusCode == 200;
  }
}
