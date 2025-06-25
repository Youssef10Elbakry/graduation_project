import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileTabTextField extends StatelessWidget {
  final String labelText;
  final String infoText;
  final bool isEditable;
  final VoidCallback? onEditPressed;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const ProfileTabTextField({
    super.key,
    required this.labelText,
    required this.infoText,
    this.isEditable = false,
    this.onEditPressed,
    this.controller,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller ?? TextEditingController(text: infoText),
      readOnly: !isEditable,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        filled: true,
        fillColor: isEditable ? Colors.white : Colors.grey[100],
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.grey[800], 
          fontSize: MediaQuery.of(context).size.height * 0.021
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isEditable ? Colors.blue : Colors.grey[800]!,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isEditable ? Colors.blue : Colors.grey[800]!,
            width: 1.5,
          ),
        ),
        suffixIcon: onEditPressed != null && !isEditable ? IconButton(
          icon: const Icon(
            Icons.edit,
            color: Colors.black,
          ),
          onPressed: onEditPressed,
        ) : null,
      ),
    );
  }
}