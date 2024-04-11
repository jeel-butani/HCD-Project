import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class Transactions {
  static Future<Response> addTransaction({
    required String familyId,
    required String memberId,
    required String name,
    required String type,
    required double amount,
    required String date,
    required String time,
    required bool isExpense,
  }) async {
    final CollectionReference _collection = _firestore.collection(
        'Family/' + familyId + "/members/" + memberId + "/transactions");
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc();
    final now = DateTime.now();
    Map<String, dynamic> data = <String, dynamic>{
      "name": name,
      "type": type,
      "amount": amount,
      "date": date,
      "time": time,
      "isExpense": isExpense,
      "createdAt": now,
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Successfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e.toString();
    });

    if (response.code == 200) {
      response.id = documentReferencer.id;
    }
    return response;
  }
}
