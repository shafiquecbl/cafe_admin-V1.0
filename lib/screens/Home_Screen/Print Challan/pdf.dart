import 'package:cafe_admin/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String path;
  final pdf;

  PdfPreviewScreen({this.path, this.pdf});

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: kPrimaryColor,
        centerTitle: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            'Print Challan',
            style: GoogleFonts.teko(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        backgroundColor: hexColor,
        actions: [
          RaisedButton(
            child: Text('Print'),
            onPressed: () async {
              await Printing.layoutPdf(
                onLayout: (PdfPageFormat format) async => pdf.save(),
              );
            },
          )
        ],
      ),
      path: path,
    );
  }
}
