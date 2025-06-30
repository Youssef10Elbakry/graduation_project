import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/models/attendance_record.dart';
import 'package:graduation_project/ui/screens/attendence_screen/attendance_screen.dart';

class AttendanceTabBarView extends StatefulWidget {
  String childId;
  List<AttendanceRecord>? records;
  AttendanceTabBarView({super.key, required this.childId, required this.records});

  @override
  State<AttendanceTabBarView> createState() => _AttendanceTabBarViewState();
}

class _AttendanceTabBarViewState extends State<AttendanceTabBarView> {

  Color getStatusColor(String status)=> status == 'present'? Colors.green: status == 'late'? Colors.orange: Colors.red;
  String getDateOnly(dateTime)=> "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  String getTimeOnly(dateTime)=> "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  
  void initState(){
    super.initState();
    print("Unsorted Attendance Records: of ${widget.records?[0].id} in created at date: ${widget.records?[0].createdAt}");
    widget.records?.sort((a, b) => b.date.compareTo(a.date));
    print("Attendance Records: of ${widget.records?[0].id} in created at date: ${widget.records?[0].createdAt}");
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            child: Row(
              children: [
                const Text("Last Week", style: TextStyle(color: Color(0xff2F2F2F), fontWeight: FontWeight.w600, fontSize: 16),),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    // TODO: Replace with actual student ID
                    print("Child Id in attendance tab bar view: ${widget.childId}");
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AttendanceScreen(studentId:widget.childId)));
                  },
                  child: const Text("View All", style: TextStyle(color: Color(0xff3491DB), fontSize: 16, fontWeight: FontWeight.w500)),
                )
              ],
            ),
      
          ),
          const SizedBox(height: 10,),
          SizedBox(
            width: width,
            child: DataTable(
              columnSpacing: 20,
              headingRowHeight: 40,
              dataRowHeight: 50,
              columns: const [
                DataColumn(label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Date', style: TextStyle(fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Login Time', style: TextStyle(fontWeight: FontWeight.bold))),
              ],
              rows: List.generate(7, (index)=>_buildRow(
                  widget.records![index].status.toUpperCase(),
                  getDateOnly(widget.records![index].createdAt),
                  getTimeOnly(widget.records![index].createdAt),
                  getStatusColor(widget.records![index].status)
              )),
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildRow(String status, String date, String time, Color color) {
    return DataRow(
      cells: [
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              status,
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        DataCell(Text(date)),
        DataCell(Text(time)),
      ],
    );
  }
}
