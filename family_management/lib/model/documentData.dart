import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentData {
  final String documentId;
  final String documentName;
  final String fileUrl;
  final String categoryName;

  DocumentData({
    required this.documentId,
    required this.documentName,
    required this.fileUrl,
    required this.categoryName,
  });

  factory DocumentData.fromMap(Map<String, dynamic> map, String documentId) {
    return DocumentData(
      documentId: documentId,
      documentName: map['documentName'] ?? '',
      fileUrl: map['fileUrl'] ?? '',
      categoryName: map['categoryName'] ?? '',
    );
  }
}
