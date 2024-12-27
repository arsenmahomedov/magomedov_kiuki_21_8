import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/students_provider.dart';
import '../widgets/student_item.dart';
import '../widgets/student_form.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsState = ref.watch(studentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Студенти',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.teal.shade700,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box, color: Colors.white, size: 30),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) => const StudentForm(),
              );
            },
          ),
        ],
      ),
      body: () {
        if (studentsState.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (studentsState.students.isEmpty) {
          return const Center(
            child: Text("No students"),
          );
        } else {
          return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              itemCount: studentsState.students.length,
              itemBuilder: (context, index) {
                final student = studentsState.students[index];

                return Dismissible(
                  key: ValueKey(student.id),
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red.shade300, Colors.red.shade700],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete_forever,
                        color: Colors.white, size: 32),
                  ),
                  onDismissed: (_) {
                    final removedStudent = student;
                    ref.read(studentsProvider.notifier).remove(index);
                    final curContext = ProviderScope.containerOf(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.teal.shade800,
                        content: Text(
                          '${removedStudent.firstName} ${removedStudent.lastName} видалено',
                          style: const TextStyle(color: Colors.white),
                        ),
                        action: SnackBarAction(
                          label: 'Скасувати',
                          textColor: Colors.yellow,
                          onPressed: () {
                            curContext
                                .read(studentsProvider.notifier)
                                .undo();
                          },
                        ),
                      ),
                    ).closed.then((value) {
                        if (value != SnackBarClosedReason.action) {
                          ref.read(studentsProvider.notifier).erase();
                        }
                      });
                  },
                  child: StudentItem(
                    student: student,
                    onEdit: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (_) => StudentForm(studentIndex: index),
                      );
                    },
                  ),
                );
              },
            );
        
      }
      }(),
    );
  }
}
