import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_management/firebase_api/fetch_task_api.dart';
import 'package:family_management/get_size.dart';
import 'package:family_management/model/task.dart';
import 'package:family_management/todo/add_task.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Todo extends StatefulWidget {
  static String familyId = "";
  static String memberId = "";
  Todo({super.key, required String familyId, required String memberId}) {
    Todo.familyId = familyId;
    Todo.memberId = memberId;
  }

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List<TaskData> assignedTasks = [];

  List<TaskData> givenTasks = [
    TaskData(
      task: 'Review code changes',
      assignedTo: 'Bob',
      dueDate: '2024-03-12',
      dueTime: '14:00',
      assignBy: 'Someone Else',
      createdAt: DateTime.now(),
      iscompleted: false,
      taskId: '',
    ),
    TaskData(
      task: 'Arrange team meeting',
      assignedTo: 'Emily',
      dueDate: '2024-03-15',
      dueTime: '09:00',
      assignBy: 'Someone Else',
      createdAt: DateTime.now(),
      iscompleted: false,
      taskId: '',
    ),
  ];

  List<TaskData> currentTasks = [];
  String dropdownValue = 'Assigned Tasks';

  @override
  void initState() {
    super.initState();
    fetchAssignedTasks();
  }

  Future<void> fetchAssignedTasks() async {
    try {
      List<TaskData> tasks = await FetchTask.fetchTasks(
        familyId: Todo.familyId,
        memberId: Todo.memberId,
      );
      print('Tasks: ' + tasks.toString());
      setState(() {
        assignedTasks = tasks;
        currentTasks = assignedTasks;
      });
    } catch (e) {
      print('Error fetching assigned tasks: $e');
      // Handle error accordingly
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: currentTasks.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                title: Text(
                  currentTasks[index].task,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    decoration: currentTasks[index].iscompleted ?? false
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                subtitle: Text(
                  'Assigned By: ${currentTasks[index].assignBy}   • Due ${currentTasks[index].dueDate} ${currentTasks[index].dueTime}',
                ),
                trailing: currentTasks == givenTasks
                    ? IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            currentTasks.removeAt(index);
                          });
                        },
                      )
                    : Checkbox(
                        value: currentTasks[index].iscompleted ?? false,
                        onChanged: (value) async {
                          setState(() {
                            currentTasks[index].iscompleted = value!;
                          });
                          // Update iscompleted value in Firestore
                          try {
                            await FirebaseFirestore.instance
                                .collection('Family')
                                .doc(Todo.familyId)
                                .collection('todoTasks')
                                .doc(currentTasks[index].taskId)
                                .update({'iscompleted': value});
                          } catch (e) {
                            print('Error updating iscompleted value: $e');
                            // Handle error accordingly
                          }
                        },
                      )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddTask(
                familyId: Todo.familyId,
                memberId: Todo.memberId,
              ));
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    currentTasks = dropdownValue == 'Assigned Tasks'
                        ? assignedTasks
                        : givenTasks;
                  });
                },
                items: <String>['Assigned Tasks', 'Given Tasks']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
