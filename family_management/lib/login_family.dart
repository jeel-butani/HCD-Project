import 'package:family_management/get_size.dart';
import 'package:family_management/login_member.dart';
import 'package:family_management/signup_family.dart';
import 'package:family_management/ui_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginFamily extends StatefulWidget {
  const LoginFamily({super.key});

  @override
  State<LoginFamily> createState() => _LoginFamilyState();
}

class _LoginFamilyState extends State<LoginFamily> {
  late final TextEditingController familyIdController;
  late final TextEditingController familyPhoneController;
  @override
  void initState() {
    familyIdController = TextEditingController();
    familyPhoneController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompnentSize.background,
        title: Text(
          'Login Family',
          style: TextStyle(
              fontFamily: 'MooliBold',
              color: CompnentSize.boldTextColor,
              fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiHelper.customTextField(familyIdController, "Family Id",
                Icons.family_restroom, context),
            SizedBox(
              height: CompnentSize.getHeight(context, 0.015),
            ),
            UiHelper.customTextField(familyPhoneController,
                "Main of  Family Phone Number", Icons.phone, context),
            SizedBox(
              height: CompnentSize.getHeight(context, 0.025),
            ),
            UiHelper.customButton(() {
              Get.off(() => LoginMember());
            }, "Login", context),
            SizedBox(
              height: CompnentSize.getHeight(context, 0.01),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not Register as Family ??",
                  style: TextStyle(
                    fontFamily: 'MooliBold',
                    fontSize: CompnentSize.getFontSize(context, 0.04),
                    color: CompnentSize.textColor,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.off(() => SignupFamily());
                  },
                  child: Text(
                    "Sign up",
                    style: TextStyle(
                      fontFamily: 'MooliBold',
                      fontSize: CompnentSize.getFontSize(context, 0.04),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
