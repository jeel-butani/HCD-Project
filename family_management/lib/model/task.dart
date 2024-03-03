import 'package:cloud_firestore/cloud_firestore.dart';

class TaskData {
  final String taskId;
  final String task;
  final String assignedTo;
  final String dueDate;
  final String dueTime;
  bool iscompleted;
  final String assignBy;
  final DateTime createdAt;

  TaskData({
    required this.taskId,
    required this.task,
    required this.assignedTo,
    required this.dueDate,
    required this.dueTime,
    required this.iscompleted,
    required this.assignBy,
    required this.createdAt,
  });

  factory TaskData.fromMap(String taskId, Map<String, dynamic> map) {
    return TaskData(
      taskId: taskId,
      task: map['task'] ?? '',
      assignedTo: map['assignedTo'] ?? '',
      dueDate: map['dueDate'] ?? '',
      dueTime: map['dueTime'] ?? '',
      iscompleted: map['iscompleted'] ?? false,
      assignBy: map['assignBy'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate() ?? DateTime.now(),
    );
  }
}