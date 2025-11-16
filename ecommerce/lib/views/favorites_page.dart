import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import '../providers/cart_provider.dart'; // ✅ import CartProvider
import '../widgets/product_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoriteProvider>(context);
    final cart = Provider.of<CartProvider>(context, listen: false); // ✅ access cart

    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: SafeArea(
        child: favProvider.favorites.isEmpty
            ? const Center(
                child: Text(
                  "No favorites yet",
                  style: TextStyle(fontSize: 18),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(12),
                child: GridView.builder(
                  itemCount: favProvider.favorites.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.68,
                  ),
                  itemBuilder: (context, index) {
                    final product = favProvider.favorites[index];
                    return ProductCard(
                      product: product,
                      onAdd: () {
                        // ✅ add to cart
                        cart.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${product.name} added to cart"),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
      ),
    );
  }
}
