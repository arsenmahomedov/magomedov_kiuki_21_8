import 'package:flutter/material.dart';

class Student {
  final String firstName;
  final String lastName;
  final Department department;
  final int grade;
  final Gender gender;

  Student({
    required this.firstName,
    required this.lastName,
    required this.department,
    required this.grade,
    required this.gender,
  });
}

const departmentIcons = {
  Department.finance: Icons.account_balance,
  Department.law: Icons.balance,
  Department.it: Icons.developer_mode,
  Department.medical: Icons.local_pharmacy,
};

enum Department { finance, law, it, medical }
enum Gender { male, female }