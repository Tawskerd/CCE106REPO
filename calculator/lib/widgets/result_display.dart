import 'package:flutter/material.dart';

class ResultDisplay extends StatelessWidget {
  final double? result;

  const ResultDisplay({super.key, this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6)],
      ),
      child: Text(
        result == null ? "Result: " : "Result: ${result!.toStringAsFixed(2)}",
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.purple,
        ),
      ),
    );
  }
}
