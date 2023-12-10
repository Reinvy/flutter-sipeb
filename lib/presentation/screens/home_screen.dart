import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:sipeb/helpers/pdf_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
      ),
      body: PdfPreview(
        build: (format) => PDFHelper.generatePdf(),
        allowSharing: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
      ),
    );
  }
}
