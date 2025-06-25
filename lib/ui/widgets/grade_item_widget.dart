import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GradeItemWidget extends StatelessWidget {
  final String name;
  final DateTime date;
  final int score;
  final int maxScore;
  final VoidCallback? onTap;

  const GradeItemWidget({
    super.key,
    required this.name,
    required this.date,
    required this.score,
    required this.maxScore,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('MMM d, yyyy');
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateFormatter.format(date),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '$score/$maxScore',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PendingGradeItemWidget extends StatelessWidget {
  final String title;
  final DateTime date;
  final String status;
  final VoidCallback? onTap;

  const PendingGradeItemWidget({
    super.key,
    required this.title,
    required this.date,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('MMM d, yyyy');
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateFormatter.format(date),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.orange.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ParticipationScoreWidget extends StatelessWidget {
  final int score;
  final int maxScore;

  const ParticipationScoreWidget({
    super.key,
    required this.score,
    required this.maxScore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Expanded(
              child: Text(
                'Participation Score',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ),
            Text(
              '$score/$maxScore',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 