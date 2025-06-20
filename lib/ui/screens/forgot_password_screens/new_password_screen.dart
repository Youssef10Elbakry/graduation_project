import 'package:flutter/material.dart';
import '../../../services/forgot_password_service.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_field.dart';
import 'successful_screen.dart';

class SetNewPasswordScreen extends StatefulWidget {
  final String email;
  final String verificationCode;
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

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

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
        leading: Padding(
          padding: const EdgeInsets.all(20),
          child: CustomIconButton(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Set a new password",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const CustomText(
              text: "Create a new password. Ensure it differs from previous ones for security",
            ),
            const SizedBox(height: 10),

            const Text("Password", style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.bold,fontSize: 15),),
            CustomTextField(
              hintText: "Enter new password",
              controller: _passwordController,
              obscureText: !_isPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),

        const Text("Confirm Password", style: TextStyle(color: Colors.black,
            fontWeight: FontWeight.bold,fontSize: 15),),
            CustomTextField(
              hintText: "Confirm new password",
              controller: _confirmPasswordController,
              obscureText: !_isConfirmPasswordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
              ),
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
