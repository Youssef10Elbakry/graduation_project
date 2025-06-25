import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/ui/screens/main_screen/wallet_tab/wallet_tab.dart';

class PaymentSuccessfulScreen extends StatefulWidget {
  static const routeName = '/payment_success';

  const PaymentSuccessfulScreen({super.key});

  @override
  _PaymentSuccessfulScreenState createState() => _PaymentSuccessfulScreenState();
}

class _PaymentSuccessfulScreenState extends State<PaymentSuccessfulScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.8, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: Lottie.asset(
                  'assets/animations/success_new.json',
                  width: 250,
                  height: 250,
                  repeat: false,
                  animate: true,
                  onLoaded: (composition) {
                    _controller.duration = composition.duration * 1.5;
                    _controller.forward();
                  },
                ),
              ),
              const SizedBox(height: 40),
              FadeTransition(
                opacity: _fadeAnimation,
                child: AnimatedBuilder(
                  animation: _slideAnimation,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: Column(
                      children: [
                        Text(
                          'Payment Successful',
                          style: GoogleFonts.inter(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF2E7D32),
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Your transaction has been completed\nsuccessfully',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              FadeTransition(
                opacity: _fadeAnimation,
                child: AnimatedBuilder(
                  animation: _slideAnimation,
                  builder: (context, child) => Transform.translate(
                    offset: Offset(0, _slideAnimation.value),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2E7D32),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: Text(
                        'Done',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
