import 'package:flutter/material.dart';
import 'package:family_management/model/documentData.dart';
import 'package:family_management/firebase_api/fetchDocument.dart';

class DocumentListPage extends StatefulWidget {
  final String category;
  static String familyId = "";
  static String memberId = "";

  DocumentListPage(
      {required String familyId,
      required String memberId,
      required this.category}) {
    DocumentListPage.familyId = familyId;
    DocumentListPage.memberId = memberId;
  }

  @override
  State<DocumentListPage> createState() => _DocumentListPageState();
}

class _DocumentListPageState extends State<DocumentListPage> {
  late List<DocumentData> documents;

  @override
  void initState() {
    super.initState();
    fetchDocuments();
  }

  Future<void> fetchDocuments() async {
    List<DocumentData> fetchedDocuments = await FetchDocument.fetchDocuments(
      familyId: DocumentListPage.familyId,
      selectedCategory: widget.category,
    );

    setState(() {
      documents = fetchedDocuments;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documents - ${widget.category}'),
      ),
      body: documents != null
          ? GridView.builder(   
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: documents.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 3,
                  child: ListTile(
                    title: Text(documents[index].documentName),
                    subtitle: Text(documents[index].categoryName),
                    onTap: () {},
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
