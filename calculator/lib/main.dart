import 'package:flutter/material.dart';
import 'pages/calculator_page.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cuesta Calculator Activity 3',
      home: const CalculatorPage(),
    );
  }
}
