import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PDFHelper {
  static Future<Uint8List> generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          children: [
            pw.Text("Saya"),
          ],
        ),
      ),
    );

    return pdf.save();
  }
}
