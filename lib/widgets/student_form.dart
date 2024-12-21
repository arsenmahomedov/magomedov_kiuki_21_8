import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/student.dart';
import '../models/department.dart';

class StudentForm extends StatefulWidget {
  final Student? student;
  final Function(Student) onSave;

  const StudentForm({super.key, this.student, required this.onSave});

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  Department? _selectedDepartment;
  Gender? _selectedGender;
  int _grade = 0;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _firstNameController.text = widget.student!.firstName;
      _lastNameController.text = widget.student!.lastName;
      _selectedDepartment = predefinedDepartments.firstWhere(
        (dept) => dept.id == widget.student!.departmentId,
        orElse: () => predefinedDepartments.first,
      );
      _selectedGender = widget.student!.gender;
      _grade = widget.student!.grade;
    }
  }

  void _saveStudent() {
    if (_firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _selectedDepartment == null ||
        _selectedGender == null) {
      return;
    }

    final newStudent = Student(
      id: widget.student?.id ?? const Uuid().v4(),
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      departmentId: _selectedDepartment!.id,
      grade: _grade,
      gender: _selectedGender!,
    );

    widget.onSave(newStudent);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepOrange.shade50, Colors.amber.shade100],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Форма студента',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrangeAccent,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _firstNameController,
                label: 'Ім\'я',
                icon: Icons.person,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                controller: _lastNameController,
                label: 'Прізвище',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Department>(
                value: _selectedDepartment,
                decoration: InputDecoration(
                  labelText: 'Факультет',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                items: predefinedDepartments.map((department) {
                  return DropdownMenuItem(
                    value: department,
                    child: Row(
                      children: [
                        Icon(
                          department.icon,
                          size: 20,
                          color: Colors.orangeAccent, // Использование кастомного цвета
                        ),
                        const SizedBox(width: 8),
                        Text(department.name), // Отображение названия факультета
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) => setState(() => _selectedDepartment = value),
              ),

              const SizedBox(height: 12),
              _buildDropdown<Gender>(
                value: _selectedGender,
                label: 'Стать',
                items: Gender.values,
                onChanged: (gender) => setState(() => _selectedGender = gender),
              ),
              const SizedBox(height: 12),
              _buildSlider(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildButton(
                    label: 'Відмінити',
                    color: const Color.fromARGB(255, 175, 143, 255),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  _buildButton(
                    label: widget.student == null ? 'Додати' : 'Оновити',
                    color: const Color.fromARGB(255, 181, 255, 34),
                    onPressed: _saveStudent,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.orange),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T? value,
    required String label,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    IconData Function(T)? iconData,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Row(
            children: [
              if (iconData != null)
                Icon(
                  iconData(item),
                  size: 20,
                  color: Colors.orangeAccent,
                ),
              if (iconData != null) const SizedBox(width: 8),
              Text(item.toString().split('.').last),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Оцінка: $_grade',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
        Slider(
          value: _grade.toDouble(),
          min: 0,
          max: 100,
          divisions: 100,
          activeColor: const Color.fromARGB(255, 99, 222, 23),
          thumbColor: const Color.fromARGB(255, 255, 0, 251),
          label: '$_grade',
          onChanged: (value) => setState(() => _grade = value.toInt()),
        ),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
