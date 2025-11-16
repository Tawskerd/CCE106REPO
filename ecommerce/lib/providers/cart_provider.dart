import 'package:flutter/material.dart';
import '../models/product.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cart = [];

  List<Product> get cartItems => _cart;

  void addToCart(Product product) {
    _cart.add(product);
    notifyListeners();
  }

  void removeFromCart(Product product) {
    _cart.remove(product);
    notifyListeners();
  }

  double get totalPrice {
    return _cart.fold(0, (sum, item) => sum + item.price);
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
