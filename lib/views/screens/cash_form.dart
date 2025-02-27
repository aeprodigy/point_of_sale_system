import 'package:flutter/material.dart';

class CashForm extends StatelessWidget {
  const CashForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text("Please pay in cash at the counter.",
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
