import 'package:flutter/material.dart';
import '../models/student.dart';

class StudentEditor extends StatefulWidget {
  final Student? student;
  final Function(Student) onSave;

  const StudentEditor({Key? key, this.student, required this.onSave})
      : super(key: key);

  @override
  _StudentEditorState createState() => _StudentEditorState();
}

class _StudentEditorState extends State<StudentEditor> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  Department _selectedDepartment = Department.finance;
  Gender _selectedGender = Gender.male;
  int _grade = 1;

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _firstNameController.text = widget.student!.firstName;
      _lastNameController.text = widget.student!.lastName;
      _selectedDepartment = widget.student!.department;
      _selectedGender = widget.student!.gender;
      _grade = widget.student!.grade;
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _saveStudent() {
    final newStudent = Student(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      department: _selectedDepartment,
      grade: _grade,
      gender: _selectedGender,
    );
    widget.onSave(newStudent);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Редагувати студента',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
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
              _buildDropdown<Department>(
                value: _selectedDepartment,
                label: 'Факультет',
                items: Department.values,
                onChanged: (dept) {
                  setState(() => _selectedDepartment = dept!);
                },
                iconData: departmentIcons,
              ),
              const SizedBox(height: 12),
              _buildDropdown<Gender>(
                value: _selectedGender,
                label: 'Стать',
                items: Gender.values,
                onChanged: (gender) {
                  setState(() => _selectedGender = gender!);
                },
              ),
              const SizedBox(height: 12),
              _buildGradeField(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Відмінити'),
                  ),
                  ElevatedButton(
                    onPressed: _saveStudent,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Зберегти'),
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
        prefixIcon: Icon(icon, color: Colors.indigo),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required String label,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    Map<T, IconData>? iconData,
  }) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: DropdownButton<T>(
        value: value,
        isExpanded: true,
        underline: Container(),
        icon: const Icon(Icons.arrow_drop_down, color: Colors.indigo),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Row(
              children: [
                if (iconData != null)
                  Icon(
                    iconData[item],
                    color: Colors.indigo,
                    size: 20,
                  ),
                if (iconData != null) const SizedBox(width: 8),
                Text(item.toString().split('.').last),
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildGradeField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Оцінка',
        prefixIcon: const Icon(Icons.grade, color: Colors.indigo),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        final grade = int.tryParse(value);
        if (grade != null) {
          setState(() => _grade = grade);
        }
      },
    );
  }
}
