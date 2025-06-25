import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/grade_models.dart';

class TeacherCommentsWidget extends StatelessWidget {
  final List<TeacherComment> comments;

  const TeacherCommentsWidget({
    super.key,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Teacher Comments',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ...comments.map((comment) => TeacherCommentItem(comment: comment)),
        ],
      ),
    );
  }
}

class TeacherCommentItem extends StatelessWidget {
  final TeacherComment comment;

  const TeacherCommentItem({
    super.key,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('MMM d, yyyy');
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Teacher Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.shade100,
            ),
            child: comment.teacherImage.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      comment.teacherImage,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _defaultAvatar(),
                    ),
                  )
                : _defaultAvatar(),
          ),
          const SizedBox(width: 12),
          // Comment Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.teacherName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      dateFormatter.format(comment.date),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  comment.comment,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _defaultAvatar() {
    return const Icon(
      Icons.person,
      color: Colors.blue,
      size: 24,
    );
  }
} 