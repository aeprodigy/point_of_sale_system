import 'package:flutter/material.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({super.key});

  @override
  State<CreditCardForm> createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Cardholder Name',
              style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          TextField(decoration: _inputDecoration("Cardholder Name")),
          SizedBox(height: 30),
          Text('Card Number', style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          TextField(decoration: _inputDecoration("Card Number")),
          SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Expiration Date',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    TextField(decoration: _inputDecoration("00/0000")),
                  ],
                ),
              ),
              SizedBox(width: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CVV', style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(height: 8),
                    TextField(decoration: _inputDecoration("CVV")),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? newValue) {
                  setState(() {
                    isChecked = newValue!;
                  });
                },
              ),
              Text("Save Credit Card Information",
                  style: TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      fillColor: Colors.grey[100],
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 25),
    );
  }
}
