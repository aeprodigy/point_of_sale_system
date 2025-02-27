import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_on_sale_system/views/screens/order_details_screen.dart';
import 'package:point_on_sale_system/views/screens/payment_fields.dart';
import 'package:point_on_sale_system/views/widgets/payment_options.dart';
import 'package:point_on_sale_system/views/widgets/payment_options_row.dart';
import 'package:provider/provider.dart';
import 'package:point_on_sale_system/providers/cart_provider.dart';
import 'package:point_on_sale_system/views/screens/cart_screen.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String selectedMethod = "Card";

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap content in a scrollable view
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartScreen()),
                        );
                      },
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.angleLeft, size: 18),
                          SizedBox(width: 10),
                          Text(
                            'Payment',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // Payment options row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    PaymentOption(
                      title: 'Card',
                      icon: FontAwesomeIcons.creditCard,
                      method: 'Card',
                      selectedMethod: selectedMethod,
                      onTap: () {
                        setState(() {
                          selectedMethod = 'Card';
                        });
                      },
                    ),
                    PaymentOption(
                      title: 'Cash',
                      icon: Icons.money,
                      method: 'Cash',
                      selectedMethod: selectedMethod,
                      onTap: () {
                        setState(() {
                          selectedMethod = 'Cash';
                        });
                      },
                    ),
                    PaymentOption(
                      title: 'Scanner',
                      icon: Icons.qr_code,
                      method: 'Scanner',
                      selectedMethod: selectedMethod,
                      onTap: () {
                        setState(() {
                          selectedMethod = 'Scanner';
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 30),

                if (selectedMethod == "Card") PaymentOptionsRow(),
                SizedBox(height: 20),

                PaymentFields(selectedMethod: selectedMethod),

                SizedBox(height: 40), 
              ],
            ),
          ),
        ),
      ),

      // Bottom navigation checkout button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: GestureDetector(
          onTap: () {
            DateTime orderTime = DateTime.now(); // here we get the current time
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderDetailsScreen(
                  paymentMethod: selectedMethod,
                  orderTime: orderTime,
                  totalPrice: cartProvider.totalPrice,
                ),
              ),
            );
          },
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "\$ ${cartProvider.totalPrice.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        'Checkout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(width: 12),
                      FaIcon(
                        FontAwesomeIcons.angleRight,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
