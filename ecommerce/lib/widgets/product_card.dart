import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/favorite_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoriteProvider>(context);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Flexible image area
          Flexible(
            flex: 4,
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.contain,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: Icon(
                      favProvider.isFavorite(product)
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: favProvider.isFavorite(product)
                          ? Colors.red
                          : Colors.grey,
                    ),
                    onPressed: () => favProvider.toggleFavorite(product),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Product details
          Flexible(
            flex: 3,
            child: Column(
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  product.status,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                Text(
                  "₱${product.price}",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: onAdd,
                    child: const Text("Add to Cart"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
