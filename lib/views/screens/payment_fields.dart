import 'package:flutter/material.dart';
import 'credit_card_form.dart';
import 'cash_form.dart';
import 'scanner_form.dart';

class PaymentFields extends StatelessWidget {
  final String selectedMethod;

  const PaymentFields({required this.selectedMethod, super.key});

  @override
  Widget build(BuildContext context) {
    switch (selectedMethod) {
      case "Card":
        return CreditCardForm();
      case "Cash":
        return CashForm();
      case "Scanner":
        return ScannerForm();
      default:
        return Center(
            child: Text("Select a payment method",
                style: TextStyle(fontSize: 18)));
    }
  }
}
