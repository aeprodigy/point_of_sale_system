import 'package:flutter/material.dart';

class ScannerForm extends StatelessWidget {
  const ScannerForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 50),
          Icon(Icons.qr_code_scanner, size: 80),
          SizedBox(height: 10),
          Text("Scan QR Code to proceed", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
