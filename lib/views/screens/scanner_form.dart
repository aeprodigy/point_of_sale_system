import 'package:flutter/material.dart';

class ScannerForm extends StatelessWidget {
  const ScannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.qr_code_scanner, size: 80, color: Colors.black),
          SizedBox(height: 10),
          Text("Scan QR Code to proceed", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
