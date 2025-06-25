import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InsightsTabBarViewProvider extends ChangeNotifier{
  String timeFilter = "Semester";
  List semesterAttendance = [];
  List yearAttendance = [];
  List attendanceToShow = [];
  List attendanceToShowColors = [];

  void getAttendanceToShowDetails(){
    semesterAttendance = [5,2,9,1,3,7,10];
    yearAttendance = [10,3,8,4,7,6,2];
    attendanceToShow = semesterAttendance;
    attendanceToShowColors = attendanceToShow.map((value){
      if(value<=4){
        return Colors.red;
      }
      else if(value>4 && value<=7){
        return Colors.yellow;
      }
      else{
        return Colors.green;
      }
    }).toList();
    notifyListeners();
  }

  void changeTimeFilter(String value){
    if(value == "Semester"){
      timeFilter = value;
      attendanceToShow = semesterAttendance;
      attendanceToShowColors = attendanceToShow.map((value){
        if(value<=4){
          return Colors.red;
        }
        else if(value>4 && value<=7){
          return Colors.yellow;
        }
        else{
          return Colors.green;
        }
      }).toList();

    }
    else{
      timeFilter = value;
      attendanceToShow = yearAttendance;
      attendanceToShowColors = attendanceToShow.map((value){
        if(value<=4){
          return Colors.red;
        }
        else if(value>4 && value<=7){
          return Colors.yellow;
        }
        else{
          return Colors.green;
        }
      }).toList();

    }

    notifyListeners();
  }

}