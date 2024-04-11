import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:family_management/documents/add_cat.dart';
import 'package:family_management/documents/home_doc.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
            _selectedFile != null
                ? Text('Selected File: ${_selectedFile!.name}')
                : SizedBox(),
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    String fileName = _selectedFile!.name!;
    List<int> fileBytes = _selectedFile!.bytes!;

    try {
      String fileUrl = await uploadFileToFirebase(
          fileBytes, fileName, AddFileScreen.familyId);

      await FirebaseFirestore.instance
          .collection('Family')
          .doc(AddFileScreen.familyId)
          .collection('Documents')
          .add({
        'category': _selectedCategory!,
        'documentName': _documentNameController.text.trim(),
        'fileName': fileName,
        'fileUrl': fileUrl,
        'createdAt': Timestamp.now(),
      });

      Get.off(() => HomeDoc(
          familyId: AddFileScreen.familyId, memberId: AddFileScreen.memberId));
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

  Future<String> uploadFileToFirebase(
      List<int> fileBytes, String fileName, String familyId) async {
    try {
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('familyDocuments/$familyId/$fileName');
      UploadTask uploadTask =
          firebaseStorageRef.putData(Uint8List.fromList(fileBytes));

      TaskSnapshot taskSnapshot = await uploadTask;
      String fileUrl = await taskSnapshot.ref.getDownloadURL();
      print('File uploaded successfully. URL: $fileUrl');
      return fileUrl;
    } catch (e) {
      print('Error uploading file to Firebase Storage: $e');
      throw e;
    }
  }
}
