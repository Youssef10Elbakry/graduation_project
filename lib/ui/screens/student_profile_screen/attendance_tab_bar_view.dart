import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/ui/screens/attendence_screen/attendance_screen.dart';

class AttendanceTabBarView extends StatefulWidget {
  const AttendanceTabBarView({super.key});

  @override
  State<AttendanceTabBarView> createState() => _AttendanceTabBarViewState();
}

class _AttendanceTabBarViewState extends State<AttendanceTabBarView> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const AttendanceScreen(studentId: "68338d3b5918955bae6677a6")));
                },
                child: const Text("View All", style: TextStyle(color: Color(0xff3491DB), fontSize: 16, fontWeight: FontWeight.w500)),
              )
            ],
          ),

        ),
        const SizedBox(height: 20,),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
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
              rows: [
                _buildRow('PRESENT', '2024/09/30', '8:30', Colors.green),
                _buildRow('PRESENT', '2023/09/29', '8:30', Colors.green),
                _buildRow('LATE', '2023/09/28', '9:00', Colors.orange),
                _buildRow('PRESENT', '2023/09/27', '8:30', Colors.green),
                _buildRow('PRESENT', '2023/09/26', '8:30', Colors.green),
                _buildRow('ABSENT', '2023/09/25', '-', Colors.red),
              ],
            ),
          ),
        ),
      ],
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
