import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ui/providers/sign_in_button_provider.dart';
import 'package:graduation_project/ui/screens/login_screen/login_screen.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graduation_project/ui/screens/main_screen/main_screen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class WelcomeAndLoginButton extends StatefulWidget {
  String buttonText;
  WelcomeAndLoginButton({super.key, required this.buttonText});

  @override
  State<WelcomeAndLoginButton> createState() => _WelcomeAndLoginButtonState();
}

class _WelcomeAndLoginButtonState extends State<WelcomeAndLoginButton> {
  late SignInButtonProvider provider;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.065,
      width: MediaQuery.of(context).size.width * 0.85,
      child: ElevatedButton(
        onPressed: provider.isLoading
            ? null
            : () {
          String email = LoginScreen.emailController.text.trim();
          String pass = LoginScreen.passController.text.trim();

          if (widget.buttonText == "Sign in") {
            postData(email,pass);
          } else if (widget.buttonText == "Login") {
            Navigator.pushNamed(context, LoginScreen.screenName); // Adjust route if needed
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff1F41BB),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: provider.isLoading
            ? const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2.5,
          ),
        )
            : Text(
          widget.buttonText,
          style: const TextStyle(
            fontSize: 22,
            fontFamily: "Poppins",
            color: Color(0xffFFFFFF),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Future<void> postData(String email, String password) async {
    try {
      print("Email:$email");
      print("Pass: $password");
      provider.startLoading();
      final headers = {'Content-Type': 'application/json'};
      final url = Uri.parse('https://parentstarck.site/parent/login');
      final body = json.encode({
        "email": email,
        "password": password,
      });
      print("I am here parse");
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      ).timeout(Duration(seconds: 20));

      print("i am here");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        String token = data['token'];
        secureStorage.write(key: "authentication_key", value: token);
        print("Token: ${data['token']}");
        print('Login successful: ${data['message']}');
        Navigator.pushNamed(context, MainScreen.screenName);
      } else {
        // Show dialog with "Invalid Credentials" message
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Login Failed'),
              content: const Text('Invalid Credentials'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        print('Error: ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
    provider.stopLoading();
  }
}
