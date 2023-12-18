import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:sipeb/models/permintaan_model.dart';

import '../../helpers/pdf_helper.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key, required this.permintaan});

  final PermintaanModel permintaan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview"),
      ),
      body: PdfPreview(
        build: (format) => PDFHelper.generatePdf(format, permintaan),
        allowSharing: false,
        canChangePageFormat: true,
        canChangeOrientation: false,
        pageFormats: const {
          "A4": PdfPageFormat.a4,
          "Legal": PdfPageFormat.legal,
          "Letter": PdfPageFormat.letter,
        },
        initialPageFormat: PdfPageFormat.a4.portrait,
      ),
    );
  }
}
