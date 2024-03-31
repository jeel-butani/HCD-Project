import 'package:family_management/documents/add_cat.dart';
import 'package:family_management/documents/add_file.dart';
import 'package:family_management/documents/documentListPage.dart';
import 'package:family_management/firebase_api/fetch_cat_doc.dart';
import 'package:family_management/get_size.dart';
import 'package:family_management/model/docCat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDoc extends StatefulWidget {
  static String familyId = "";
  static String memberId = "";
  HomeDoc({Key? key, required String familyId, required String memberId}) {
    HomeDoc.familyId = familyId;
    HomeDoc.memberId = memberId;
  }

  @override
  State<HomeDoc> createState() => _HomeDocState();
}

class _HomeDocState extends State<HomeDoc> {
  String? _selectedCategory;
  List<String> _categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  void _fetchCategories() async {
    List<DocCategoryData> categories =
        await FetchCategory.fetchCategories(HomeDoc.familyId);

    List<String> categoryNames =
        categories.map((category) => category.categoryName).toList();

    setState(() {
      _categories = categoryNames;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompnentSize.background,
        title: Text(
          'Documents',
          style: TextStyle(
            fontFamily: 'MooliBold',
            color: CompnentSize.boldTextColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return _buildCategoryRow(_categories[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade300,
        onPressed: () {
          _showAddOptionsDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildCategoryRow(String categoryName) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategory = categoryName;
        });
        Get.to(() => DocumentListPage(
              category: categoryName,
              familyId: HomeDoc.familyId,
              memberId: HomeDoc.memberId,
            ));
      },
      child: ListTile(
        title: Text(
          categoryName,
          style: TextStyle(
            fontFamily: 'MooliBold',
            fontSize: CompnentSize.getFontSize(context, 0.035),
            color: CompnentSize.textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: CompnentSize.background,
        ),
      ),
    );
  }

  void _showAddOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  Get.to(() => AddFileScreen(
                        familyId: HomeDoc.familyId,
                        memberId: HomeDoc.memberId,
                      ));
                },
                child: Text(
                  "+ File",
                  style: TextStyle(
                    fontFamily: 'MooliBold',
                    fontSize: CompnentSize.getFontSize(context, 0.03),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Get.to(AddCategory(
                      familyId: HomeDoc.familyId, memberId: HomeDoc.memberId));
                },
                child: Text(
                  "+ Categories",
                  style: TextStyle(
                    fontFamily: 'MooliBold',
                    fontSize: CompnentSize.getFontSize(context, 0.03),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
