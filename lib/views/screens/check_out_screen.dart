import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_on_sale_system/providers/cart_provider.dart';
import 'package:point_on_sale_system/views/screens/cart_screen.dart';
import 'package:provider/provider.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String selectedMethod = "None";

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          //Payment
          SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
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
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          //Payment options cards.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              paymentOption(
                'Credit Card',
                FontAwesomeIcons.creditCard,
                'Credit Card',
              ),
              SizedBox(
                width: 10,
              ),
              paymentOption(
                'Credit Card',
                Icons.money,
                'Cash',
              ),
              SizedBox(
                width: 10,
              ),
              paymentOption(
                'Credit Card',
                Icons.qr_code,
                'Scan Card',
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          
        ],
      ),

      //the button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
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
    );
  }

  // Payment Option Widget
  Widget paymentOption(String title, IconData icon, String method) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = method;
        });
      },
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: selectedMethod == method ? Colors.pink : Colors.grey[500],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 25, color: Colors.white),
            SizedBox(height: 20),
            Text(title,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
