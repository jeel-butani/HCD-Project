import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class BankInfoService {
  static Future<Response> addBankInfo({
    required String familyId,
    required String memberId,
    required String bankName,
    required String branchName,
    required String ifscCode,
    required String ownerName,
    required String accountName,
    required String email,
    required String phoneNumber,
    required String accountType,
  }) async {
    final CollectionReference _collection =
        _firestore.collection('Family/$familyId/bankInfo');
    Response response = Response();
    DocumentReference documentReferencer = _collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "bankName": bankName,
      "branchName": branchName,
      "ifscCode": ifscCode,
      "ownerName": ownerName,
      "accountName": accountName,
      "email": email,
      "phoneNumber": phoneNumber,
      "accountType": accountType,
    };

    try {
      await documentReferencer.set(data);
      response.code = 200;
      response.message = "Successfully added to the database";
      response.id = documentReferencer.id;
    } catch (e) {
      response.code = 500;
      response.message = e.toString();
    }

    return response;
  }
}
