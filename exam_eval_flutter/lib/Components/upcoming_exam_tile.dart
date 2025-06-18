import 'package:flutter/material.dart';

class UpcomingExamTile extends StatelessWidget {
  final String subject;
  final String date;
  final String examType;
  final VoidCallback? onTap;

  const UpcomingExamTile({
    super.key,
    required this.subject,
    required this.date,
    required this.examType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 👈 ensures left alignment
          children: [
            Text(
              subject,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "$examType  •  $date",
              style: const TextStyle(
                fontSize: 13,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}