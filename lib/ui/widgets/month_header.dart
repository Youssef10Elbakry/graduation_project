import 'package:flutter/material.dart';

class MonthHeader extends StatelessWidget {
  final String month;

  const MonthHeader({
    super.key, 
    required this.month,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      color: Colors.white,
      alignment: Alignment.centerLeft,
      child: Text(
        month,
        style: TextStyle(
          color: Color(0xFF2F2F2F),
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}