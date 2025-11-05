import 'package:flutter/material.dart';
import '../widgets/result_display.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController num1Controller = TextEditingController();
  final TextEditingController num2Controller = TextEditingController();
  double? result;

  void calculate(String operation) {
    double? num1 = double.tryParse(num1Controller.text);
    double? num2 = double.tryParse(num2Controller.text);

    if (num1 == null || num2 == null) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text("Invalid Input"),
          content: Text("Please enter valid numbers."),
        ),
      );
      return;
    }

    setState(() {
      switch (operation) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '*':
          result = num1 * num2;
          break;
        case '/':
          result = num2 != 0 ? num1 / num2 : double.nan;
          break;
      }
    });
  }

  void clearFields() {
    setState(() {
      num1Controller.clear();
      num2Controller.clear();
      result = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cuesta Calculator Activity 3',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4FC3F7), Color(0xFF0288D1)], // Light to deep blue
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE1F5FE), Color(0xFFBBDEFB)], // soft sky blues
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: num1Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number 1',
                  labelStyle: const TextStyle(color: Colors.black87),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: num2Controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Number 2',
                  labelStyle: const TextStyle(color: Colors.black87),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOperationButton('+', Colors.lightGreen),
                  _buildOperationButton('-', Colors.redAccent),
                  _buildOperationButton('*', Colors.amber),
                  _buildOperationButton('/', Colors.lightBlue),
                ],
              ),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                onPressed: clearFields,
                icon: const Icon(Icons.clear, color: Colors.white),
                label: const Text(
                  "Clear All",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigoAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              ResultDisplay(result: result),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOperationButton(String symbol, Color color) {
    return ElevatedButton(
      onPressed: () => calculate(symbol),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
        elevation: 4,
      ),
      child: Text(
        symbol,
        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
