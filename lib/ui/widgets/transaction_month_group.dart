import 'package:flutter/material.dart';
import '../../models/recent_transaction_model.dart';
import 'month_header.dart';
import 'transaction_list.dart';

class TransactionMonthGroup extends StatelessWidget {
  final List<RecentTransaction> transactions;

  const TransactionMonthGroup({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    // Group transactions by month and year
    Map<String, List<RecentTransaction>> monthGroups = {};
    
    for (var transaction in transactions) {
      final month = transaction.date.month;
      final year = transaction.date.year;
      final key = '$year-$month';
      
      if (!monthGroups.containsKey(key)) {
        monthGroups[key] = [];
      }
      
      monthGroups[key]!.add(transaction);
    }
    
    // Sort keys in descending order (newest first)
    final sortedKeys = monthGroups.keys.toList()
      ..sort((a, b) => b.compareTo(a));
    
    List<Widget> monthSections = [];
    
    for (var key in sortedKeys) {
      final parts = key.split('-');
      final year = parts[0];
      final month = int.parse(parts[1]);
      
      final monthNames = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ];
      
      monthSections.add(MonthHeader(month: '${monthNames[month - 1]}, $year'));
      monthSections.add(
        TransactionList(transactions: monthGroups[key]!)
      );
    }
    
    return Column(children: monthSections);
  }
}