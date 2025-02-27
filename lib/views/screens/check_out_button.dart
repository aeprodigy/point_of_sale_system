import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  final double totalPrice;

  const CheckoutButton({required this.totalPrice, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.pink,
          padding: const EdgeInsets.all(15),
        ),
        child: Text("Checkout - \$${totalPrice.toStringAsFixed(2)}",
            style: const TextStyle(fontSize: 20, color: Colors.white)),
      ),
    );
  }
}
