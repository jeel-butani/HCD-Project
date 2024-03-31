import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_management/model/documentData.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FetchDocument {
  static Future<List<DocumentData>> fetchDocuments({
    required String familyId,
    required String selectedCategory,
  }) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Family')
          .doc(familyId)
          .collection('Documents')
          .where('category', isEqualTo: selectedCategory)
          .get();

      List<DocumentData> documents = querySnapshot.docs.map((document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return DocumentData(
          documentId: document.id,
          documentName: data['documentName'] ?? '',
          categoryName: data['categoryName'] ?? '',
          fileData: data['fileData'] ?? '',
        );
      }).toList();

      return documents;
    } catch (e) {
      print('Error fetching documents: $e');
      return [];
    }
  }
}
