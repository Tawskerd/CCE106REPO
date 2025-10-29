import 'package:flutter/material.dart';

void main() {
  runApp(const CuestaEdgeInsetsDemo());
}

class CuestaEdgeInsetsDemo extends StatelessWidget {
  const CuestaEdgeInsetsDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CUESTA EdgeInsets Demo'),
          backgroundColor: Colors.teal,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50  ),
          child: GridView.count(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              // 🟧 EdgeInsets.only (clearly shifted)
              for (int i = 0; i < 3; i++)
                Container(
                  color: Colors.orange,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Container(
                    color: Colors.white,
                    child: const Center(
                      child: Text(
                        'symmetric(horizontal: 20, vertical: 50)',
                        style: TextStyle(fontSize: 11),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
