import 'package:flutter/material.dart';
import '../../../services/forgot_password_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import 'successful_screen.dart';

class SetNewPasswordScreen extends StatefulWidget {
  final String email;
  final String verificationCode; // This is the OTP passed from VerificationScreen
  final String token;

  const SetNewPasswordScreen({
    super.key,
    required this.email,
    required this.verificationCode,
    required this.token,
  });

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  String? _errorText;
  bool _isLoading = false;

  Future<void> _handleUpdatePassword() async {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password.isEmpty || confirmPassword.isEmpty) {
      setState(() {
        _errorText = "Please fill out both fields.";
      });
      return;
    }
    if (password != confirmPassword) {
      setState(() {
        _errorText = "Passwords do not match.";
      });
      return;
    }

    setState(() {
      _errorText = null;
      _isLoading = true;
    });

    try {
      bool success = await ForgotPasswordService.updatePassword(
        password,
        widget.verificationCode,
        widget.token,
      );

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SuccessfulScreen()),
        );
      } else {
        setState(() {
          _errorText = "Failed to update password. Please try again.";
        });
      }
    } catch (e) {
      setState(() {
        _errorText = "An error occurred. Please try again.";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CustomIconButton(),
        title: const Text("Set a New Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: "Create a new password. Ensure it differs from previous ones for security",
            ),
            const SizedBox(height: 10),
            const CustomText(text: "Password", color: Colors.black),
            CustomTextField(
              hintText: "Enter new password",
              controller: _passwordController,
              obscureText: true,
            ),
            const SizedBox(height: 10),
            const CustomText(text: "Confirm Password", color: Colors.black),
            CustomTextField(
              hintText: "Confirm new password",
              controller: _confirmPasswordController,
              obscureText: true,
            ),
            if (_errorText != null) ...[
              const SizedBox(height: 10),
              Text(
                _errorText!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
            const SizedBox(height: 20),
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
              text: "Update Password",
              onTap: _handleUpdatePassword,
            ),
          ],
        ),
      ),
    );
  }
}
