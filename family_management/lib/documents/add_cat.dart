import 'package:family_management/firebase_api/add_cat_doc.dart';
import 'package:family_management/get_size.dart';
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
        backgroundColor: CompnentSize.background,
        title: Text(
          'Add Category',
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
                addCategory();
              },
              child: Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }

  void addCategory() async {
    var response = await AddCategoryApi.addCategory(
      familyId: AddCategory.familyId,
      categoryName: _categoryController.text.trim(),
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
        SnackBar(content: Text('Category added successfully')),
      );
    }
  }
}
