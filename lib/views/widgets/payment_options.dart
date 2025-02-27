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

        double containerWidth = screenWidth / paymentImages.length - 20;
        double containerHeight = containerWidth * 0.6;

        return Center(
          child: Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            runSpacing: 10,
            children: paymentImages.map((imagePath) {
              return PaymentOptionCard(
                imagePath: imagePath,
                width: containerWidth.clamp(60, 120),
                height: containerHeight.clamp(40, 80),
              );
            }).toList(),
          ),
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
