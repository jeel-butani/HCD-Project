import 'package:family_management/get_size.dart';
import 'package:family_management/home.dart';
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
  List<Map<String, dynamic>> assignedTasks = [
    {
      'task': 'Complete project report',
      'assignedTo': 'John',
      'dueDate': '2024-03-10',
      'dueTime': '08:00',
      'completed': false,
      'assignedBy': 'You',
    },
    {
      'task': 'Prepare presentation slides',
      'assignedTo': 'Alice',
      'dueDate': '2024-03-08',
      'dueTime': '10:30',
      'completed': false,
      'assignedBy': 'You',
    },
  ];

  List<Map<String, dynamic>> givenTasks = [
    {
      'task': 'Review code changes',
      'assignedTo': 'Bob',
      'dueDate': '2024-03-12',
      'dueTime': '14:00',
      'completed': true,
      'assignedBy': 'Someone Else',
    },
    {
      'task': 'Arrange team meeting',
      'assignedTo': 'Emily',
      'dueDate': '2024-03-15',
      'dueTime': '09:00',
      'completed': false,
      'assignedBy': 'Someone Else',
    },
  ];

  List<Map<String, dynamic>> currentTasks =
      []; // Will store either assignedTasks or givenTasks based on dropdown selection
  String dropdownValue = 'Assigned Tasks'; // Default dropdown value

  @override
  void initState() {
    super.initState();
    currentTasks = assignedTasks; // Default to assigned tasks
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompnentSize.background,
        title: Text(
          'ToDo List',
          style: TextStyle(
            fontFamily: 'MooliBold',
            color: CompnentSize.boldTextColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: currentTasks.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                currentTasks[index]['task'],
                style: TextStyle(
                  fontFamily: 'MooliBold',
                  fontSize: CompnentSize.getFontSize(context, 0.03),
                  color: CompnentSize.textColor,
                  fontWeight: FontWeight.w700,
                  decoration: currentTasks[index]['completed']
                      ? TextDecoration.lineThrough
                      : TextDecoration
                          .none, // Add line-through decoration when task is completed
                ),
              ),
              subtitle: Text(
                '${currentTasks[index]['assignedTo']}   • Due ${currentTasks[index]['dueDate']} ${currentTasks[index]['dueTime']}',
                style: TextStyle(
                  fontFamily: 'MooliBold',
                  fontSize: CompnentSize.getFontSize(context, 0.026),
                  color: CompnentSize.textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: currentTasks == givenTasks
                  ? Checkbox(
                      value: currentTasks[index]['completed'],
                      onChanged: (value) {
                        setState(() {
                          currentTasks[index]['completed'] = value;
                        });
                      },
                      activeColor: Colors.blue,
                    )
                  : IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          currentTasks.removeAt(index);
                        });
                      },
                    ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade300,
        onPressed: () {
          Get.to(
              () => AddTask(familyId: Todo.familyId, memberId: Todo.memberId));
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
