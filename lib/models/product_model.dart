class ProductModel {
  final int id;
  final String name;
  final double price;
  final String image;
  final String category; // Add this line
  int quantity;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.category, // Add this line
    this.quantity = 1,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      category: json['category'] as String, // Add this line
      quantity: json['quantity'] != null ? json['quantity'] as int : 1,
    );
  }
}
