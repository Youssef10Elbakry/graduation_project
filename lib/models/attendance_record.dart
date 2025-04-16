import 'package:logging/logging.dart';

class AttendanceRecord {
  static final _logger = Logger('AttendanceRecord');
  final String id;
  final String student;
  final DateTime date;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  AttendanceRecord({
    required this.id,
    required this.student,
    required this.date,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AttendanceRecord.fromJson(Map<String, dynamic> json) {
    _logger.fine('Parsing attendance record: $json');
    return AttendanceRecord(
      id: json['_id'],
      student: json['student'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  String get formattedDate => '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  String get formattedTime => '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
}
