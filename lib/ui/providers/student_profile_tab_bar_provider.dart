import 'package:flutter/material.dart';

class StudentProfileTabBarProvider extends ChangeNotifier{
  Color tab1Color = const Color(0xff1849D6);
  Color tab2Color = const Color(0xffFFFFFF);
  Color tab3Color = const Color(0xffFFFFFF);
  Color selectedTabColor = const Color(0xff1849D6);
  Color unselectedTabColor = const Color(0xffFFFFFF);

  void resetColors(){
     tab1Color = const Color(0xff1849D6);
     tab2Color = const Color(0xffFFFFFF);
     tab3Color = const Color(0xffFFFFFF);
  }

  void changeTabColor(int value){
    if(value == 0){
      tab1Color = selectedTabColor;
      tab2Color = unselectedTabColor;
      tab3Color = unselectedTabColor;
    }
    else if(value == 1){
      tab1Color = unselectedTabColor;
      tab2Color = selectedTabColor;
      tab3Color = unselectedTabColor;
    }
    else if(value == 2){
      tab1Color = unselectedTabColor;
      tab2Color = unselectedTabColor;
      tab3Color = selectedTabColor;
    }
    notifyListeners();
  }
}