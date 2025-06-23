import 'package:flutter/material.dart';
import 'amount_selection_sheet.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});
  static const String routeName = 'testing';

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String selectedAmount = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Bottom Sheet Test')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showAmountSheet(
              context,
              selectedAmount,
              '123456789', // ✅ studentId
              'Youssuf Mahmoud', // ✅ studentName
              'assets/images/youssuf_mahmoud.png', // ✅ imageUrl (unused for now)
            );
          },
          child: const Text('Open Amount Sheet'),
        ),
      ),
    );
  }
}