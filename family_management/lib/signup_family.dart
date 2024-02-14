import 'package:family_management/get_size.dart';
import 'package:family_management/login_family.dart';
import 'package:family_management/login_member.dart';
import 'package:family_management/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_api/family_api.dart';

class SignupFamily extends StatefulWidget {
  const SignupFamily({super.key});

  @override
  State<SignupFamily> createState() => _SignupFamilyState();
}

class _SignupFamilyState extends State<SignupFamily> {
  late TextEditingController familyNameController;
  late TextEditingController familyMemberController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  @override
  void initState() {
    familyNameController = TextEditingController();
    familyMemberController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompnentSize.background,
        title: Text(
          'Register Family',
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
            UiHelper.customTextField(familyNameController,
                "Family name e.g. happyHome", Icons.family_restroom, context),
            SizedBox(
              height: CompnentSize.getHeight(context, 0.015),
            ),
            UiHelper.customTextField(familyMemberController,
                "how many family member?", Icons.group, context),
            SizedBox(
              height: CompnentSize.getHeight(context, 0.025),
            ),
            UiHelper.customTextField(phoneController,
                "Main of Family phone number", Icons.phone, context),
            SizedBox(
              height: CompnentSize.getHeight(context, 0.025),
            ),
            UiHelper.customTextField(emailController,
                "Main of Family email number", Icons.email, context),
            SizedBox(
              height: CompnentSize.getHeight(context, 0.025),
            ),
            UiHelper.customButton(() {
              signUp();
              
            }, "Next", context),
            SizedBox(
              height: CompnentSize.getHeight(context, 0.01),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    fontFamily: 'MooliBold',
                    fontSize: CompnentSize.getFontSize(context, 0.04),
                    color: CompnentSize.textColor,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.off(() => LoginFamily());
                  },
                  child: Text(
                    "Login",
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

  void signUp() async {
    // print(phoneController.text.trim());
    if (familyNameController.text.trim() != "" &&
        familyMemberController.text.trim() != "" &&
        phoneController.text.trim() != "" &&
        emailController.text.trim() != "") {
      var response = await FirebaseCrud.addFamily(
          name: familyNameController.text.trim(),
          size: familyMemberController.text.trim(),
          phoneNum: phoneController.text.trim(),
          email: emailController.text.trim());
      if (response.code != 200) {
        Get.off(() => LoginMember());
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(response.message.toString()),
              );
            });
      }
    }
  }
}
