import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentItem extends StatelessWidget {
  final Student student;
  final VoidCallback onEdit;

  const StudentItem({
    super.key,
    required this.student,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final gradientColors = student.gender == Gender.male
        ? [Colors.blue.shade200, Colors.blue.shade500]
        : [Colors.pink.shade200, Colors.pink.shade500];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        leading: ClipPath(
          clipper: HexagonClipper(),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12),
            child: Icon(
              student.department.icon,
              color: student.gender == Gender.male ? Colors.blue : Colors.pink,
              size: 28,
            ),
          ),
        ),
        title: Text(
          '${student.firstName} ${student.lastName}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Факультет: ${student.department.name}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Оцінка: ${student.grade}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ],
        ),
        trailing: ElevatedButton(
          onPressed: onEdit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          child: const Icon(
            Icons.edit_note,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

class HexagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;
    path.moveTo(w * 0.5, 0); // Top-center
    path.lineTo(w, h * 0.25); // Top-right
    path.lineTo(w, h * 0.75); // Bottom-right
    path.lineTo(w * 0.5, h); // Bottom-center
    path.lineTo(0, h * 0.75); // Bottom-left
    path.lineTo(0, h * 0.25); // Top-left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
