import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/cart_provider.dart';
import 'providers/favorite_provider.dart';
import 'views/checkout_page.dart';
import 'views/base_screen.dart';

void main() {
  runApp(const EcommerceApp());
}

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
       routes: {
  "/": (_) => const BaseScreen(index: 0),   // ✅ Home + Nav Bar visible
  "/home": (_) => const BaseScreen(index: 0),
  "/cart": (_) => const BaseScreen(index: 1),
  "/favorites": (_) => const BaseScreen(index: 2),
  "/checkout": (_) => const CheckoutPage(),
},
      ),
    );
  }
}
