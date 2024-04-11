import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:family_management/model/categoryFile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:family_management/model/documentData.dart';
import 'package:family_management/firebase_api/fetchDocument.dart';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

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
  late List<DocumentData> documents = [];

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

  Future<void> _downloadDocument(DocumentData document) async {
    try {

      String fileName = Uri.decodeComponent(
          document.fileUrl.split('%2F').last.split('?').first);
      String storagePath =
          'familyDocuments/${DocumentListPage.familyId}/$fileName';

      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(storagePath);

      String downloadUrl = await firebaseStorageRef.getDownloadURL();

      print('Downloaded file with URL: $downloadUrl');
    } catch (e) {
      print('Error downloading document: $e');
      // Handle error accordingly
    }
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
                    onTap: () {
                      _downloadDocument(documents[index]);
                    },
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
