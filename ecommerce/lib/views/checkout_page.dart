import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Total Payment: ₱${cart.totalPrice}",
                style: const TextStyle(fontSize: 24)),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                cart.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Order Successful!"))
                );
                Navigator.pop(context);
              },
              child: const Text("Confirm Order"),
            )
          ],
        ),
      ),
    );
  }
}
