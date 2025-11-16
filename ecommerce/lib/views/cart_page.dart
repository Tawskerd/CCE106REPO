import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    // Function to show confirmation dialog
    void _confirmDelete(item) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Delete Item"),
          content: Text("Are you sure you want to remove '${item.name}' from the cart?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(), // Cancel
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                cart.removeFromCart(item); // Remove item
                Navigator.of(ctx).pop(); // Close dialog
              },
              child: const Text("Delete"),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.cartItems.length,
              itemBuilder: (context, index) {
                final item = cart.cartItems[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text("₱${item.price}"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _confirmDelete(item), // show confirmation
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Total: ₱${cart.totalPrice}",
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, "/checkout"),
                  child: const Text("Proceed to Checkout"),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
