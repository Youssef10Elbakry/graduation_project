import 'package:flutter/material.dart';
import 'number_pad_sheet.dart';

class AmountSelectionSheet extends StatefulWidget {
  @override
  _AmountSelectionSheetState createState() => _AmountSelectionSheetState();
}

class _AmountSelectionSheetState extends State<AmountSelectionSheet> {
  static const String routeName = 'amount_selection_sheet';
  String amount = "0";

  void _showNumberPadSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => NumberPadSheet(
        onAmountSelected: (selectedAmount) {
          setState(() {
            amount = selectedAmount;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
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
            'Youssuf Mahmoud',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          CircleAvatar(
            backgroundImage: AssetImage('assets/youssuf_mahmoud.png'),
            radius: 35,
          ),
        ],
      ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () => _showNumberPadSheet(context),
            child: Text(
              'EGP $amount',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlueAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text('Send'),
            ),
          ),
        ],
      ),
    );
  }
}
