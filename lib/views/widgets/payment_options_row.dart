import 'package:flutter/material.dart';

class PaymentOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final String method;
  final String selectedMethod;
  final VoidCallback onTap;

  const PaymentOption({
    required this.title,
    required this.icon,
    required this.method,
    required this.selectedMethod,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: selectedMethod == method ? Colors.pink : Colors.grey[500],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 25, color: Colors.white),
            const SizedBox(height: 20),
            Text(title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
