import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:point_on_sale_system/providers/cart_provider.dart';
import 'package:point_on_sale_system/views/pages/home_page.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';
import 'package:point_on_sale_system/views/screens/invoice_screen.dart';
import 'package:provider/provider.dart';

class OrderDetailsScreen extends StatelessWidget {
  final String paymentMethod;
  final double totalPrice;
  final DateTime orderTime;

  const OrderDetailsScreen({
    super.key,
    required this.paymentMethod,
    required this.totalPrice,
    required this.orderTime,
  });

  @override
  Widget build(BuildContext context) {
    String formattedTime = DateFormat('hh:mm a').format(orderTime);
    String formattedDate = DateFormat('dd, MMMM').format(orderTime);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        // Enables scrolling
        child: Column(
          children: [
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Row(
                      children: const [
                        FaIcon(FontAwesomeIcons.angleLeft, size: 18),
                        SizedBox(width: 10),
                        Text(
                          'Order Details',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // Success payment card
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // Success icon
                      Center(
                        child: Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Colors.pink[600],
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: FaIcon(
                              FontAwesomeIcons.check,
                              color: Colors.white,
                              size: 70,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Payment success message
                      Center(
                        child: Text(
                          'Payment Success',
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 23,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      _buildDetailRow('Payment Method', paymentMethod),
                      _buildDetailRow(
                          'Total Price', '\$${totalPrice.toStringAsFixed(2)}'),
                      _buildDetailRow(
                          'Transaction Time', '$formattedDate, $formattedTime'),

                      // Buttons
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildButton(
                              label: 'Done',
                              color: Colors.pink,
                              textColor: Colors.white,
                              onTap: () {
                                Provider.of<CartProvider>(context,
                                        listen: false)
                                    .clear();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                );
                              },
                            ),
                            _buildButton(
                              label: 'Print',
                              color: Colors.white,
                              textColor: Colors.pink,
                              borderColor: Colors.pink,
                              onTap: () => _generatePDF(context),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          height: 20), // Added spacing to prevent cut-off
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Text(
            value,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Divider(
            color: Colors.grey[300], thickness: 2, indent: 30, endIndent: 30),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget _buildButton({
    required String label,
    required Color color,
    required Color textColor,
    Color? borderColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _generatePDF(BuildContext context) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text('Invoice',
                    style: pw.TextStyle(
                        fontSize: 30, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.Text('Payment Method: $paymentMethod'),
                pw.Text('Total Price: \$${totalPrice.toStringAsFixed(2)}'),
                pw.Text(
                    'Transaction Time: ${DateFormat('dd, MMMM hh:mm a').format(orderTime)}'),
              ],
            ),
          );
        },
      ),
    );

    // Navigate to the Invoice Screen with PDF
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InvoiceScreen(pdf: pdf),
      ),
    );
  }
}
