import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sipeb/data/models/permintaan_model.dart';

import 'localization_helper.dart';

class PDFHelper {
  static Future<Uint8List> generatePB16Pdf(
      PdfPageFormat pageFormat, PermintaanModel permintaan) async {
    final pdf = pw.Document();

    int no = 0;

    pdf.addPage(
      pw.Page(
        pageFormat: pageFormat,
        orientation: pw.PageOrientation.portrait,
        build: (context) => pw.Column(
          children: [
            pw.Center(
              child: pw.Text(
                "PERMINTAAN BARANG PKS TS",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Center(
              child: pw.Text(
                "MELALUI PB-16 SHIFT ${permintaan.shift}",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.Center(
              child: pw.Text(
                "TAHUN ${permintaan.date.year}",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Table(
              border: const pw.TableBorder(
                top: pw.BorderSide(width: 1),
                bottom: pw.BorderSide(width: 1),
                left: pw.BorderSide(width: 1),
                right: pw.BorderSide(width: 1),
                verticalInside: pw.BorderSide(width: 1),
                horizontalInside: pw.BorderSide(width: 1),
              ),
              children: [
                pw.TableRow(
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.orangeAccent100,
                    ),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Center(
                          child: pw.Text(
                            "NO",
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Center(
                          child: pw.Text(
                            "NAMA BARANG",
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Center(
                          child: pw.Text(
                            "FISIK",
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Center(
                          child: pw.Text(
                            "SATUAN",
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Center(
                          child: pw.Text(
                            "KEPERLUAN",
                            style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]),
                for (var e in permintaan.items)
                  pw.TableRow(
                    verticalAlignment: pw.TableCellVerticalAlignment.middle,
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "${no += 1}",
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(e.namaBarang),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "${e.fisik}",
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          e.satuan,
                          textAlign: pw.TextAlign.center,
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          e.keperluan,
                          textAlign: pw.TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                if (permintaan.items.length < 6)
                  for (var le = permintaan.items.length; le < 6; le++)
                    pw.TableRow(repeat: true, children: [
                      for (var i = 0; i < 5; i++)
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(4),
                          child: pw.Text(
                            "empty_text",
                            style: const pw.TextStyle(color: PdfColors.white),
                          ),
                        ),
                    ])
              ],
            ),
            pw.SizedBox(height: 12),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    children: [
                      pw.Text(
                        "empty_text",
                        style: const pw.TextStyle(color: PdfColors.white),
                      ),
                      pw.SizedBox(height: 12),
                      pw.Text("Mengetahui"),
                      pw.Text(permintaan.knownBy),
                      pw.SizedBox(height: 60),
                      pw.Text(
                        permintaan.nameKnownBy,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          decoration: pw.TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  pw.Column(
                    children: [
                      pw.Text(
                        "PKS TS, ${LocalizationHelper.formatTgl(permintaan.date)}",
                      ),
                      pw.SizedBox(height: 12),
                      pw.Text("Di minta Oleh"),
                      pw.Text(permintaan.requestBy),
                      pw.SizedBox(height: 60),
                      pw.Text(
                        permintaan.nameRequestedBy,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          decoration: pw.TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return pdf.save();
  }
}
