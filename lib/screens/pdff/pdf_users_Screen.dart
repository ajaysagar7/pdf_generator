import 'package:flutter/material.dart';
import 'package:invoice_generation/screens/data_table/books_table_screen.dart';
import 'package:invoice_generation/screens/pdff/pdf_model.dart';
import 'package:invoice_generation/screens/pdff/pdf_preview_screen.dart';
import 'package:invoice_generation/widgets/appbar/custom_appbar.dart';

class PdfUsersScreen extends StatefulWidget {
  const PdfUsersScreen({super.key});

  @override
  State<PdfUsersScreen> createState() => _PdfUsersScreenState();
}

class _PdfUsersScreenState extends State<PdfUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: CustomAppBar(
        title: "Users Bills",
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => BooksTableScreen()));
              },
              icon: Icon(Icons.dataset))
        ],
      ),
      body: _bodyWidget(),
    );
  }

  _bodyWidget() {
    return SafeArea(
        child: ListView.builder(
      itemBuilder: (c, i) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PdfPreviewPage(
                              pdfModel: newPdfModelLists[i],
                            )));
              },
              title: Text(newPdfModelLists[i].name),
              subtitle: Text(newPdfModelLists[i].address),
              trailing: Text(newPdfModelLists[i].phone.toString()),
            ),
          ),
        );
      },
      itemCount: newPdfModelLists.length,
    ));
  }
}
