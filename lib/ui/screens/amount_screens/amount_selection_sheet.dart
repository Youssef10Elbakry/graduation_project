import 'package:flutter/material.dart';
import 'number_pad_sheet.dart';

class AmountSelectionSheet extends StatefulWidget {
  static const String routeName = 'amount_selection_sheet'; // ✅ Correct location

  const AmountSelectionSheet({super.key});

  @override
  _AmountSelectionSheetState createState() => _AmountSelectionSheetState();
}

class _AmountSelectionSheetState extends State<AmountSelectionSheet> {
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
        studentId: '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFF001645),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(
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
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => _showNumberPadSheet(context),
            child: Text(
              'EGP $amount',
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
    );
  }
}
