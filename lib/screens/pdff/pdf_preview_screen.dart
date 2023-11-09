// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invoice_generation/screens/pdff/pdf_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:http/http.dart' as http;

class PdfPreviewPage extends StatefulWidget {
  String? text;
  final PdfModel pdfModel;

  PdfPreviewPage({super.key, required this.pdfModel});

  @override
  State<PdfPreviewPage> createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        actions: [],
        allowPrinting: false,
        allowSharing: false,
        canChangeOrientation: true,
        canChangePageFormat: false,
        canDebug: false,
        dynamicLayout: false,
        initialPageFormat: PdfPageFormat.a4,
        loadingWidget: const CircularProgressIndicator(color: Colors.black),
        build: (context) => makePdf(),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => downloadPdf(),
            child: const Icon(Icons.download),
            heroTag: null, // Add this line
          ),
          const SizedBox(width: 10), // Add some space between the buttons
          FloatingActionButton(
            onPressed: () => printPdf(),
            child: const Icon(Icons.print),
          ),
        ],
      ),
    );
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();

    // LOCAL IMAGE
    final imageBytes =
        (await rootBundle.load('assets/logo.png')).buffer.asUint8List();

    // NETWORK IMAGE
    // final response = await http.get(Uri.parse('https://example.com'));
    // final imageBytes = response.bodyBytes;

    pdf.addPage(pw.Page(
        orientation: pw.PageOrientation.portrait,
        margin: const pw.EdgeInsets.all(20),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Name : ${widget.pdfModel.name}}"),
                          pw.Text("Address : ${widget.pdfModel.address}"),
                          pw.Text("Phone : ${widget.pdfModel.phone}"),
                        ]),
                    pw.Image(
                        pw.MemoryImage(
                          imageBytes,
                        ),
                        height: 120,
                        width: 120),
                  ],
                )
                //FIRST TABLE
                ,
                pw.SizedBox(height: 10),
                pw.Divider(),
                pw.SizedBox(height: 20),
                pw.Table(
                    border:
                        pw.TableBorder.all(color: PdfColors.black, width: 1),
                    children: [
                      pw.TableRow(
                          decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                  bottom: pw.BorderSide(
                                      color: PdfColors.black, width: 1))),
                          children: [
                            pw.Padding(
                                padding: const pw.EdgeInsets.all(20),
                                child: pw.Text(
                                  "Invoice For Payment",
                                  textAlign: pw.TextAlign.center,
                                )),
                          ]),
                      // FIRST PRICE AND AMOUNT
                      pw.TableRow(children: [
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(20),
                            child: pw.Text(
                              "Technical Engagement",
                              textAlign: pw.TextAlign.start,
                            )),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(20),
                            child: pw.Text(
                              "\$120",
                              textAlign: pw.TextAlign.start,
                            )),
                      ]),
                      // SECOND ROW
                      pw.TableRow(children: [
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(20),
                            child: pw.Text(
                              "Deployement Assistance",
                              textAlign: pw.TextAlign.start,
                            )),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(20),
                            child: pw.Text(
                              "\$200",
                              textAlign: pw.TextAlign.start,
                            )),
                      ]),
                      // THIRD ROW
                      pw.TableRow(children: [
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(20),
                            child: pw.Text(
                              "Software Assistance",
                              textAlign: pw.TextAlign.start,
                            )),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(20),
                            child: pw.Text(
                              "\$400",
                              textAlign: pw.TextAlign.start,
                            )),
                      ]),

                      // FOURTH ROW
                      pw.TableRow(children: [
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(20),
                            child: pw.Text(
                              "Document Assistance",
                              textAlign: pw.TextAlign.start,
                            )),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(20),
                            child: pw.Text(
                              "\$400",
                              textAlign: pw.TextAlign.start,
                            )),
                      ]),
                      // TAX ROW
                      pw.TableRow(children: [
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(20),
                            child: pw.Text(
                              "TAX",
                              textAlign: pw.TextAlign.end,
                            )),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(20),
                            child: pw.Text(
                              "\$150",
                              textAlign: pw.TextAlign.start,
                            )),
                      ]),
                      // Total ROW
                      pw.TableRow(children: [
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(20),
                            child: pw.Text(
                              "TOTAL",
                              textAlign: pw.TextAlign.end,
                            )),
                        pw.Padding(
                            padding: const pw.EdgeInsets.all(20),
                            child: pw.Text(
                              "\$4599",
                              textAlign: pw.TextAlign.start,
                            )),
                      ]),
                    ]),
                pw.SizedBox(height: 20),
                pw.Text("THANK YOU FOR YOUR BUSINESS",
                    style: pw.TextStyle(
                        fontSize: 20, fontWeight: pw.FontWeight.bold))
              ]);
          // return pw.Column(
          //     crossAxisAlignment: pw.CrossAxisAlignment.start,
          //     children: [
          //       pw.Row(
          //           mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          //           children: [
          //             pw.Header(text: "About Cat", level: 1),
          //             pw.Image(pw.MemoryImage(byteList),
          //                 fit: pw.BoxFit.fitHeight, height: 100, width: 100)
          //           ]),
          //       pw.Divider(borderStyle: pw.BorderStyle.dashed),

          //       // pw.Paragraph(text: loremText),
          //       // pw.Bullet(
          //       //     text: "Bullet Text",
          //       //     bulletSize: 20,
          //       //     style: pw.TextStyle(fontSize: 20)),
          //     ]);
        }));
    return pdf.save();
  }

  Future<void> printPdf() async {
    try {
      var pdfBytes = await makePdf();
      await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdfBytes,
      );
    } catch (e) {
      // Handle any errors
      print('Error printing PDF: $e');
    } finally {
      // Hide the loading indicator
      setState(() {
        _isLoading = false;
      });
    }
  }

  downloadPdf() async {
    try {
      //! DOWNLOAD PDF CODE
      var pdfBytes = await makePdf();
      var output = await getTemporaryDirectory();
      var file = File("${output.path}/my-document.pdf");
      await file.writeAsBytes(pdfBytes);
      Fluttertoast.showToast(
          msg: "pdf downloaded successfully", backgroundColor: Colors.green);

      OpenFile.open(file.path);
    } catch (e) {
      debugPrint('Error writing PDF: $e');
      throw Exception('Error writing PDF: $e');
    }
  }
}
