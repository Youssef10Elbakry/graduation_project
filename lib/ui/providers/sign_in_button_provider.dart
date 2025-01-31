import 'package:flutter/cupertino.dart';

class SignInButtonProvider extends ChangeNotifier{
  bool isLoading = false;
  void startLoading(){
    isLoading = true;
    notifyListeners();
  }
  void stopLoading(){
    isLoading = false;
    notifyListeners();
  }
}

