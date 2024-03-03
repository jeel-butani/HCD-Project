import 'package:family_management/budget/home_budget.dart';
import 'package:family_management/get_size.dart';
import 'package:family_management/login_family.dart';
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
            'Dashbord',
            style: TextStyle(
                fontFamily: 'MooliBold',
                color: CompnentSize.boldTextColor,
                fontWeight: FontWeight.w900),
          ),
        ),
        drawer: buildDrawer(context),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        Get.off(() => HomeBudget(
                              familyId: Home.familyId,
                              memberId: Home.memberId,
                            ));
                      },
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
                              width: 100, // Set width of the image
                              height: 100, // Set height of the image
                              child: Image.asset(
                                'assets/images/budget.png',
                                fit: BoxFit
                                    .contain, // Adjust the fit of the image
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Budget",
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: CompnentSize.getWidth(context, 0.43),
                      height: CompnentSize.getHeight(context, 0.25),
                      decoration: BoxDecoration(
                        color: CompnentSize.background,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
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
                fontFamily: 'Mooli', // Set font style
              ),
            ),
            onTap: () {
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'Mooli', // Set font style
              ),
            ),
            onTap: () {
              // Add your settings logic here
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(
                fontFamily: 'Mooli', // Set font style
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
          // Add more ListTile widgets for additional drawer items
        ],
      ),
    );
  }
}
