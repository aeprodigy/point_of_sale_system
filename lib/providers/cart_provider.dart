import 'package:flutter/material.dart';
import 'package:point_on_sale_system/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<ProductModel> _cartItems = [];

  List<ProductModel> get cartItems => _cartItems;

  void addToCart(ProductModel product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  //get the prices

  double get totalPrice {
    return _cartItems.fold(0, (sum, item) => sum + item.price);
  }
}
