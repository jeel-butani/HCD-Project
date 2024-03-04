import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_management/model/task.dart';
import 'package:family_management/model/transaction.dart';
import '../model/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FetchTask {
  static Future<List<TaskData>> fetchAssignedTasks({
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
          .where('memberId', isNotEqualTo: memberId)
          .get();

      List<TaskData> tasks = [];

      tasks.addAll(await Future.wait(querySnapshot.docs.map((document) async {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        String assignById = data['memberId'] ?? '';
        String assignByName = await getMemberName(familyId, assignById);
        return TaskData(
          taskId: document.id,
          task: data['task'] ?? '',
          assignedTo: data['assignedTo'] ?? '',
          dueDate: data['dueDate'] ?? '',
          dueTime: data['dueTime'] ?? '',
          iscompleted: data['iscompleted'] ?? false,
          assignBy: assignByName, // Use the member name here
          createdAt:
              (data['createdAt'] as Timestamp).toDate() ?? DateTime.now(),
        );
      }).toList()));

      tasks.addAll(
          await Future.wait(querySnapshotEveryone.docs.map((document) async {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        String assignById = data['memberId'] ?? '';
        String assignByName = await getMemberName(familyId, assignById);
        return TaskData(
          taskId: document.id,
          task: data['task'] ?? '',
          assignedTo: data['assignedTo'] ?? '',
          dueDate: data['dueDate'] ?? '',
          dueTime: data['dueTime'] ?? '',
          iscompleted: data['iscompleted'] ?? false,
          assignBy: assignByName, // Use the member name here
          createdAt:
              (data['createdAt'] as Timestamp).toDate() ?? DateTime.now(),
        );
      }).toList()));

      return tasks;
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }

  static Future<List<TaskData>> fetchGivenTasks({
    required String familyId,
    required String memberId,
  }) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Family')
          .doc(familyId)
          .collection('todoTasks')
          .where('memberId', isEqualTo: memberId)
          .get();

      List<TaskData> tasks = querySnapshot.docs.map((document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return TaskData(
          taskId: document.id,
          task: data['task'] ?? '',
          assignedTo: data['assignedTo'] ?? '',
          dueDate: data['dueDate'] ?? '',
          dueTime: data['dueTime'] ?? '',
          iscompleted: data['iscompleted'] ?? false,
          assignBy: data['assignBy'] ?? '',
          createdAt:
              (data['createdAt'] as Timestamp).toDate() ?? DateTime.now(),
        );
      }).toList();

      return tasks;
    } catch (e) {
      print('Error fetching tasks: $e');
      return [];
    }
  }

  static Future<String> getMemberName(String familyId, String memberId) async {
    try {
      DocumentSnapshot memberSnapshot = await _firestore
          .collection('Family')
          .doc(familyId)
          .collection('members')
          .doc(memberId)
          .get();
      return memberSnapshot.get('member_name') ?? '';
    } catch (e) {
      print('Error fetching member name: $e');
      return '';
    }
  }
}
