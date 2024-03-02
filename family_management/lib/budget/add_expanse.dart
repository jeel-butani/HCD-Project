import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_management/budget/home_budget.dart';
import 'package:family_management/get_size.dart';
import 'package:family_management/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../firebase_api/add_transaction_api.dart';

class AddExpanse extends StatefulWidget {
  static String familyId = "TBmPjzN6DepMg6PJmnAT";
  static String memberId = "vh7NdX3kI3jFG8rwl8fC";
  const AddExpanse(
      {super.key, required String familyId, required String memberId});

  @override
  State<AddExpanse> createState() => _AddExpanseState();
}

class _AddExpanseState extends State<AddExpanse> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  bool _isExpense = true; // Initially set as expense

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompnentSize.background,
        title: Text(
          'Add Transaction',
          style: TextStyle(
              fontFamily: 'MooliBold',
              color: CompnentSize.boldTextColor,
              fontWeight: FontWeight.w900),
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
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Expense Name',
                  hintText: 'Food/ Shopping',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the expense name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Type',
                  hintText: 'Cash/ Kotak/ HDFC/ GPay',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the Type';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration:
                    InputDecoration(labelText: 'Amount', hintText: '10.0'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the amount';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Date',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.calendar_today),
                          onPressed: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime
                                  .now(), // Only allow past and present dates
                            );
                            if (pickedDate != null) {
                              setState(() {
                                _dateController.text =
                                    pickedDate.toString().split(' ')[0];
                              });
                            }
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select the date';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      controller: _timeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Time',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.access_time),
                          onPressed: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              setState(() {
                                _timeController.text =
                                    pickedTime.format(context);
                              });
                            }
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please select the time';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Transaction Type:'),
                  SizedBox(width: 10),
                  DropdownButton<bool>(
                    value: _isExpense,
                    onChanged: (bool? value) {
                      setState(() {
                        _isExpense = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        value: true,
                        child: Text('Expense'),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: Text('Income'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              UiHelper.customButton(() {
                if (_formKey.currentState!.validate()) {
                  addTarans();
                }
              }, 'submit', context),
            ],
          ),
        ),
      ),
    );
  }

  void addTarans() async {
    var response = await Transactions.addTransaction(
      familyId: AddExpanse.familyId,
      memberId: AddExpanse.memberId,
      name: _nameController.text.trim(),
      type: _descriptionController.text.trim(),
      amount: double.parse(_amountController.text.trim()),
      date: _dateController.text.trim(),
      time: _timeController.text.trim(),
      isExpense: _isExpense,
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
        SnackBar(content: Text('Transaction submitted successfully')),
      );
      Get.off(() => HomeBudget(
          familyId: AddExpanse.familyId, memberId: AddExpanse.memberId));
    }
  }
}
