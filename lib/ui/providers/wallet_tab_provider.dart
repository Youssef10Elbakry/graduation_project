import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/models/child_model.dart';
import 'package:graduation_project/models/recent_transaction_model.dart';
import 'package:http/http.dart' as secureStorage;
import 'package:http/http.dart' as http;

class WalletTabProvider extends ChangeNotifier{
  bool isLoadingChildren = true;
  bool isLoadingRecentTransactions = true;
  List<ChildModel> children = [];
  List<RecentTransaction> recentTransactions = [];
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> getChildren() async {
    children = [];
    isLoadingChildren = true;
    notifyListeners();
    try{
      final String token = (await secureStorage.read(key: "authentication_key"))!;
    print("Token in wallet Tab Provider: $token");
    final url = Uri.parse('https://parentstarck.site/parent/getWallet');
    print("I am here parse");
    final response = await http.get(
    url,
    headers: {
    'Authorization': 'Bearer $token',
    },
    );
    if (response.statusCode == 200) {
    final data = json.decode(response.body);
    for(int i = 0; i<data['parent']['childs'].length;i++){
    children.add(ChildModel.fromJson(data['parent']['childs'][i]));
    print(data['parent']['childs'][i]['balance']);
    print(children[i].username);
    }
    print("children: $children");
    isLoadingChildren = false;
    notifyListeners();
    } else {
    print("Error while loading chidlren");
    }
    }
    catch(error){
    print("$error hhh");
    }
  }


  Future<void> getRecentTransactions() async {
    recentTransactions = [];
    isLoadingRecentTransactions = true;
    notifyListeners();
    try{
      final String token = (await secureStorage.read(key: "authentication_key"))!;
    print("Token in wallet Tab Provider: $token");
    final url = Uri.parse('https://parentstarck.site/parent/getWallet');
    print("I am here parse");
    final response = await http.get(
    url,
    headers: {
    'Authorization': 'Bearer $token',
    },
    );
    if (response.statusCode == 200) {
    final data = json.decode(response.body);
    for(int i = 0; i<data['parent']['transactionHistory'].length;i++){
    recentTransactions.add(RecentTransaction.fromJson(data['parent']['transactionHistory'][i]));
    print(recentTransactions[i].amount);
    }
    print("children: $recentTransactions");
    isLoadingRecentTransactions = false;
    notifyListeners();
    } else {
    print("Error while loading recent transactions");
    }
    }
    catch(error){
    print("$error hhh");
    }
  }
  void onChildTapped(String id){

  }


}