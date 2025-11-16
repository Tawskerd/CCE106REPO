import 'package:flutter/material.dart';
import 'home_page.dart';
import 'cart_page.dart';
import 'favorites_page.dart';

class BaseScreen extends StatefulWidget {
  final int index;

  const BaseScreen({super.key, this.index = 0});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  late int _currentIndex;

  final pages = [
    const HomePage(),
    const CartPage(),
    const FavoritesPage(),   // ✅ ADD THIS
  ];

  @override
  void initState() {
    _currentIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (i) {
          setState(() => _currentIndex = i);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),

          // ✅ ADD FAVORITES BUTTON HERE
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
