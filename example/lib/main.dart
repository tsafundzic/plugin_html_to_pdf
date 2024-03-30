import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:html_to_pdf/html_to_pdf.dart';
import 'package:html_to_pdf_example/sample_html_content.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? generatedPdfFilePath;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: buildBody(),
          ),
        ),
      ),
    );
  }

  Column buildBody() {
    return Column(
      children: [
        Expanded(
          child: generatedPdfFilePath != null
              ? SfPdfViewer.file(File(generatedPdfFilePath!))
              : SizedBox(),
        ),
        buildButton(),
        buildSteakyButton(),
      ],
    );
  }

  Padding buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        child: Text("Open Generated PDF Preview"),
        onPressed: generateExampleDocument,
      ),
    );
  }

  Padding buildSteakyButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        child: Text("Generated Steaky PDF Preview"),
        onPressed: generateSteakyDocument,
      ),
    );
  }

  Future<void> generateExampleDocument() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    final targetFileName = "example-pdf";

    final generatedPdfFile = await HtmlToPdf.convertFromHtmlContent(
      htmlContent: normalContent,
      printPdfConfiguration: PrintPdfConfiguration(
        targetDirectory: targetPath,
        targetName: targetFileName,
        printSize: PrintSize.A4,
        printOrientation: PrintOrientation.Landscape,
      ),
    );

    setState(
      () {
        generatedPdfFilePath = generatedPdfFile.path;
      },
    );
  }

  Future<void> generateSteakyDocument() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    final targetPath = appDocDir.path;
    final targetFileName = "steaky-pdf";

    final generatedPdfFile = await HtmlToPdf.convertFromHtmlContent(
      htmlContent: contentWithSteakyHeader,
      printPdfConfiguration: PrintPdfConfiguration(
        targetDirectory: targetPath,
        targetName: targetFileName,
        printSize: PrintSize.A4,
        printOrientation: PrintOrientation.Portrait,
      ),
    );

    setState(
      () {
        generatedPdfFilePath = generatedPdfFile.path;
      },
    );
  }
}
