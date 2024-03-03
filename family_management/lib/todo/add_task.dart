import 'package:family_management/firebase_api/add_task_api.dart';
import 'package:family_management/get_size.dart';
import 'package:family_management/todo/home_todo.dart';
import 'package:family_management/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTask extends StatefulWidget {
  static String familyId = "";
  static String memberId = "";
  AddTask({super.key, required String familyId, required String memberId}) {
    AddTask.familyId = familyId;
    AddTask.memberId = memberId;
  }

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  List<String> assignees = [];
  final _formKey = GlobalKey<FormState>();
  String? _selectedAssignedTo;
  TextEditingController _taskController = TextEditingController();
  TextEditingController _assignedToController = TextEditingController();
  TextEditingController _dueDateController = TextEditingController();
  TextEditingController _dueTimeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAssignees();
  }

  void fetchAssignees() async {
    AddTaskApi addTaskApi = AddTaskApi();
    List<Map<String, String>> users =
        await addTaskApi.getAllMemberNames(AddTask.familyId, AddTask.memberId);

    List<String> assigneesList = users.map((user) => user['name']!).toList();
    assigneesList.add('Everyone');

    setState(() {
      assignees = assigneesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompnentSize.background,
        title: Text(
          'Add Task',
          style: TextStyle(
            fontFamily: 'Mooli',
            color: CompnentSize.boldTextColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _taskController,
                decoration: InputDecoration(
                  labelText: 'Task',
                  hintText: 'Complete project report',
                  labelStyle: TextStyle(fontFamily: 'Mooli'),
                  hintStyle: TextStyle(fontFamily: 'Mooli'),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the task';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: _selectedAssignedTo,
                onChanged: (String? value) {
                  setState(() {
                    _selectedAssignedTo = value;
                  });
                },
                items: assignees.map((String assignee) {
                  return DropdownMenuItem<String>(
                    value: assignee,
                    child: Text(assignee),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Assigned To',
                  labelStyle: TextStyle(fontFamily: 'Mooli'),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an assignee';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _dueDateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Due Date',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                _dueDateController.text =
                                    pickedDate.toString().split(' ')[0];
                              });
                            }
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select the due date';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      controller: _dueTimeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Due Time',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              setState(() {
                                _dueTimeController.text =
                                    pickedTime.format(context);
                              });
                            }
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select the due time';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              UiHelper.customButton(
                () {
                  if (_formKey.currentState!.validate()) {
                    addTask();
                  }
                },
                'Add Task',
                context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addTask() async {
    String? assignedTo;
    if (_selectedAssignedTo != 'Everyone') {
      assignedTo = _selectedAssignedTo;
    } else {
      assignedTo = null;
    }

    var response = await AddTaskApi.addTask(
      familyId: AddTask.familyId,
      memberId: AddTask.memberId,
      task: _taskController.text.trim(),
      assignedTo: assignedTo,
      dueDate: _dueDateController.text.trim(),
      dueTime: _dueTimeController.text.trim(),
      isAssignedToEveryone: _selectedAssignedTo == 'Everyone',
    );

    if (response.code != 200) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(response.message.toString()),
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task added successfully')),
      );
      Get.off(
          () => Todo(familyId: AddTask.familyId, memberId: AddTask.memberId));
    }
  }
}
