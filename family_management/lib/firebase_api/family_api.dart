import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('Family');

class FamilyCrud {
//CRUD method here
  static Future<Response> addFamily({
    required String name,
    required String size,
    required String phoneNum,
    required String email,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();
    final now = DateTime.now();
    Map<String, dynamic> data = <String, dynamic>{
      "family_name": name,
      "family_size": size,
      "head_num": phoneNum,
      "head_email": email,
      "createAt": now,
      "status": true,
    };

    // ignore: unused_local_variable
    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });
    if (response.code == 200) {
      response.id = documentReferencer.id;
    }
    return response;
  }

  static Future<bool> checkFamily({
    required String phoneNum,
    required String email,
  }) async {

    QuerySnapshot phoneSnapshot = await FirebaseFirestore.instance
        .collection('families')
        .where('head_num', isEqualTo: phoneNum)
        .get();
    QuerySnapshot emailSnapshot = await FirebaseFirestore.instance
        .collection('families')
        .where('head_num', isEqualTo: phoneNum)
        .get();

    return phoneSnapshot.docs.isNotEmpty || emailSnapshot.docs.isNotEmpty;
  }

  static Future<String?> LoginFamily({
    required String email,
    required String phoneNum,
  }) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Family')
        .where('head_num', isEqualTo: phoneNum)
        .where('head_email', isEqualTo: email)
        .get();
    // print(querySnapshot.docs);
    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    } else {
      // No document found matching the provided criteria
      return null;
    }
  }
}
