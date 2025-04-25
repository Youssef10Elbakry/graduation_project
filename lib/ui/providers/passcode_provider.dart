// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../screens/passcode_screen/success_screen.dart';
import '../screens/passcode_screen/error_screen.dart';
import '../../services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';

class PasscodeProvider extends ChangeNotifier {
  static const int maxDigits = 6;
  final ApiService _apiService = ApiService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<String> _digits = [];
  List<String> get digits => _digits;

  Future<void> addDigit(
    String digit, 
    BuildContext context,
    String studentId,
    double amount,
    String token,
  ) async {
    if (_digits.length < maxDigits) {
      _digits.add(digit);
      notifyListeners();
      
      if (_digits.length == maxDigits) {
        final pinCode = _digits.join();
        _isLoading = true;
        notifyListeners();

        try {
          debugPrint('Sending request with pinCode: $pinCode');
          final response = await _apiService.processPayment(
            studentId: studentId,
            amount: amount,
            token: token,
            pinCode: pinCode,
          );

          debugPrint('API Response: $response');

          if (response['message'] == 'Money sent successfully') {
            Navigator.pushReplacementNamed(context, PaymentSuccessfulScreen.routeName);
          } else if (response['message'] == 'Insufficient balance') {
            Navigator.pushReplacementNamed(context, ErrorScreen.routeName);
          }
        } catch (e) {
          debugPrint('Error caught in provider: $e');
          String errorMessage = e.toString();
          
          if (errorMessage.contains('Invalid pin code')) {
            _showErrorDialog(context);
          } else if (errorMessage.contains('Insufficient balance')) {
            Navigator.pushReplacementNamed(context, ErrorScreen.routeName);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error: $errorMessage'),
                backgroundColor: Colors.red,
              ),
            );
          }
        } finally {
          _isLoading = false;
          clearDigits();
          notifyListeners();
        }
      }
    }
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 32, left: 16, right: 16, bottom: 16),
                    child: Column(
                      children: [
                        Text(
                          'Oh snap!',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Invalid passcode entered.\nPlease try again.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF3B30),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Try Again',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: -40,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF3B30),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void removeLastDigit() {
    if (_digits.isNotEmpty) {
      _digits.removeLast();
      notifyListeners();
    }
  }

  void clearDigits() {
    _digits.clear();
    notifyListeners();
  }
}
