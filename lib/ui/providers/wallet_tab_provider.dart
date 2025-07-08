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
  Function(String id, String username, String imageUrl)? requestBottomSheet;
  List<ChildModel> children = [];
  List<RecentTransaction> recentTransactions = [];
  String parentProfilePictureLink = "";
  String parentUsername = "";
  int parentBalance = 0;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<void> getParentProfileData() async {
    try{
      final String token = (await secureStorage.read(key: "authentication_key"))!;
    final url = Uri.parse('https://parentstarck.site/parent/getWallet');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      parentProfilePictureLink = data['parent']['profilePicture'];
      parentUsername = data['parent']['username'];
      parentBalance = data['parent']['balance'];
      print("Parent Profile Picture Link: $parentProfilePictureLink");
      print("Parent Profile Username: $parentUsername");
      print("Parent Profile Balance: $parentBalance");
      notifyListeners();
    } else {
      print("Error while loading parent profile picture link");
    }
  }
  catch(error){
  print("$error hhh");
  }
}

  Future<void> getChildren() async {
    children = [];
    isLoadingChildren = true;
    notifyListeners();
    try{
      final String token = (await secureStorage.read(key: "authentication_key"))!;
    final url = Uri.parse('https://parentstarck.site/parent/getWallet');
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
    }
    recentTransactions.sort((a, b) => b.date.compareTo(a.date));
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
  void onChildTapped(String id, String username, String imageUrl){
    if (requestBottomSheet != null) {
      print("Child Id:   *** $id");
      requestBottomSheet!(id, username, imageUrl);

    }
  }


}