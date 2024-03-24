import 'package:family_management/budget/home_budget.dart';
import 'package:family_management/documents/home_doc.dart';
import 'package:family_management/get_size.dart';
import 'package:family_management/login_family.dart';
import 'package:family_management/todo/home_todo.dart';
import 'package:family_management/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  static String familyId = "";
  static String memberId = "";
  Home({super.key, required String familyId, required String memberId}) {
    Home.familyId = familyId;
    Home.memberId = memberId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompnentSize.background,
        title: Text(
          'Dashboard',
          style: TextStyle(
            fontFamily: 'MooliBold',
            color: CompnentSize.boldTextColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: buildDrawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildDashboardItem(
                  context,
                  imageAsset: 'assets/images/budget.png',
                  title: 'Budget',
                  onTap: () {
                    Get.to(() => HomeBudget(
                          familyId: Home.familyId,
                          memberId: Home.memberId,
                        ));
                  },
                ),
                SizedBox(width: 10),
                buildDashboardItem(
                  context,
                  imageAsset: 'assets/images/todo.png',
                  title: 'ToDo',
                  onTap: () {
                    Get.to(() => Todo(
                          familyId: Home.familyId,
                          memberId: Home.memberId,
                        ));
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildDashboardItem(
                  context,
                  imageAsset: 'assets/images/doc.png',
                  title: 'Documents',
                  onTap: () {
                    Get.to(HomeDoc(
                      familyId: Home.familyId,
                      memberId: Home.memberId,
                    ));
                  },
                ),
                SizedBox(width: 10),
                buildDashboardItem(
                  context,
                  imageAsset: 'assets/images/your_image2.png',
                  title: 'Title',
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDashboardItem(
    BuildContext context, {
    required String imageAsset,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: CompnentSize.getWidth(context, 0.43),
        height: CompnentSize.getHeight(context, 0.25),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                imageAsset,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'MooliBold',
                color: CompnentSize.background,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: CompnentSize.getHeight(context, 0.15),
            child: UserAccountsDrawerHeader(
              accountName: Text(
                "Jeel",
                style: TextStyle(
                    fontFamily: 'Mooli',
                    fontSize: CompnentSize.getFontSize(
                        context, 0.05)), // Set font style
              ),
              accountEmail: Text(
                "butanijeel1@gmail.com",
                style: TextStyle(fontFamily: 'Mooli'), // Set font style
              ),
              decoration: BoxDecoration(
                color: CompnentSize.background,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text(
              'Home',
              style: TextStyle(
                fontFamily: 'Mooli',
              ),
            ),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Mooli',
              ),
            ),
            onTap: () {
              Get.back();
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(
                fontFamily: 'Mooli',
              ),
            ),
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setBool('isLogin', false);
              await prefs.setString('familyId', '');
              await prefs.setString('memberId', '');
              Get.offAll(() => LoginFamily());
            },
          ),
        ],
      ),
    );
  }
}
