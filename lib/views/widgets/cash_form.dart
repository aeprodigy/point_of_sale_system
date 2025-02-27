import 'package:flutter/material.dart';

class CashForm extends StatelessWidget {
  const CashForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Text(
          "Please pay in cash at the counter.",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
