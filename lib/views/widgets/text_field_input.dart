import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10),
            child:
                FaIcon(FontAwesomeIcons.magnifyingGlass, color: Colors.black),
          ), // Adjusted prefix icon
          hintText: "Search Product...",
          hintStyle: TextStyle(
            color: Colors.grey[600],
          ),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey[600]!, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey[600]!, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Colors.grey[800]!, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: 16, // Adjust top & bottom padding
            horizontal: 25, // Adjust left & right padding
          ),
        ),
      ),
    );
  }
}
