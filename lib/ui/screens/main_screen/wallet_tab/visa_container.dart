import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:u_credit_card/u_credit_card.dart';

class VisaContainer extends StatefulWidget {
  int balance;
  String username;
  VisaContainer({super.key, required this.balance, required this.username});

  @override
  State<VisaContainer> createState() => _VisaContainerState();
}

class _VisaContainerState extends State<VisaContainer> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width*0.9,
      child:  CreditCardUi(
        cardNumber: widget.balance.toStringAsFixed(1),
        currencySymbol: "EGP ",
        showBalance: true,
        balance: widget.balance.toDouble(),
        validFrom: '',
        showValidFrom: false,
        validThru: '',
        showValidThru: false,
        cardHolderFullName: widget.username,
        topLeftColor: const Color(0xFF4A00E0),
        bottomRightColor: const Color(0xFF8E2DE2),
        doesSupportNfc: false,
        creditCardType: CreditCardType.visa, // Shows Visa Logo
        cardType: CardType.other,
        width: width*0.9,
        enableFlipping: false,
        shouldMaskCardNumber: false,
      )
    );
  }
}
