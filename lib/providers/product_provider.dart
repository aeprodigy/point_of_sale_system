import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:point_on_sale_system/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> _products = [];

  List<ProductModel> get product => _products;

  Future<void> loadProducts() async {
    String jsonString =
        await rootBundle.loadString('assets/data/products.json');

    List<dynamic> jsonResponse = jsonDecode(jsonString);

    _products =
        jsonResponse.map((data) => ProductModel.fromJson(data)).toList();
    notifyListeners();
  }
}
