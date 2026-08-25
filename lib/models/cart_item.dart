import 'package:stripe_payument/models/product.dart';

/// Shopping Cart Item Model
/// শপিং কার্টে যুক্ত করা প্রোডাক্ট এবং এর পরিমাণের (quantity) হিসেব রাখে।
class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});

  /// উক্ত আইটেমের মোট মূল্য (Unit Price * Quantity)
  double get totalPrice => product.price * quantity;
}
