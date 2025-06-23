import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/passcode_provider.dart';
import '../../widgets/keypad.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PasscodeScreen extends StatelessWidget {
  static const routeName = '/passcode';
  final String? studentId;
  final double? amount;
  final secureStorage = const FlutterSecureStorage();

  const PasscodeScreen({
    super.key,
    required this.studentId,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    print("In pass code screen, studentId: $studentId");
    print("In pass code screen, amount: $amount");
    final passcodeProvider = Provider.of<PasscodeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      'Enter your passcode to confirm',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 22, 
                        fontWeight: FontWeight.w600, 
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  // Passcode placeholders
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      PasscodeProvider.maxDigits,
                      (index) {
                        bool filled = index < passcodeProvider.digits.length;
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: filled ? Colors.black : Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 60),
                  // Increased height
                  Expanded(
                    child: Keypad(
                      onDigitPressed: passcodeProvider.isLoading
                          ? null
                          : (digit) async {
                              final token = await secureStorage.read(key: "authentication_key");
                              passcodeProvider.addDigit(
                                digit,
                                context,
                                studentId ?? '',
                                amount ?? 0.0,
                                token ?? '',
                              );
                            },
                      onBackspacePressed: passcodeProvider.isLoading
                          ? null
                          : () {
                              passcodeProvider.removeLastDigit();
                            },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (passcodeProvider.isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: Lottie.asset(
                  'assets/animations/loading.json',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
        ],
      ),
    );
  }
}