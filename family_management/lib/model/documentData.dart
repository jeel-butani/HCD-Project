import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentData {
  final String documentId;
  final String documentName;
  final String fileData;
  final String categoryName;

  DocumentData({
    required this.documentId,
    required this.documentName,
    required this.fileData,
    required this.categoryName,
  });

  factory DocumentData.fromMap(Map<String, dynamic> map, String documentId) {
    return DocumentData(
      documentId: documentId,
      documentName: map['documentName'] ?? '',
      fileData: map['fileData'] ?? '',
      categoryName: map['categoryName'] ?? '',
    );
  }
}
