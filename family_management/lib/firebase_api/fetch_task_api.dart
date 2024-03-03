import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_management/model/task.dart';
import 'package:family_management/model/transaction.dart';
import '../model/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FetchTask {
  static Future<List<TaskData>> fetchTasks({
    required String familyId,
    required String memberId,
  }) async {
    try {
      DocumentSnapshot memberSnapshot = await _firestore
          .collection('Family')
          .doc(familyId)
          .collection('members')
          .doc(memberId)
          .get();

      String memberName = memberSnapshot.get('member_name') ?? '';

      QuerySnapshot querySnapshot = await _firestore
          .collection('Family')
          .doc(familyId)
          .collection('todoTasks')
          .where('assignedTo', isEqualTo: memberName)
          .get();

      QuerySnapshot querySnapshotEveryone = await _firestore
          .collection('Family')
          .doc(familyId)
          .collection('todoTasks')
          .where('assignedTo', isEqualTo: 'everyone')
          .get();

      List<TaskData> tasks = [];

      tasks.addAll(querySnapshot.docs.map((document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return TaskData(
          taskId: document.id, // Assuming taskId is the document ID
          task: data['task'] ?? '',
          assignedTo: data['assignedTo'] ?? '',
          dueDate: data['dueDate'] ?? '',
          dueTime: data['dueTime'] ?? '',
          iscompleted: data['iscompleted'] ?? false,
          assignBy: data['assignBy'] ?? '',
          createdAt:
              (data['createdAt'] as Timestamp).toDate() ?? DateTime.now(),
        );
      }));

      tasks.addAll(querySnapshotEveryone.docs.map((document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return TaskData(
          taskId: document.id, // Assuming taskId is the document ID
          task: data['task'] ?? '',
          assignedTo: data['assignedTo'] ?? '',
          dueDate: data['dueDate'] ?? '',
          dueTime: data['dueTime'] ?? '',
          iscompleted: data['iscompleted'] ?? false,
          assignBy: data['assignBy'] ?? '',
          createdAt:
              (data['createdAt'] as Timestamp).toDate() ?? DateTime.now(),
        );
      }));

      return tasks;
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }
}
