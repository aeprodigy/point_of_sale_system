import 'package:flutter/material.dart';

class CheckOutBtn extends StatelessWidget {
  String text;
  VoidCallback ontap;
   CheckOutBtn({super.key,  required this.text, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.pink
        ),
      ),
    );
  }
}
