import 'package:family_management/get_size.dart';
import 'package:family_management/ui_helper.dart';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _taskController = TextEditingController();
  TextEditingController _assignedToController = TextEditingController();
  TextEditingController _dueDateController = TextEditingController();
  TextEditingController _dueTimeController = TextEditingController();
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
              TextFormField(
                controller: _assignedToController,
                decoration: InputDecoration(
                  labelText: 'Assigned To',
                  hintText: 'John',
                  labelStyle: TextStyle(fontFamily: 'Mooli'),
                  hintStyle: TextStyle(fontFamily: 'Mooli'),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the assigned person';
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

  void addTask() {}
}
