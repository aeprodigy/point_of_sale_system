import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_on_sale_system/providers/cart_provider.dart';
import 'package:point_on_sale_system/views/screens/cart_screen.dart';
import 'package:point_on_sale_system/views/screens/home_screen.dart';
import 'package:point_on_sale_system/views/screens/invoice_screen.dart';
import 'package:provider/provider.dart';

import 'package:pdf/widgets.dart' as pw;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final pdf = pw.Document();
  // Tracks the selected tab
  final List<Widget> _screens = [
    HomeScreen(),
    CartScreen(),
   // InvoiceScreen(pdf:pdf)
  ];

  // Function to handle tab switching
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: _selectedIndex == 1
          ? null
          : BottomNavigationBar(
              elevation: 5,
              backgroundColor: Colors.white,
              currentIndex: _selectedIndex, // Highlight selected tab
              onTap: _onItemTapped, // Handle tab switch
              type: BottomNavigationBarType.fixed, // Keeps all icons visible
              selectedIconTheme:
                  const IconThemeData(color: Colors.pink), // Pink icon
              unselectedIconTheme: const IconThemeData(
                  color: Colors.grey), // Grey for unselected

              selectedLabelStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400), // Black text
              unselectedLabelStyle: const TextStyle(color: Colors.grey),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    clipBehavior: Clip.none, // Ensures the badge is not clipped
                    children: [
                      const FaIcon(FontAwesomeIcons.cartShopping), // Cart icon

                      // Cart Badge
                      Positioned(
                        right: -8,
                        top: -15,
                        child: Consumer<CartProvider>(
                          builder: (context, cartProvider, child) {
                            int cartCount =
                                cartProvider.cartItems.length; // Get item count
                            return cartCount > 0
                                ? Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: Colors.pink,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      cartCount.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                : const SizedBox(); // Hide badge when empty
                          },
                        ),
                      ),
                    ],
                  ),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.fileInvoice),
                  label: 'Invoice',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Menu',
                ),
              ],
            ),
    );
  }
}
