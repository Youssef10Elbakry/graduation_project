import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ui/screens/main_screen/home_tab/home_tab.dart';
import 'package:graduation_project/ui/screens/main_screen/profile_tab/profile_tab.dart';
import 'package:graduation_project/ui/screens/main_screen/wallet_tab/wallet_tab.dart';

class MainScreen extends StatefulWidget {
  static String screenName = "Main Screen";
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> tabs = [ProfileTab(), HomeTab(), const WalletTab()];
  int currIndex = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currIndex,
        onTap: (index) {
          currIndex = index;
          setState(() {});
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: 'Announcements',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),

    );
  }
}
