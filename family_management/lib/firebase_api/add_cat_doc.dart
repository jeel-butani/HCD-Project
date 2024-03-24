import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AddCategoryApi {
  static Future<Response> addCategory({
    required String familyId,
    required String categoryName,
  }) async {
    Response response = Response();

    try {
      CollectionReference categoriesCollection =
          _firestore.collection('Family/$familyId/DocCategories');
      DocumentReference docRef = await categoriesCollection.add({
        'categoryName': categoryName,
        'createdAt': Timestamp.now(),
      });

      response.code = 200;
      response.message = 'Category added successfully';
      response.id = docRef.id;
    } catch (e) {
      print('Error adding category: $e');
      response.code = 500;
      response.message = 'Error adding category';
    }

    return response;
  }
}
