import 'package:flutter/cupertino.dart';

class VisaContainer extends StatelessWidget {
  const VisaContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset("assets/images/visa_card.png")
      ],
    );
  }
}
