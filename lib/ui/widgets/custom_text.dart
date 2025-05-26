import 'package:flutter/material.dart';
class CustomText extends StatelessWidget {
  final String text;
  final Color color;

  const CustomText({
    super.key,
    required this.text,
    this.color = const Color(0xFF989898),

  });

  /// Custom method to return a copy with a new color
  CustomText copyWith({String? text, Color? color}) {
    return CustomText(
      text: text ?? this.text,
      color: color ?? this.color,

    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 15,
      ),
    );
  }
}
