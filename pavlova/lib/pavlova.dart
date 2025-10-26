import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false, // ✅ removes DEBUG banner
      home: Pavlova(),
    ),
  );
}

class Pavlova extends StatelessWidget {
  const Pavlova({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cuesta_Activity1"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        children: [
          // 🧁 Centered Pavlova Image
         Center(
  child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.asset(
      'assets/images/pavlova.jpg',
      height: 220, // ✅ smaller image height (adjust as you like)
      width: double.infinity,
      fit: BoxFit.cover, // ✅ fills width but keeps proportion
    ),
  ),
),


          // 📝 Details Section
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Strawberry Pavlova',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Pavlova is a meringue-based dessert named after the Russian ballerina Anna Pavlova. '
                  'Pavlova features a crisp crust and soft, light inside, topped with fruit and whipped cream.',
                  style: TextStyle(fontSize: 16, height: 1.4),
                ),
                const SizedBox(height: 12),

                // ⭐ Centered Rating Row
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            index < 4 ? Icons.star : Icons.star_border,
                            color: Colors.amber,
                            size: 22,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '90 Reviews',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 🍴 Info Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    _InfoColumn(
                      icon: Icons.timer,
                      label: 'PREP',
                      value: '25 min',
                    ),
                    _InfoColumn(
                      icon: Icons.restaurant,
                      label: 'COOK',
                      value: '1 gr',
                    ),
                    _InfoColumn(
                      icon: Icons.people,
                      label: 'FEEDS',
                      value: '4-6 hrs',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 🔹 Reusable Info Column Widget
class _InfoColumn extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoColumn({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.amber, size: 28),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
      ],
    );
  }
}
