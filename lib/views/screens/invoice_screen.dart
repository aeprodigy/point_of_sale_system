import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:point_on_sale_system/providers/cart_provider.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InvoiceScreen extends StatelessWidget {
  final double totalPrice;
  final DateTime orderTime;
  final String paymentMethod;

  const InvoiceScreen({
    super.key,
    required this.totalPrice,
    required this.orderTime,
    required this.paymentMethod,
  });

  Future<Uint8List> _loadImage() async {
    final ByteData data = await rootBundle.load('assets/burger1.png');
    return data.buffer.asUint8List();
  }

  Future<Uint8List> _generatePdf(int totalItems) async {
    final pdf = pw.Document();
    final imageBytes = await _loadImage();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Add Image
            pw.Image(pw.MemoryImage(imageBytes), width: 80),
            pw.SizedBox(height: 10),

            // Invoice Title
            pw.Text('POS Invoice',
                style: pw.TextStyle(
                  fontSize: 30,
                  fontWeight: pw.FontWeight.bold,
                )),
            pw.Divider(thickness: 10, indent: 8, endIndent: 8),
            pw.SizedBox(height: 20),

            // Invoice Details
            pw.Text('Total Items Ordered: $totalItems'),
            pw.SizedBox(height: 10),
            pw.Text('Payment Method: $paymentMethod'),
            pw.SizedBox(height: 10),
            pw.Text('Total Price: \$${totalPrice.toStringAsFixed(2)}'),
            pw.SizedBox(height: 10),
            pw.Text(
                'Transaction Time: ${DateFormat('dd MMMM, hh:mm a').format(orderTime)}'),
            pw.SizedBox(height: 20),
            pw.Divider(thickness: 10, indent: 8, endIndent: 8),
            pw.SizedBox(height: 20),
            pw.Text('Thank you for shopping with us!')
          ],
        ),
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvide = Provider.of<CartProvider>(context);
    final int totalItems =
        cartProvide.totalItems; //  Get total items from thj cart provider

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Invoice'),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<Uint8List>(
        future: _generatePdf(totalItems), // total items to PDF
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return PdfPreview(
              build: (format) => Future.value(snapshot.data),
              canChangePageFormat: false,
              canChangeOrientation: false,
              canDebug: false,
            );
          }
        },
      ),
    );
  }
}
