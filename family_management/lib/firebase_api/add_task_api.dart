import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AddTaskApi {
  Future<List<Map<String, String>>> getAllMemberNames(
      String familyId, String currentMemberId) async {
    List<Map<String, String>> memberNames = [];

    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('Family/$familyId/members').get();

      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
        String? memberName = data?['member_name'];

        String memberId = doc.id;

        if (memberName != null && memberId != currentMemberId) {
          memberNames.add({'id': memberId, 'name': memberName});
        }
      });
    } catch (e) {
      print('Error fetching member names: $e');
    }

    return memberNames;
  }

  static Future<Response> addTask({
    required String familyId,
    required String memberId,
    required String task,
    String? assignedTo,
    required String dueDate,
    required String dueTime,
    bool isAssignedToEveryone = false,
  }) async {
    Response response = Response();

    if ((assignedTo != null && isAssignedToEveryone) ||
        (assignedTo == null && !isAssignedToEveryone)) {
      response.code = 400;
      response.message =
          'Either assignedTo or isAssignedToEveryone should be provided, but not both';
      return response;
    }

    try {
      CollectionReference tasksCollection =
          _firestore.collection('Family/$familyId/todoTasks');
      DocumentReference docRef = await tasksCollection.add({
        'task': task,
        if (assignedTo != null)
          'assignedTo': assignedTo
        else
          'assignedTo': "everyone",
        'dueDate': dueDate,
        'dueTime': dueTime,
        'memberId': memberId,
        'iscompleted': false,
        'createdAt': Timestamp.now(),
      });

      response.code = 200;
      response.message = 'Task added successfully';
      response.id = docRef.id;
    } catch (e) {
      print('Error adding task: $e');
      response.code = 500;
      response.message = 'Error adding task';
    }

    return response;
  }
}
