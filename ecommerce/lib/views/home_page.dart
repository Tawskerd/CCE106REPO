import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/product_data.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import '../widgets/category_filter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = "All Products";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    final categories = ["All Products", "Jackets", "Sneakers"];

    final filtered = selectedCategory == "All Products"
        ? products
        : products.where((p) => p.category == selectedCategory).toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "Cuesta Ecommerce",
                  style: TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Our Products",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              // Category filter
              CategoryFilter(
                categories: categories,
                selected: selectedCategory,
                onSelect: (val) => setState(() => selectedCategory = val),
              ),
              const SizedBox(height: 8),

              // GridView fills remaining space, scrollable
             Expanded(
  child: GridView.builder(
    padding: EdgeInsets.zero,
    itemCount: filtered.length,
    gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.68,
    ),
    itemBuilder: (context, index) {
      final p = filtered[index];
      return ProductCard(
        product: p,
        onAdd: () {
          cart.addToCart(p);

          // ✅ Show SnackBar when added
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${p.name} added to cart"),
              duration: const Duration(seconds: 2),
            ),
          );
        },
      );
    },
  ),
),
            ],
          ),
        ),
      ),
    );
  }
}
