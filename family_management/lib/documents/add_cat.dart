import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCategory extends StatefulWidget {
  static String familyId = "";
  static String memberId = "";
  AddCategory({Key? key, required String familyId, required String memberId}) {
    AddCategory.familyId = familyId;
    AddCategory.memberId = memberId;
  }

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _categoryController,
              decoration: InputDecoration(
                labelText: 'Category Name',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter the category name';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {

                _addCategory();
              },
              child: Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }

  void _addCategory() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Category added successfully')),
    );
    Get.back();
  }
}
