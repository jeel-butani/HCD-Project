import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_management/model/docCat.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FetchCategory {
  static Future<List<DocCategoryData>> fetchCategories(String familyId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Family')
          .doc(familyId)
          .collection('DocCategories')
          .get();

      List<DocCategoryData> categories = querySnapshot.docs.map((document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return DocCategoryData(
          categoryId: document.id,
          categoryName: data['categoryName'] ?? '',
        );
      }).toList();

      return categories;
    } catch (e) {
      print('Error fetching categories: $e');
      return [];
    }
  }
}
