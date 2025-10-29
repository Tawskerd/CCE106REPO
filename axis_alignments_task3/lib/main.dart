import 'package:flutter/material.dart';

void main() {
  runApp(const CuestaAlignmentDemo());
}

class CuestaAlignmentDemo extends StatelessWidget {
  const CuestaAlignmentDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CUESTA Alignment Demo'),
          backgroundColor: Colors.teal,
        ),
        body: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            // 🔹 MAIN AXIS ALIGNMENTS (Row)
            const Text('🟦 Row - MainAxisAlignment.center', style: TextStyle(fontWeight: FontWeight.bold)),
            buildRow(MainAxisAlignment.center),
            const SizedBox(height: 20),

            const Text('🟩 Row - MainAxisAlignment.spaceAround', style: TextStyle(fontWeight: FontWeight.bold)),
            buildRow(MainAxisAlignment.spaceAround),
            const SizedBox(height: 20),

            const Text('🟨 Row - MainAxisAlignment.spaceBetween', style: TextStyle(fontWeight: FontWeight.bold)),
            buildRow(MainAxisAlignment.spaceBetween),
            const SizedBox(height: 20),

            const Text('🟧 Row - MainAxisAlignment.spaceEvenly', style: TextStyle(fontWeight: FontWeight.bold)),
            buildRow(MainAxisAlignment.spaceEvenly),
            const SizedBox(height: 20),

            const Text('🟥 Row - MainAxisAlignment.start', style: TextStyle(fontWeight: FontWeight.bold)),
            buildRow(MainAxisAlignment.start),
            const SizedBox(height: 20),

            const Text('🟪 Row - MainAxisAlignment.end', style: TextStyle(fontWeight: FontWeight.bold)),
            buildRow(MainAxisAlignment.end),
            const SizedBox(height: 30),

            const Divider(thickness: 2),

            // 🔹 CROSS AXIS ALIGNMENTS (Column)
            const Text('🟫 Column - CrossAxisAlignment.start', style: TextStyle(fontWeight: FontWeight.bold)),
            buildColumn(CrossAxisAlignment.start),
            const SizedBox(height: 20),

            const Text('🟩 Column - CrossAxisAlignment.end', style: TextStyle(fontWeight: FontWeight.bold)),
            buildColumn(CrossAxisAlignment.end),
            const SizedBox(height: 20),

            const Text('🟦 Column - CrossAxisAlignment.center', style: TextStyle(fontWeight: FontWeight.bold)),
            buildColumn(CrossAxisAlignment.center),
            const SizedBox(height: 20),

            const Text('🟧 Column - CrossAxisAlignment.stretch', style: TextStyle(fontWeight: FontWeight.bold)),
            buildColumn(CrossAxisAlignment.stretch),
            const SizedBox(height: 20),

            const Text('🟥 Column - CrossAxisAlignment.baseline (with text)', style: TextStyle(fontWeight: FontWeight.bold)),
            buildBaselineColumn(),
          ],
        ),
      ),
    );
  }

  // 🔸 Helper for Rows
  Widget buildRow(MainAxisAlignment alignment) {
    return Container(
      color: Colors.grey[200],
      height: 80,
      child: Row(
        mainAxisAlignment: alignment,
        children: buildBoxes(),
      ),
    );
  }

  // 🔸 Helper for Columns
  Widget buildColumn(CrossAxisAlignment alignment) {
    return Container(
      color: Colors.grey[200],
      height: 150,
      child: Column(
        crossAxisAlignment: alignment,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buildBoxes(),
      ),
    );
  }

  // 🔸 Baseline Example
  Widget buildBaselineColumn() {
    return Container(
      color: Colors.grey[200],
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: const [
          Text('Red Box', style: TextStyle(fontSize: 20, backgroundColor: Colors.red)),
          Text('Green', style: TextStyle(fontSize: 30, backgroundColor: Colors.green)),
          Text('Blue', style: TextStyle(fontSize: 40, backgroundColor: Colors.blue)),
        ],
      ),
    );
  }

  // 🔸 3 Color Boxes
  List<Widget> buildBoxes() {
    return [
      Container(width: 40, height: 40, color: Colors.red),
      Container(width: 40, height: 40, color: Colors.green),
      Container(width: 40, height: 40, color: Colors.blue),
    ];
  }
}
