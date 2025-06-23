import 'package:flutter/material.dart';
import 'number_pad_sheet.dart';

Widget buildAmountSelectionSheet(
    BuildContext context,
    void Function(String) onAmountChanged,
    String currentAmount,
    String studentName,
    String studentId,
    String imageUrl
    ){
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
      color: Color(0xFF001645),
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              studentName,
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(imageUrl),
              radius: 35,
            ),
          ],
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (_) {
                return buildNumberPadSheet(
                  context,
                      (selectedAmount) => onAmountChanged(selectedAmount),
                  studentId,
                  imageUrl
                  // ✅ Passed studentId for Passcode screen
                );
              },
            );
          },
          child: Text(
            'EGP $currentAmount',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {}, // ✅ Optional: You can trigger the same behavior as NumberPad
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.lightBlueAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: Text('Send'),
          ),
        ),
      ],
    ),
  );
}




// ✅ Add this function at the bottom of amount_selection_sheet.dart

void showAmountSheet(
    BuildContext context,
    String selectedAmount,
    String studentId,
    String studentName,
    String imageUrl,
    ) {
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
            studentName,
            studentId,
            imageUrl
          );
        },
      );
    },
  );
}