import 'package:flutter/material.dart';
class ProfileTabTextField extends StatelessWidget {
  final String labelText;
  String infoText;
  // bool editable = false;
  ProfileTabTextField({
    super.key,
    required this.labelText,
    required this.infoText
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: TextEditingController(text: infoText),
        readOnly: true,
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[100],
            labelText: labelText,// Label text
            labelStyle: TextStyle(color: Colors.grey[800], fontSize: MediaQuery.of(context).size.height*0.021),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey[800]!,
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
              borderSide: BorderSide(
                color: Colors.grey[800]!,
                width: 1.5,
              ),
            ),
            suffixIcon: IconButton(icon: const Icon(Icons.edit,color: Colors.black,),onPressed: (){

            },)

        ),

      ),
    );

  }
}