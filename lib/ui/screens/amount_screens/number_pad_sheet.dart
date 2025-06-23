import 'package:flutter/material.dart';

Widget buildNumberPadSheet(
    BuildContext context,
    void Function(String) onAmountSelected,
    String studentId, // ✅ Used to pass to Passcode screen
    String imageUrl
    ) {
  String amount = "0";
  String? errorMessage;

  void onKeyPress(String value) {
    errorMessage = null;

    if (value == "←") {
      Navigator.pop(context);
    } else if (value == "⌫") {
      amount = amount.length > 1 ? amount.substring(0, amount.length - 1) : "0";
    } else {
      amount = amount == "0" ? value : amount + value;
    }

    onAmountSelected(amount);
    (context as Element).markNeedsBuild();
  }

  void onSendPressed() {
    final double enteredAmount = double.tryParse(amount) ?? 0.0;


      Navigator.pushNamed(
        context,
        '/passcode',
        arguments: {
          'studentId': studentId, // ✅ Passed to Passcode screen
          'amount': enteredAmount, // ✅ Passed to Passcode screen
        },
      );
  }

  return Container(
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
      color: Color(0xFF001645),
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    child: StatefulBuilder(
      builder: (context, setState) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Enter Amount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 40,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'EGP $amount',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onSendPressed,
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
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.5,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                final buttons = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "←", "0", "⌫"];
                return GestureDetector(
                  onTap: () {
                    setState(() => onKeyPress(buttons[index]));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      buttons[index],
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    ),
  );
}