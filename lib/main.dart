import 'package:flutter/material.dart';
import 'screens/tabs_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: UniversityApp()
    )
  );
}

class UniversityApp extends StatelessWidget {
  const UniversityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Університет',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: const TabsScreen(),
    );
  }
}
