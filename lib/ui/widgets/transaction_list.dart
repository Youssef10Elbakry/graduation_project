import 'package:flutter/material.dart';
import '../../models/recent_transaction_model.dart';
import 'transaction_list_item.dart';

class TransactionList extends StatelessWidget {
  final List<RecentTransaction> transactions;

  const TransactionList({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    // Sort transactions by date (newest first)
    final sortedTransactions = List<RecentTransaction>.from(transactions)
      ..sort((a, b) => b.date.compareTo(a.date));
    
    return Column(
      children: sortedTransactions.map((transaction) {
        return TransactionListItem(transaction: transaction);
      }).toList(),
    );
  }
}