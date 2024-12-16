import 'package:flutter/material.dart';
import '../models/student.dart';
import 'student_item.dart';

class StudentsScreen extends StatelessWidget {
  StudentsScreen({Key? key}) : super(key: key);

  final List<Student> students = [
    Student(
      firstName: 'Анна',
      lastName: 'Коваль',
      department: Department.finance,
      grade: 85,
      gender: Gender.female,
    ),
    Student(
      firstName: 'Дмитро',
      lastName: 'Сидоренко',
      department: Department.it,
      grade: 90,
      gender: Gender.male,
    ),
    Student(
      firstName: 'Олена',
      lastName: 'Шевченко',
      department: Department.medical,
      grade: 95,
      gender: Gender.female,
    ),
    Student(
      firstName: 'Іван',
      lastName: 'Богданов',
      department: Department.law,
      grade: 80,
      gender: Gender.male,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Студенти',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
        backgroundColor: Colors.teal,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.separated(
          itemCount: students.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            return StudentItem(student: students[index]);
          },
        ),
      ),
    );
  }
}
