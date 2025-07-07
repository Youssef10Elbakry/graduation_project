import 'package:flutter/cupertino.dart';

class AnnouncementWidgetProvider extends ChangeNotifier{
  bool isExpanded = true;
  void showAndHideAnnouncementMessage(){
    if(isExpanded){
      isExpanded = false;
    }
    else{
      isExpanded = true;
    }
    notifyListeners();
  }

}