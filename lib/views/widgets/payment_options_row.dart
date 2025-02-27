import 'package:flutter/material.dart';

class PaymentOptionsRow extends StatelessWidget {
  final List<String> paymentImages = [
    'assets/payments/mastercard.png',
    'assets/payments/visa.png',
    'assets/payments/american_express.png',
    'assets/payments/discover.png',
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = constraints.maxWidth;

        // Adjust container size dynamically based on screen width
        double containerWidth =
            screenWidth > 600 ? 120 : 80; // Larger on tablets
        double containerHeight = screenWidth > 600 ? 100 : 70;

        return Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: paymentImages.map((imagePath) {
            return PaymentOptionCard(
              imagePath: imagePath,
              width: containerWidth,
              height: containerHeight,
            );
          }).toList(),
        );
      },
    );
  }
}

class PaymentOptionCard extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  const PaymentOptionCard({
    Key? key,
    required this.imagePath,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 5,
            spreadRadius: 3,
            offset: const Offset(4, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
