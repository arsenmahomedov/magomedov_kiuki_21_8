import 'package:flutter/material.dart';

class Department {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  const Department({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

const predefinedDepartments = [
  Department(
    id: 'finance',
    name: 'Фінанси',
    icon: Icons.monetization_on,
    color: Colors.green,
  ),
  Department(
    id: 'law',
    name: 'Право',
    icon: Icons.gavel,
    color: Colors.blue,
  ),
  Department(
    id: 'it',
    name: 'ІТ',
    icon: Icons.computer,
    color: Colors.teal,
  ),
  Department(
    id: 'medical',
    name: 'Медицина',
    icon: Icons.local_hospital,
    color: Colors.red,
  ),
];
