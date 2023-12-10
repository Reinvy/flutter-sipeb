import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

import '../../helpers/pdf_helper.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistem Informasi Pengeluaran Barang"),
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
