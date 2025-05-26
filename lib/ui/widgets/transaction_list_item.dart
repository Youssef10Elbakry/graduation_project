import 'package:flutter/material.dart';
import '../../models/recent_transaction_model.dart';

class TransactionListItem extends StatelessWidget {
  final RecentTransaction transaction;

  const TransactionListItem({
    super.key,
    required this.transaction,
  });

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final month = months[date.month - 1];
    final day = date.day;
    
    String period = date.hour >= 12 ? 'PM' : 'AM';
    int hour = date.hour > 12 ? date.hour - 12 : date.hour;
    if (hour == 0) hour = 12;
    
    String minute = date.minute.toString().padLeft(2, '0');
    
    return '$month $day, ${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(transaction.avatarPath),
      ),
      title: Text(
        transaction.studentName,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      subtitle: Text(
        _formatDate(transaction.date),
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
      trailing: Text(
        '\$${transaction.amount.abs()}',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: transaction.amount < 0 ? Color(0xFF2F2F2F) : Colors.green,
        ),
      ),
    );
  }
}