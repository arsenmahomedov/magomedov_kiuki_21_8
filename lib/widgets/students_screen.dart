import 'package:flutter/material.dart';
import '../models/student.dart';
import 'student_item.dart';
import 'new_student.dart';

class StudentListView extends StatefulWidget {
  const StudentListView({Key? key}) : super(key: key);

  @override
  _StudentListViewState createState() => _StudentListViewState();
}

class _StudentListViewState extends State<StudentListView> {
  List<Student> studentRecords = [
    Student(
      firstName: 'Марія',
      lastName: 'Шевченко',
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
  ];

  void _openStudentEditor({Student? student, int? index}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StudentEditor(
          student: student,
          onSave: (updatedStudent) {
            setState(() {
              if (index == null) {
                studentRecords.add(updatedStudent);
              } else {
                studentRecords[index] = updatedStudent;
              }
            });
          },
        );
      },
    );
  }

  void _removeStudent(int index) {
    final removedStudent = studentRecords[index];
    setState(() {
      studentRecords.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${removedStudent.firstName} видалено'),
        action: SnackBarAction(
          label: 'Відмінити',
          onPressed: () {
            setState(() {
              studentRecords.insert(index, removedStudent);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список студентів'),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        itemCount: studentRecords.length,
        itemBuilder: (context, index) {
          final student = studentRecords[index];
          return Dismissible(
            key: ValueKey(student),
            background: Container(color: Colors.red),
            onDismissed: (_) => _removeStudent(index),
            child: InkWell(
              onTap: () => _openStudentEditor(student: student, index: index),
              child: SingleStudentCard(student: student), 
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openStudentEditor(),
        backgroundColor: Colors.orange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
