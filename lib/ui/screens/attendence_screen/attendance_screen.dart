import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '/models/attendance_record.dart';
import '/services/attendance_service.dart';

class AttendanceScreen extends StatefulWidget {
  final String studentId;

  const AttendanceScreen({super.key, required this.studentId});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  DateTime today = DateTime.now();
  String filter = "Last week"; // Default filter
  List<AttendanceRecord> attendanceRecords = [];
  List<AttendanceRecord> filteredRecords = [];
  bool isLoading = true;
  Map<DateTime, AttendanceRecord> attendanceMap = {};
  DateTimeRange? selectedDateRange;

  final List<String> filterOptions = [
    "Last week",
    "Last month",
    "Last 3 months",
    "Last 6 months",
    "Custom Range",
    "All"
  ];

  @override
  void initState() {
    super.initState();
    _fetchAttendanceData();
  }

  Future<void> _fetchAttendanceData() async {
    try {
      final service = AttendanceService();
      final records = await service.getStudentAttendance(widget.studentId);
      final Map<DateTime, AttendanceRecord> newAttendanceMap = {};
      
      for (var record in records) {
        final date = DateTime(record.date.year, record.date.month, record.date.day);
        newAttendanceMap[date] = record;
      }

      setState(() {
        attendanceRecords = records;
        filteredRecords = _filterRecords(records, filter);
        attendanceMap = newAttendanceMap;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading attendance data: $e')),
      );
    }
  }

  Future<void> _selectDateRange() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDateRange: selectedDateRange ?? DateTimeRange(
        start: DateTime(DateTime.now().year, 1, 1),
        end: DateTime(DateTime.now().year, 3, 31),
      ),
    );
    if (picked != null) {
      setState(() {
        selectedDateRange = picked;
        filter = "Custom Range";
        filteredRecords = _filterRecords(attendanceRecords, filter);
      });
    }
  }

  List<AttendanceRecord> _filterRecords(List<AttendanceRecord> records, String filter) {
    final now = DateTime.now();
    switch (filter) {
      case "Last week":
        final lastWeek = now.subtract(const Duration(days: 7));
        return records.where((record) => record.date.isAfter(lastWeek)).toList();
      
      case "Last month":
        final lastMonth = DateTime(now.year, now.month - 1, now.day);
        return records.where((record) => record.date.isAfter(lastMonth)).toList();
      
      case "Custom Range":
        if (selectedDateRange != null) {
          return records.where((record) => 
            record.date.isAfter(selectedDateRange!.start.subtract(const Duration(days: 1))) &&
            record.date.isBefore(selectedDateRange!.end.add(const Duration(days: 1)))
          ).toList();
        }
        return records;
      
      case "All":
        return records;
      
      default:
        return records;
    }
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  } 

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "present":
        return const Color(0xFF4CAF50);  // Green
      case "late":
        return const Color(0xFFFF9800);  // Orange
      case "absent":
        return const Color(0xFFF44336);  // Red
      default:
        return Colors.transparent;
    }
  }

  void _showFilterOptions() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Select Range',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6156C8),
                ),
              ),
            ),
            ...filterOptions.map((option) => InkWell(
              onTap: () {
                Navigator.pop(context);
                if (option == "Custom Range") {
                  _selectDateRange();
                } else {
                  setState(() {
                    filter = option;
                    selectedDateRange = null;
                    filteredRecords = _filterRecords(attendanceRecords, filter);
                  });
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                child: Text(
                  option,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: filter == option ? FontWeight.w600 : FontWeight.w400,
                    color: filter == option ? const Color(0xFF6156C8) : Colors.black87,
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/back_icon.svg'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Text(
              "Attendance",
              style: GoogleFonts.inter(
                color: Colors.white,
                  fontWeight: FontWeight.w600,
                fontSize: 24,
              ),
              ),
            ),
          ),
          backgroundColor: const Color(0xFF6156C8),
          elevation: 0,
          actions: [Container(width: 48)],
        ),
      ),
      body: RefreshIndicator(
        color: const Color(0xFF6156C8),
        onRefresh: () async {
          await _fetchAttendanceData();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
        children: [
          // Calendar Widget
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF6156C8),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: TableCalendar(
              locale: 'en_US',
                    rowHeight: 45,
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      leftChevronIcon: const Icon(Icons.chevron_left, color: Colors.white),
                      rightChevronIcon: const Icon(Icons.chevron_right, color: Colors.white),
                    ),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(color: Colors.white70),
                      weekendStyle: TextStyle(color: Colors.white70),
                    ),
                    calendarStyle: const CalendarStyle(
                      outsideDaysVisible: false,
                      defaultTextStyle: TextStyle(color: Colors.white),
                      weekendTextStyle: TextStyle(color: Colors.white),
                    ),
              availableGestures: AvailableGestures.all,
              focusedDay: today,
              selectedDayPredicate: (day) => isSameDay(today, day),
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 31, 12),
              onDaySelected: _onDaySelected,
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        final attendance = attendanceMap[DateTime(day.year, day.month, day.day)];
                        if (attendance != null) {
                          return Container(
                            margin: const EdgeInsets.all(4.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _getStatusColor(attendance.status),
                            ),
                            child: Text(
                              '${day.day}',
                              style: GoogleFonts.inter(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          child: Text(
                            '${day.day}',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        );
                      },
                      selectedBuilder: (context, day, focusedDay) {
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.3),
                          ),
                          child: Text(
                            '${day.day}',
                            style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                      todayBuilder: (context, day, focusedDay) {
                        final attendance = attendanceMap[DateTime(day.year, day.month, day.day)];
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: attendance != null 
                                ? _getStatusColor(attendance.status)
                                : Colors.orange,
                          ),
                  child: Text(
                            '${day.day}',
                  style: GoogleFonts.inter(
                              color: Colors.white,
                  fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                  ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // History section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "History",
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                        color: const Color(0xFFF5F4FB),
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: const Color(0xFF6156C8).withOpacity(0.2)),
                      ),
                      child: InkWell(
                        onTap: _showFilterOptions,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              filter == "Custom Range" && selectedDateRange != null
                                  ? "${selectedDateRange!.start.day}/${selectedDateRange!.start.month} - ${selectedDateRange!.end.day}/${selectedDateRange!.end.month}"
                                  : filter,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF6156C8),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                              color: Color(0xFF6156C8),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              if (selectedDateRange != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6156C8).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.date_range,
                          size: 18,
                          color: Color(0xFF6156C8),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${selectedDateRange!.start.day}/${selectedDateRange!.start.month}/${selectedDateRange!.start.year} - '
                          '${selectedDateRange!.end.day}/${selectedDateRange!.end.month}/${selectedDateRange!.end.year}',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF6156C8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              // Attendance Table
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: isLoading
                    ? const SizedBox(
                        height: 200,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6156C8)),
                          ),
                        ),
                      )
                    : DataTable(
                        columnSpacing: 50,
                        headingRowHeight: 50,
                        dataRowMinHeight: 56,
                        dataRowMaxHeight: 56,
                columns: [
                          DataColumn(
                            label: Center(child: Text('Status',
                              style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),),
                          ),
                          DataColumn(
                            label: Center(child: Text('Date',
                              style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),),
                          ),
                          DataColumn(
                            label: Center(child: Text('Time',
                              style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),),
                          ),
                        ],
                        rows: filteredRecords.map((record) => DataRow(
                          cells: [
                            DataCell(Center(child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: _getStatusColor(record.status).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                record.status.toUpperCase(),
                                style: GoogleFonts.inter(
                                  color: _getStatusColor(record.status),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ))),
                            DataCell(Center(child: Text(
                              record.formattedDate,
                              style: GoogleFonts.inter(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ))),
                            DataCell(Center(child: Text(
                              record.formattedTime,
                              style: GoogleFonts.inter(
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ))),
                          ],
                        )).toList(),
                      ),
              ),
              // Add some bottom padding
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
