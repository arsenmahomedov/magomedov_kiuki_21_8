import 'package:flutter/material.dart';
import '../models/student.dart';

class SingleStudentCard extends StatelessWidget {
  final Student student;

  const SingleStudentCard({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cardColor = student.gender == Gender.male
        ? Colors.blue.shade50
        : Colors.pink.shade50;

    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey.shade300,
            child: Icon(
              departmentIcons[student.department],
              size: 24,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${student.firstName} ${student.lastName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Оцінка: ${student.grade}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
