import 'package:family_management/get_size.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddExpanse extends StatefulWidget {
  const AddExpanse({super.key});

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

  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompnentSize.background,
        title: Text(
          'Add transaction',
          style: TextStyle(
              fontFamily: 'MooliBold',
              color: CompnentSize.boldTextColor,
              fontWeight: FontWeight.w700,
              fontSize: CompnentSize.getFontSize(context, 0.03)),
        ),
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
                decoration: InputDecoration(labelText: 'Expense Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the expense name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the amount';
                  }
                  return null;
                },
              ),
              SfDateRangePicker(
                onSelectionChanged: _onSelectionChanged,
                selectionMode: DateRangePickerSelectionMode.range,
              ),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(labelText: 'Time'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String name = _nameController.text;
                    String description = _descriptionController.text;
                    double amount = double.parse(_amountController.text);
                    String date = _dateController.text;
                    String time = _timeController.text;

                    // Clear the form fields
                    _nameController.clear();
                    _descriptionController.clear();
                    _amountController.clear();
                    _dateController.clear();
                    _timeController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Expense submitted successfully')),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    // TODO: implement your code here
  }
}
