import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ConfirmationProvider extends ChangeNotifier {
  static const int maxDigits = 6;
  String _enteredConfirmation = '';
  String? _firstConfirmation;
  bool _isConfirming = false;
  bool _isError = false;
  bool _isLoading = false;
  String? _apiMessage;

  String get enteredConfirmation => _enteredConfirmation;
  bool get isConfirming => _isConfirming;
  bool get isError => _isError;
  bool get isLoading => _isLoading;
  String? get apiMessage => _apiMessage;

  // API endpoint
  static const String _apiUrl = 'https://parentstarck.site/parent/updatePinCode';

  // Add your bearer token here
  static const String _bearerToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXJlbnRJZCI6IjY3YzFlMjAxYTczMTc5MDk3YTE4Yjk2ZCIsImlhdCI6MTc0MjY3MDI1OX0.yQz19n7aoR1zOxiWtTh068FUw0ryS9M2jxMeziyDHvc';

  // Function to update pin code via API
  Future<void> updatePinCode(String pinCode1, String pinCode2, BuildContext context) async {
    try {
      _isLoading = true;
      _apiMessage = null;
      notifyListeners();

      final response = await http.put(
        Uri.parse(_apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_bearerToken',
        },
        body: jsonEncode({
          'pinCode1': pinCode1,
          'pinCode2': pinCode2,
        }),
      );

      final responseData = jsonDecode(response.body);
      _apiMessage = responseData['message'];
      
      _isLoading = false;
      notifyListeners();

      if (response.statusCode == 200) {
        // If successful
        _showSuccessDialog(context, _apiMessage ?? 'pin code updated successfully');
      } else {
        // If error
        _showErrorDialog(context, _apiMessage ?? 'Failed to update PIN code');
      }
    } catch (error) {
      _isLoading = false;
      _apiMessage = 'An error occurred. Please try again.';
      notifyListeners();
      _showErrorDialog(context, 'Connection error. Please check your internet connection.');
    }
  }

  void addDigit(String digit, BuildContext context) {
    if (_enteredConfirmation.length < maxDigits) {
      _enteredConfirmation += digit;
      notifyListeners();

      if (_enteredConfirmation.length == maxDigits) {
        _handleConfirmationEntry(context);
      }
    }
  }

  void removeLastDigit() {
    if (_enteredConfirmation.isNotEmpty) {
      _enteredConfirmation = _enteredConfirmation.substring(0, _enteredConfirmation.length - 1);
      notifyListeners();
    }
  }
  
  void resetConfirmation() {
    _enteredConfirmation = "";
    _isConfirming = false;
    _isError = false;
    notifyListeners();
  }

  void _handleConfirmationEntry(BuildContext context) {
    if (!_isConfirming) {
      // First entry, move to confirmation
      _firstConfirmation = _enteredConfirmation;
      _enteredConfirmation = '';
      _isConfirming = true;
      notifyListeners();
    } else {
      // Confirming confirmation
      if (_enteredConfirmation == _firstConfirmation) {
        // Make API call to update pin code
        updatePinCode(_firstConfirmation!, _enteredConfirmation, context);
      } else {
        _isError = true;
        notifyListeners();
        Future.delayed(const Duration(seconds: 1), () {
          _enteredConfirmation = '';
          _isError = false;
          notifyListeners();
        });
      }
    }
  }

  void _showSuccessDialog(BuildContext context, [String? customMessage]) {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                          'Well done!',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          customMessage ?? 'You have successfully\nupdated your PIN code.',
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
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF34C759),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Continue',
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
                        color: Color(0xFF34C759),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check_rounded,
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

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                          'Error',
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          message,
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
                            onPressed: () {
                              Navigator.pop(context);
                              resetConfirmation();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
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
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
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
}
