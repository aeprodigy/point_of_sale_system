import 'package:flutter/material.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({super.key});

  @override
  _CreditCardFormState createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Cardholder Name',
              style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          _buildTextField(label: "Cardholder Name"),
          const SizedBox(height: 30),
          const Text('Card Number',
              style: TextStyle(fontWeight: FontWeight.w500)),
          const SizedBox(height: 8),
          _buildTextField(label: "Card Number"),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                  child: _buildTextField(
                      label: "00/0000", title: 'Expiration Date')),
              const SizedBox(width: 30),
              Expanded(child: _buildTextField(label: "CVV", title: 'CVV')),
            ],
          ),
          const SizedBox(height: 20),
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
              const Text("Save Credit Card Information",
                  style: TextStyle(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({required String label, String? title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            labelText: label,
            fillColor: Colors.grey[100],
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
          ),
        ),
      ],
    );
  }
}
