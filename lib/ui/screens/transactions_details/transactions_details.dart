import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../models/recent_transaction_model.dart';
import '../../../services/transaction_service.dart';
import '../../widgets/transaction_trend_chart.dart';
import '../../widgets/transaction_month_group.dart';

class TransactionsDetailsScreen extends StatefulWidget {
  const TransactionsDetailsScreen({super.key});

  @override
  State<TransactionsDetailsScreen> createState() => _TransactionsDetailsScreenState();
}

class _TransactionsDetailsScreenState extends State<TransactionsDetailsScreen> {
  final TransactionService _transactionService = TransactionService();
  List<FlSpot> chartData = [];
  List<String> monthLabels = [];
  List<RecentTransaction> transactions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Load transaction trends for the chart
      final trendData = await _transactionService.getTransactionTrends();
      final List<String> labels = List<String>.from(trendData['monthLabels']);
      final List<double> values = List<double>.from(trendData['values']);
      
      List<FlSpot> spots = [];
      for (int i = 0; i < values.length; i++) {
        spots.add(FlSpot(i.toDouble(), values[i]));
      }

      // Load transactions
      final transactionList = await _transactionService.getTransactions();

      setState(() {
        chartData = spots;
        monthLabels = labels;
        transactions = transactionList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF2F2F2F)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Transactions',
          style: TextStyle(
            color: Color(0xFF2F2F2F),
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    TransactionTrendChart(
                      chartData: chartData,
                      monthLabels: monthLabels,
                    ),
                    TransactionMonthGroup(transactions: transactions),
                  ],
                ),
              ),
            ),
    );
  }
}