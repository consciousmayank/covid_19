import 'package:covid19graphs/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class PdfViewPage extends StatelessWidget {
  final PDFDocument _document;

  PdfViewPage(this._document);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(
            context: context,
            title: "Notifications & advisories",
            textStyle: null,
            showBackArrow: true,
            actions: null),
        body: PDFViewer(document: _document,));
  }
}
