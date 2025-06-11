import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'verification_screen.dart';
// ✅✅"email" : "kavon_cormier-baumbach@hotmail.com"
class ForgotPasswordScreen extends StatefulWidget {
  static const String routeName = '/forgot_password_screen';
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  String? _errorText;
  bool _isLoading = false;

  Future<void> _handleResetPassword() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        _errorText = "Please enter your email address.";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorText = null;
    });

    // ✅ PUT HEADERS HERE
    final url = Uri.parse('https://parentstarck.site/parent/forgetPassword');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({'email': email});

    try {
      final response = await http.post(url, headers: headers, body: body);

      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['pinAuth'] != null && data['token'] != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(
                email: email,
                token: data['token'],
                pinAuth: data['pinAuth'].toString(),
              ),
            ),
          );






        } else {
          setState(() {
            _errorText = data['message'] ?? "Something went wrong.";
          });
        }
      } else {
        setState(() {
          _errorText = "Server error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _errorText = "An error occurred. Please try again.";
      });
      print("Exception: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("Please enter your email to reset the password."),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            if (_errorText != null) ...[
              const SizedBox(height: 8),
              Text(
                _errorText!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _handleResetPassword,
              child: const Text("Reset Password"),
            ),
          ],
        ),
      ),
    );
  }
}
