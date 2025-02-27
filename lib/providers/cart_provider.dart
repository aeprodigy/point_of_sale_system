import 'package:flutter/material.dart';
import 'package:point_on_sale_system/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<ProductModel> _cartItems = [];
  int? _selectedProductId; // Track selected product
  Set<int> _addedProductIds = {}; // Track products added to cart

  List<ProductModel> get cartItems => _cartItems;
  int? get selectedProductId => _selectedProductId;
  Set<int> get addedProductIds =>
      _addedProductIds; // Getter for tracking added products

  void selectProduct(int productId) {
    _selectedProductId = productId;
    notifyListeners();
  }

  void addToCart(ProductModel product) {
    int index = _cartItems.indexWhere((cartItem) => cartItem.id == product.id);
    if (index != -1) {
      _cartItems[index].quantity += 1;
    } else {
      _cartItems.add(product);
    }

    _addedProductIds.add(product.id); // Mark product as added
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    _cartItems.remove(product);
    _addedProductIds.remove(product.id); // Remove from tracking when removed
    notifyListeners();
  }

  void increaseQuantity(ProductModel item) {
    int index = _cartItems.indexWhere((cartItem) => cartItem.id == item.id);
    if (index != -1) {
      _cartItems[index].quantity += 1;
      notifyListeners();
    }
  }

  void decreaseQuantity(ProductModel item) {
    int index = _cartItems.indexWhere((cartItem) => cartItem.id == item.id);
    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity -= 1;
      } else {
        _cartItems.removeAt(index);
        _addedProductIds
            .remove(item.id); // Remove from tracking when quantity reaches 0
      }
      notifyListeners();
    }
  }

  void clear() {
     for (var item in _cartItems) {
      item.quantity = 1; // Reset quantity for each product
    }
    _cartItems.clear();
    _addedProductIds.clear(); 
    notifyListeners();
  }

  double get totalPrice {
    return _cartItems.fold(
        0, (sum, item) => sum + (item.price * item.quantity));
  }
}
