import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:path_provider/path_provider.dart';

import 'package:sizer/sizer.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart' as pdfWidgets;

Future<void> openPdfFile(String filePath) async {
  try {
    await OpenFile.open(filePath);
  } catch (e) {
  }
}

class PdfMethod {
  static Future<Font> getFont(String asset) async {
    return Font.ttf(await rootBundle.load(asset));
  }
}

class Certificate {
  static Future<void> saveDocumentTemporary(
      {required String name, required Uint8List byteList}) async {
    final output = await getTemporaryDirectory();
    var filePath = "${output.path}/$name.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);

    await OpenFile.open(filePath);
  }

  static Future<void> createPdf12() async {
    final pdf = Document();
    final rudaBold = await PdfMethod.getFont("assets/fonts/Ruda-Bold.ttf");

    try {
      pdf.addPage(Page(
        build: (context) => Center(
            child: Text(
          "text",
          style: TextStyle(
            fontSize: 33,
            fontWeight: FontWeight.bold,
            font: rudaBold,
          ),
        )),
      ));
      // Your PDF generation and saving code here
    } catch (e) {
    }
  }

  static Future<Uint8List> createPdf() async {
    final pdf = Document();
    pdf.addPage(
      Page(
        build: (Context context) {
          return Center(
            child: Text(
              "Hello World!",
              style: const TextStyle(
                fontSize: 30,
              ),
            ),
          );
        },
      ),
    );
    return pdf.save();
  }

  Future<Uint8List> createPdfTemplate1(String name, String courseName) async {
    final pdf = Document();
    pdf.addPage(
      pdfWidgets.Page(
        build: (pdfWidgets.Context context) => pdfWidgets.Center(
          child: pdfWidgets.Container(
            height: 80.w,
            width: 130.w,
            decoration: pdfWidgets.BoxDecoration(
              color: PdfColors.grey100, // Light grey background
              border: pdfWidgets.Border.all(
                color: PdfColors.black, // Border color
                width: 2, // Border width
              ),
            ),
            child: pdfWidgets.Column(
              mainAxisAlignment: pdfWidgets.MainAxisAlignment.center,
              children: <pdfWidgets.Widget>[
                pdfWidgets.Text('Course Completion Certificate',
                    style: pdfWidgets.TextStyle(
                        fontSize: 24,
                        fontWeight: pdfWidgets.FontWeight.bold,
                        color: PdfColors.blue)),
                pdfWidgets.SizedBox(height: 20),
                pdfWidgets.Text('This is to certify that',
                    style: const pdfWidgets.TextStyle(
                        fontSize: 18, color: PdfColors.black)),
                pdfWidgets.Text(name,
                    style: pdfWidgets.TextStyle(
                        fontSize: 20,
                        fontWeight: pdfWidgets.FontWeight.bold,
                        color: PdfColors.black)),
                pdfWidgets.Text('has successfully completed the course',
                    style: const pdfWidgets.TextStyle(
                        fontSize: 18, color: PdfColors.black)),
                pdfWidgets.Text(courseName,
                    style: pdfWidgets.TextStyle(
                        fontSize: 20,
                        fontWeight: pdfWidgets.FontWeight.bold,
                        color: PdfColors.black)),
                pdfWidgets.SizedBox(height: 20),
                pdfWidgets.Text('Date: ${DateTime.now().toString()}',
                    style: const pdfWidgets.TextStyle(
                        fontSize: 16, color: PdfColors.black)),
                pdfWidgets.SizedBox(height: 20),
                pdfWidgets.Text('Signature',
                    style: const pdfWidgets.TextStyle(
                        fontSize: 16, color: PdfColors.black)),
                pdfWidgets.Text('____________________',
                    style: const pdfWidgets.TextStyle(
                        fontSize: 16, color: PdfColors.black)),
              ],
            ),
          ),
        ),
      ),
    );

    return pdf.save();
  }
}
