import 'package:family_management/documents/add_cat.dart';
import 'package:family_management/get_size.dart';
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
      body: ListView(
        children: [
          _buildCategoryRow('Result', Icons.assignment),
          _buildCategoryRow('Light Bills', Icons.lightbulb),
          _buildCategoryRow('10th Document', Icons.school),
          _buildCategoryRow('12th Document', Icons.school),
          _buildCategoryRow('Gas Bills', Icons.local_gas_station),
        ],
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

  Widget _buildCategoryRow(String categoryName, IconData icon) {
    return InkWell(
      onTap: () {
        setState(() {
          _selectedCategory = categoryName;
        });
      },
      child: ListTile(
        leading: Icon(
          icon,
          color: CompnentSize.background,
        ),
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
                  Get.back();
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
                  Get.to(AddCategory(familyId: HomeDoc.familyId, memberId: HomeDoc.memberId));
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
