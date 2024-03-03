import 'package:family_management/get_size.dart';
import 'package:flutter/material.dart';

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
  List<Map<String, dynamic>> todoTasks = [
    {
      'task': 'Complete project report',
      'assignedTo': 'John',
      'dueDate': '2024-03-10',
      'dueTime': '08:00', // Add due time here
      'completed': false
    },
    {
      'task': 'Prepare presentation slides',
      'assignedTo': 'Alice',
      'dueDate': '2024-03-08',
      'dueTime': '10:30', // Add due time here
      'completed': false
    },
    {
      'task': 'Review code changes',
      'assignedTo': 'Bob',
      'dueDate': '2024-03-12',
      'dueTime': '14:00', // Add due time here
      'completed': true
    },
    {
      'task': 'Arrange team meeting',
      'assignedTo': 'Emily',
      'dueDate': '2024-03-15',
      'dueTime': '09:00', // Add due time here
      'completed': false
    },
  ];

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
        itemCount: todoTasks.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                todoTasks[index]['task'],
                style: TextStyle(
                  fontFamily: 'MooliBold',
                  fontSize: CompnentSize.getFontSize(context, 0.03),
                  color: CompnentSize.textColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                '${todoTasks[index]['assignedTo']}   • Due ${todoTasks[index]['dueDate']} ${todoTasks[index]['dueTime']}', // Include due time here
                style: TextStyle(
                  fontFamily: 'MooliBold',
                  fontSize: CompnentSize.getFontSize(context, 0.026),
                  color: CompnentSize.textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Checkbox(
                value: todoTasks[index]['completed'],
                onChanged: (value) {
                  setState(() {
                    todoTasks[index]['completed'] = value;
                  });
                },
                activeColor: Colors.blue, // Color of the checkbox when selected
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade300,
        onPressed: () {
          // Add your functionality here to add new tasks
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
