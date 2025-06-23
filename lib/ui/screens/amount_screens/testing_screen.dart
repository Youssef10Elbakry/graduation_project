import 'package:flutter/material.dart';
import 'amount_selection_sheet.dart';

// class TestScreen extends StatefulWidget {
//   const TestScreen({super.key});
//
//   static const String routeName = 'testing';
//
//   @override
//   State<TestScreen> createState() => _TestScreenState();
// }
//
// class _TestScreenState extends State<TestScreen> {
//   String selectedAmount = '0';
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(title: const Text('Bottom Sheet Test')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _showAmountSheet,
//           child: const Text('Open Amount Sheet'),
//         ),
//       ),
//     );
//   }
// }
void showAmountSheet(BuildContext context, String selectedAmount, String childId, String username, String imageUrl) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return buildAmountSelectionSheet(
            context,
                (newAmount) => setState(() => selectedAmount = newAmount),
            selectedAmount,
            'Youssuf Mahmoud',
            '123456789',
          );
        },
      );
    },
  );
}