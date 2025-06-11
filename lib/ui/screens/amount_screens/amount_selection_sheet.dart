import 'package:flutter/material.dart';
import 'number_pad_sheet.dart';

Widget buildAmountSelectionSheet(
    BuildContext context,
    void Function(String) onAmountChanged,
    String currentAmount,
    String studentName,
    String studentId,
    ) {
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
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/youssuf_mahmoud.png'),
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
          onPressed: () {},
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
  );}
