import 'package:flutter/material.dart';

class NumberPadSheet extends StatefulWidget {
  static const String routeName = 'number_pad_sheet';
  final Function(String) onAmountSelected;

  NumberPadSheet({required this.onAmountSelected});

  @override
  _NumberPadSheetState createState() => _NumberPadSheetState();
}

class _NumberPadSheetState extends State<NumberPadSheet> {
  String amount = "0";

  void _onKeyPress(String value) {
    setState(() {
      if (value == "←") {
        Navigator.pop(context);
      } else if (value == "⌫") {
        if (amount.length > 1) {
          amount = amount.substring(0, amount.length - 1);
        } else {
          amount = "0";
        }
      } else {
        if (amount == "0") {
          amount = value;
        } else {
          amount += value;
        }
      }
      widget.onAmountSelected(amount);
    });
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
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CircleAvatar(
                backgroundImage: AssetImage('assets/youssuf_mahmoud.png'),
                radius: 40,
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'EGP $amount',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
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
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
            ),
            itemCount: 12,
            itemBuilder: (context, index) {
              List<String> buttons = [
                "1", "2", "3",
                "4", "5", "6",
                "7", "8", "9",
                "←", "0", "⌫"
              ];
              return GestureDetector(
                onTap: () => _onKeyPress(buttons[index]),
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    buttons[index],
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}