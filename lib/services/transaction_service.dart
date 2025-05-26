import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recent_transaction_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class TransactionService {
  final String baseUrl = 'https://parentstarck.site';
  static const String TOKEN_KEY = 'authentication_key';
  final secureStorage = const FlutterSecureStorage();
  
  // Get token from secure storage
  Future<String?> _getToken() async {
    return await secureStorage.read(key: TOKEN_KEY);
  }

  Future<Map<String, dynamic>> getWalletData() async {
    try {
      final String? token = await _getToken();
      if (token == null) {
        throw Exception('Authentication token not found');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/parent/getWallet'),
        headers: {'Authorization': 'Bearer $token'},
      );
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return data;
      } else {
        throw Exception('Failed to load wallet data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load wallet data: $e');
    }
  }
  
  Future<List<RecentTransaction>> getTransactions() async {
    try {
      final walletData = await getWalletData();
      final parentData = walletData['parent'];
      final List<dynamic> transactions = parentData['transactionHistory'];
      
      return transactions.map((transaction) {
        // Handle transactions with or without student info
        String studentName = '';
        // Use gray profile icon as default for empty profile pictures
        String avatarPath = 'assets/images/grey_profile_icon.png';
        
        if (transaction.containsKey('student')) {
          studentName = transaction['student']['username'];
          // Use the profile picture if available, otherwise use gray profile icon
          if (transaction['student']['profilePicture'] != null && 
              transaction['student']['profilePicture'].toString().isNotEmpty) {
            avatarPath = transaction['student']['profilePicture'];
          }
        }
        
        // For transactions like payments or withdrawals without student info
        if (studentName.isEmpty && transaction['type'] != null) {
          studentName = transaction['type'].toString().toUpperCase();
        }
        
        // Determine if amount should be negative based on transaction type
        num amountValue = transaction['amount'];
        int amount = amountValue.toInt();
        if (transaction['type'] == 'withdrawal' || transaction['type'] == 'payment') {
          amount = -amount;
        }
        
        // Use current time if not available
        DateTime date = DateTime.now();
        
        // Convert _id to DateTime if possible (MongoDB ObjectIds contain timestamp)
        if (transaction['_id'] != null) {
          String id = transaction['_id'];
          if (id.length >= 8) {
            try {
              // Extract timestamp from MongoDB ObjectId (first 8 chars of 24-char id)
              int timestamp = int.parse(id.substring(0, 8), radix: 16);
              date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
            } catch (e) {
              // Use current time if conversion fails
            }
          }
        }
        
        return RecentTransaction(
          avatarPath: avatarPath,
          studentName: studentName,
          date: date,
          amount: amount
        );
      }).toList();
    } catch (e) {
      throw Exception('Failed to load transactions: $e');
    }
  }
  
  Future<Map<String, dynamic>> getTransactionTrends() async {
    try {
      final walletData = await getWalletData();
      final parentData = walletData['parent'];
      final List<dynamic> transactions = parentData['transactionHistory'];
      
      // Get current date
      final now = DateTime.now();
      
      // Prepare the month labels for the last 6 months
      List<String> monthLabels = [];
      List<double> monthlyAmounts = List.filled(6, 0.0);
      List<int> monthKeys = [];
      
      // Generate the month keys and labels for the last 6 months
      for (int i = 0; i < 6; i++) {
        final DateTime monthDate = DateTime(now.year, now.month - i, 1);
        final String monthName = _getMonthName(monthDate.month);
        monthLabels.insert(0, monthName);
        
        // Create a unique month key (YYYYMM format)
        final int monthKey = monthDate.year * 100 + monthDate.month;
        monthKeys.insert(0, monthKey);
      }
      
      // Process all transactions
      for (var transaction in transactions) {
        try {
          // Get transaction date
          DateTime transactionDate;
          if (transaction['_id'] != null) {
            String id = transaction['_id'];
            if (id.length >= 8) {
              try {
                int timestamp = int.parse(id.substring(0, 8), radix: 16);
                transactionDate = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
              } catch (e) {
                // Skip if can't parse date
                continue;
              }
            } else {
              continue;
            }
          } else {
            continue;
          }
          
          // Create month key for this transaction
          final int transactionMonthKey = transactionDate.year * 100 + transactionDate.month;
          
          // Find index of this month in our list
          final int monthIndex = monthKeys.indexOf(transactionMonthKey);
          if (monthIndex != -1) {
            // Parse the amount
            num amountValue = transaction['amount'];
            double amount = amountValue.toDouble();
            
            // Determine if it's positive or negative
            String type = transaction['type']?.toString().toLowerCase() ?? '';
            if (type == 'withdrawal' || type == 'payment') {
              amount = -amount;
            }
            
            // Add to the correct month
            monthlyAmounts[monthIndex] += amount;
          }
        } catch (e) {
          // Skip any transaction that causes an error
          continue;
        }
      }
      
      return {
        'monthLabels': monthLabels,
        'values': monthlyAmounts,
      };
    } catch (e) {
      throw Exception('Failed to load transaction trends: $e');
    }
  }
  
  String _getMonthName(int month) {
    const monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return monthNames[(month - 1) % 12];
  }
}