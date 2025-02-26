import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_on_sale_system/models/product_model.dart';
import 'package:point_on_sale_system/providers/cart_provider.dart';
import 'package:point_on_sale_system/providers/product_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';
  String _searchQuery = ''; // search Query for the categories

  final List<Map<String, dynamic>> categories = [
    {'icon': FontAwesomeIcons.bowlFood, 'label': 'All'},
    {'icon': FontAwesomeIcons.burger, 'label': 'Burgers'},
    {'icon': FontAwesomeIcons.breadSlice, 'label': 'Sandwiches'},
    {'icon': FontAwesomeIcons.wineGlass, 'label': 'Smoothies'},
  ];

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    // **FILTER PRODUCTS BASED ON CATEGORY AND SEARCH**
    List<ProductModel> filteredProducts = productProvider.product
        .where((product) =>
            (selectedCategory == 'All' ||
                product.category == selectedCategory) &&
            (product.name.toLowerCase().contains(_searchQuery.toLowerCase())))
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          // Back Button & Title
          Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: Row(
              children: [
                const FaIcon(FontAwesomeIcons.angleLeft),
                const SizedBox(width: 10),
                const Text(
                  'Menu',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // SEARCH FILTER
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Search Product',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value; // Update search query
                });
              },
            ),
          ),
          const SizedBox(height: 20),

          // CATEGORIES FILTER
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category['label'];

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory =
                            category['label']; // Update selected category
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 120,
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.pink : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(25),
                            blurRadius: 5,
                            spreadRadius: 3,
                            offset: const Offset(4, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FaIcon(
                            category['icon'],
                            color: isSelected ? Colors.white : Colors.grey[600],
                          ),
                          const SizedBox(height: 15),
                          Text(
                            category['label'],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color:
                                  isSelected ? Colors.white : Colors.grey[900],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // PRODUCTS GRID (Filtered)
          Expanded(
            child: filteredProducts.isEmpty
                ? const Center(child: Text("No products found"))
                : GridView.builder(
                    itemCount: filteredProducts.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                          color: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),

                              // Product Image with Cart Badge
                              GestureDetector(
                                onTap: () {
                                  // Handle product click
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: cartProvider.cartItems.any(
                                                  (item) =>
                                                      item.id == product.id)
                                              ? Colors.pink[100]!
                                              : Colors.grey[100]!,
                                          width: 10.0,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(
                                        product.image,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Positioned(
                                      right: 1,
                                      top: -1,
                                      child: Consumer<CartProvider>(
                                        builder:
                                            (context, cartProvider, child) {
                                          int productQuantity =
                                              cartProvider.cartItems
                                                  .firstWhere(
                                                    (item) =>
                                                        item.id == product.id,
                                                    orElse: () => ProductModel(
                                                      id: 0,
                                                      name: '',
                                                      price: 0.0,
                                                      quantity: 0,
                                                      image: '',
                                                      category: '',
                                                    ),
                                                  )
                                                  .quantity;

                                          return productQuantity > 0
                                              ? Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.pink,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Text(
                                                    productQuantity.toString(),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Product Name
                              Text(
                                product.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 30),

                              // Product Price and Add to Cart Button
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${product.price.toStringAsFixed(2)}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        cartProvider.addToCart(product);
                                      },
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: const BoxDecoration(
                                          color: Colors.pink,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.plus,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
