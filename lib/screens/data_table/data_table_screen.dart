import 'package:flutter/material.dart';
import 'package:invoice_generation/widgets/appbar/custom_appbar.dart';

class DataTableScreen extends StatefulWidget {
  const DataTableScreen({super.key});

  @override
  State<DataTableScreen> createState() => _DataTableScreenState();
}

class _DataTableScreenState extends State<DataTableScreen> {
  List<Map> _books = [
    {'id': 100, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 101, 'title': 'Flutter Basics', 'author': 'David John'},
    {'id': 102, 'title': 'Git and GitHub', 'author': 'Merlin Nick'}
  ];
  List<bool> _selected = [];

  @override
  void initState() {
    super.initState();
    _selected = List<bool>.generate(_books.length, (int index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Data table screen",
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: _CreateDataTableBody(),
    );
  }

  Widget _CreateDataTableBody() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DataTable(
              clipBehavior: Clip.antiAlias,
              // showBottomBorder: true,
              sortAscending: true,
              // dataRowMinHeight: MediaQuery.of(context).size.height * .08,
              // dataRowMaxHeight: MediaQuery.of(context).size.height * 0.1,
              dataTextStyle: TextStyle(fontSize: 16, color: Colors.black),
              border: TableBorder.all(color: Colors.black, width: 2),
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.blue.shade600),
              dataRowColor: MaterialStateColor.resolveWith(
                  (states) => Colors.blue.shade100),
              dividerThickness: 4,
              columns: const [
                DataColumn(label: Text("ID")),
                DataColumn(label: Text("BOOK")),
                DataColumn(label: Text("AUTHOR")),
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Text("#1")),
                  DataCell(Text("Ajay")),
                  DataCell(Text("25")),
                  DataCell(Text("Hyderabaddfasdffffffffffffffffff")),
                ])
              ]),
        )
      ],
    );
  }
}
