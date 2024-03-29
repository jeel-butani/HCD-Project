import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

class AddFileScreen extends StatefulWidget {
  static String familyId = "";
  static String memberId = "";
  AddFileScreen(
      {Key? key, required String familyId, required String memberId}) {
    AddFileScreen.familyId = familyId;
    AddFileScreen.memberId = memberId;
  }

  @override
  _AddFileScreenState createState() => _AddFileScreenState();
}

class _AddFileScreenState extends State<AddFileScreen> {
  String? _selectedCategory;
  TextEditingController _documentNameController = TextEditingController();
  List<String> _categories = [];
  PlatformFile? _selectedFile;

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add File'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              onChanged: (String? value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Category',
                labelStyle: TextStyle(
                  fontFamily: 'MooliBold',
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _documentNameController,
              decoration: InputDecoration(
                labelText: 'Document Name',
                labelStyle: TextStyle(
                  fontFamily: 'MooliBold',
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Choose File'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addFile,
              child: Text(
                "Save",
                style: TextStyle(
                  fontFamily: 'MooliBold',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchCategories() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Family')
          .doc(AddFileScreen.familyId)
          .collection('DocCategories')
          .get();

      setState(() {
        _categories = querySnapshot.docs
            .map((doc) => doc['categoryName'] as String)
            .toList();
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<void> _pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        setState(() {
          _selectedFile = result.files.first;
        });
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  Future<void> _addFile() async {
    if (_selectedCategory == null ||
        _documentNameController.text.isEmpty ||
        _selectedFile == null) {
      return;
    }

    String fileName = _selectedFile!.name!;
    String filePath = _selectedFile!.path!;

    try {
      await FirebaseFirestore.instance
          .collection('Family')
          .doc(AddFileScreen.familyId)
          .collection('Documents')
          .add({
        'category': _selectedCategory!,
        'documentName': _documentNameController.text.trim(),
        'fileName': fileName,
        'filePath': filePath,
        'createAt': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('File added successfully')),
      );
    } catch (e) {
      print('Error uploading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading file')),
      );
    }
  }
}
