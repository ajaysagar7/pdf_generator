import 'package:flutter/material.dart';
import 'package:invoice_generation/screens/data_table/books_data.dart';
import 'package:invoice_generation/screens/pdff/pdf_preview_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class BooksTableScreen extends StatefulWidget {
  @override
  State<BooksTableScreen> createState() => _BooksTableScreenState();
}

class _BooksTableScreenState extends State<BooksTableScreen> {
  int _currentSortColumn = 0;
  bool _isSortAsc = true;

  List<bool> _selected = [];

  List<String> _selectedValues = [];

  @override
  void initState() {
    super.initState();
    _selected = List<bool>.generate(books.length, (int index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Books'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              sortColumnIndex: _currentSortColumn,
              sortAscending: _isSortAsc,
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.blue.shade600),
              dataRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.blue.shade100),
              border: TableBorder.all(color: Colors.black, width: 2),
              columns: <DataColumn>[
                DataColumn(
                    label: const Text('ID'),
                    onSort: ((columnIndex, ascending) {
                      _currentSortColumn = columnIndex;

                      if (_isSortAsc) {
                        books.sort((a, b) => a['id'].compareTo(b['id']));
                      } else {
                        books.sort((a, b) => b['id'].compareTo(a['id']));
                      }
                      _isSortAsc = !_isSortAsc;

                      setState(() {});
                    })),
                const DataColumn(
                  label: Text('Title'),
                ),
                const DataColumn(
                  label: Text('Author'),
                ),
                const DataColumn(
                  label: Text('Price'),
                ),
                const DataColumn(
                  label: Text('Image'),
                ),
              ],
              rows: books
                  .map((book) => DataRow(
                          selected:
                              _selectedValues.contains(book['id'].toString()) ==
                                      true
                                  ? true
                                  : false,
                          onSelectChanged: (bool? isSelected) {
                            if (isSelected!) {
                              setState(() {
                                _selectedValues.add(book['id'].toString());
                              });
                            } else {
                              setState(() {
                                _selectedValues.remove(book['id'].toString());
                              });
                            }
                          },
                          cells: [
                            DataCell(Text(book['id'].toString())),
                            DataCell(Text(book['title'])),
                            DataCell(Text(book['author'])),
                            DataCell(Text(book['price'].toString())),
                            const DataCell(FlutterLogo())
                          ]))
                  .toList(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (_) =>
            //             PdfPreviewPage(books[0]["author"].toString())));
            // final pdf = await _generatePdf();
            // await Printing.layoutPdf(
            //   onLayout: (PdfPageFormat format) async => pdf.save(),
            // );
          },
          child: const Icon(Icons.print),
        ));
  }
}

Future<pw.Document> _generatePdf() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      // ignore: deprecated_member_use
      build: (pw.Context context) => pw.Table.fromTextArray(
        context: context,
        data: <List<String>>[
          <String>['ID', 'Title', 'Author', 'Price'],
          ...books.map((item) => [
                item['id'].toString(),
                item['title'],
                item['author'],
                item['price'].toString(),
              ])
        ],
      ),
    ),
  );

  return pdf;
}
