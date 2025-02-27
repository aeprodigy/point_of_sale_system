import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_on_sale_system/providers/cart_provider.dart';
import 'package:point_on_sale_system/views/screens/cart_screen.dart';
import 'package:point_on_sale_system/views/widgets/payment_options_row.dart';
import 'package:provider/provider.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  String selectedMethod = "None";

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //Payment
          SizedBox(height: 70),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CartScreen()),
                    );
                  },
                  child: Row(
                    children: [
                      FaIcon(FontAwesomeIcons.angleLeft, size: 18),
                      SizedBox(width: 10),
                      Text(
                        'Payment',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          //Payment options cards.
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              paymentOption(
                'Credit Card',
                FontAwesomeIcons.creditCard,
                'Credit Card',
              ),
              SizedBox(
                width: 10,
              ),
              paymentOption(
                'Cash',
                Icons.money,
                'Cash',
              ),
              SizedBox(
                width: 10,
              ),
              paymentOption(
                'Scanner',
                Icons.qr_code,
                'Scanner',
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          PaymentOptionsRow(),

          //Payments input fields
          buildPaymentFields(),
        ],
      ),

      //the button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$ ${cartProvider.totalPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Checkout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(width: 12),
                    FaIcon(
                      FontAwesomeIcons.angleRight,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Payment Option Widget
  Widget paymentOption(String title, IconData icon, String method) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMethod = method;
        });
      },
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
            SizedBox(height: 20),
            Text(title,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  // Payment Fields
  Widget buildPaymentFields() {
    switch (selectedMethod) {
      case "Credit Card":
        return creditCardForm();
      case "Cash":
        return cashForm();
      case "Scanner":
        return scannerForm();
      default:
        return Center(
            child: Text("Select a payment method",
                style: TextStyle(fontSize: 18)));
    }
  }

  bool isChecked = false;
  // Credit Card Form
  Widget creditCardForm() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'Cardholder Name',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          TextField(
            decoration: InputDecoration(
              labelText: "Cardholder Name",
              fillColor: Colors.grey[100],
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[200]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Card Number',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 8,
          ),
          //card number
          TextField(
            decoration: InputDecoration(
              labelText: "Card Number",
              fillColor: Colors.grey[100],
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[200]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Expiration Date',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "00/0000",
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[200]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 25),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 30,
              ),
              //cvv
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CVV',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(
                      height: 8,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        labelText: "CVV",
                        fillColor: Colors.grey[100],
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[200]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 25),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          //save credit card info
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                value: isChecked,
                onChanged: (bool? newValue) {
                  setState(() {
                    isChecked = newValue!;
                  });
                },
              ),
              const Text(
                "Save Credit Card Information",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Cash Payment Message
  Widget cashForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
        ),
        Center(
          child: Text(
            "Please pay in cash at the counter.",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  // Scanner Form
  Widget scannerForm() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Icon(Icons.qr_code_scanner, size: 80, color: Colors.black),
          SizedBox(height: 10),
          Text("Scan QR Code to proceed", style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}
