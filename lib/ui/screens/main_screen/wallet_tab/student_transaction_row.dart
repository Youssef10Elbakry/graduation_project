import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/recent_transaction_model.dart';
import 'package:intl/intl.dart';

class StudentTransactionRow extends StatefulWidget {
  RecentTransaction recentTransaction;
  StudentTransactionRow({super.key,required this.recentTransaction});

  @override
  State<StudentTransactionRow> createState() => _StudentTransactionRowState();
}

class _StudentTransactionRowState extends State<StudentTransactionRow> {

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat("MMM dd, h:mm a").format(widget.recentTransaction.date);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height*0.01786, horizontal: width*0.049),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(widget.recentTransaction.avatarPath),
            radius: 20,
          ),
          SizedBox(width: width*0.01116,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.recentTransaction.studentName, style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14),),
              Opacity(
                opacity: 0.4,
                  child: Text(formattedDate.toString(), style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12),)
              ),


            ],
          ),
          const Spacer(),
          Text("EGP ${widget.recentTransaction.amount.toString()} ", style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 16))
        ],
      ),
    );
  }
}
