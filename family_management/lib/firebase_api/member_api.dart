import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class MemberCrud {
//CRUD method here
  static Future<Response> addMember(
      {required String familyId,
      required String name,
      required String phoneNum,
      required String email,
      required bool isHead}) async {
    final CollectionReference _Collection =
        _firestore.collection('Family/' + familyId + "/members");
    Response response = Response();
    DocumentReference documentReferencer = _Collection.doc();
    final now = DateTime.now();
    Map<String, dynamic> data = <String, dynamic>{
      "family_id": familyId,
      "member_name": name,
      "member_phone": phoneNum,
      "member_email": email,
      "isHead": isHead,
      "createAt": now,
      "status": true,
    };

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

  static Future<bool> checkMember(
      {required String familyId,
      required String phoneNum,
      required String email}) async {
    QuerySnapshot phoneQuerySnapshot = await FirebaseFirestore.instance
        .collection('Family/$familyId/members')
        .where('member_phone', isEqualTo: phoneNum)
        .get();

    QuerySnapshot emailQuerySnapshot = await FirebaseFirestore.instance
        .collection('Family/$familyId/members')
        .where('member_email', isEqualTo: email)
        .get();
    return phoneQuerySnapshot.docs.isNotEmpty ||
        emailQuerySnapshot.docs.isNotEmpty;
  }

  static Future<String?> LoginFamily({
    required String familyId,
    required String email,
    required String phoneNum,
  }) async {
    Response response = Response();
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Family/$familyId/members')
        .where('member_phone', isEqualTo: phoneNum)
        .where('member_email', isEqualTo: email)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    } else {
      return null;
    }
  }
}
