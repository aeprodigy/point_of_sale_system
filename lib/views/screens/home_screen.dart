import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_on_sale_system/providers/cart_provider.dart';
import 'package:point_on_sale_system/providers/product_provider.dart';
import 'package:point_on_sale_system/views/widgets/text_field_input.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'All';

  final List<Map<String, dynamic>> categories = [
    {'icon': FontAwesomeIcons.bowlFood, 'label': 'All'},
    {'icon': FontAwesomeIcons.burger, 'label': 'Burger'},
    {'icon': FontAwesomeIcons.breadSlice, 'label': 'Sandwiches'},
    {'icon': FontAwesomeIcons.wineGlass, 'label': 'Drinks'},
  ];

  @override
  Widget build(BuildContext context) {
    //providers
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 70),
          //Text Menu
          Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.angleLeft),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Menu',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              )),
          SizedBox(
            height: 20,
          ),
          // THE SEARCH FILTER
          const TextFieldInput(),
          const SizedBox(height: 20),
          // CATEGORIES FILTER (Now each inside an individual container with uniform width & height)
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category['label'];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = category['label'];
                      });
                    },
                    child: Container(
                      width: 100,
                      height: 120,
                      //margin: const EdgeInsets.symmetric(horizontal: 1.0),
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
                              fontWeight: FontWeight.w400,
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

          //the Products grid.
          Expanded(
              child: productProvider.product.isEmpty
                  ? CircularProgressIndicator()
                  : GridView.builder(
                      itemCount: productProvider.product.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.8, // Adjust the item size
                      ),
                      itemBuilder: (context, index) {
                        final products = productProvider.product[index];
                        //the product card.
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Card(
                            color: Colors.white,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                // Stack to overlay image on a bigger circle
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Background Circle
                                    Container(
                                      width: 100, // Bigger than image
                                      height: 100, // Bigger than image
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .white, // Light gray background
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color:
                                              Colors.pink[100]!, // Border color
                                          width: 10.0, // Border thickness
                                        ),
                                      ),
                                    ),
                                    // Image
                                    Container(
                                      height: 80, // Smaller than circle
                                      width: 80, // Smaller than circle
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(
                                        products.image,
                                        fit: BoxFit
                                            .contain, // Ensures it stays within bounds
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  products.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "\$${products.price.toStringAsFixed(2)}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 20),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.pink,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: FaIcon(
                                            FontAwesomeIcons.plus,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }))
        ],
      ),
      
    );
  }
}
