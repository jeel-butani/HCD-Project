import 'package:family_management/firebase_api/member_api.dart';
import 'package:family_management/get_size.dart';
import 'package:family_management/home.dart';
import 'package:family_management/signup_member.dart';
import 'package:family_management/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginMember extends StatefulWidget {
  static String familyId = "";
  LoginMember(String? iD, {super.key}) {
    familyId = iD!;
  }

  @override
  State<LoginMember> createState() => _LoginMemberState();
}

class _LoginMemberState extends State<LoginMember> {
  late TextEditingController emailController;
  late TextEditingController phoneController;
  String memberId = "";
  @override
  void initState() {
    emailController = TextEditingController();
    phoneController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompnentSize.background,
        title: Text(
          'Login as Member',
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
            UiHelper.customTextField(
                emailController, "Email", Icons.email, context),
            SizedBox(
              height: CompnentSize.getHeight(context, 0.015),
            ),
            UiHelper.customTextField(phoneController,
                "Please enter phone number", Icons.phone, context),
            SizedBox(
              height: CompnentSize.getHeight(context, 0.025),
            ),
            UiHelper.customButton(() {
              if (emailController.text.trim() != "" ||
                  phoneController.text.trim() != "") {
                logIn();
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("Please fill out all fields."),
                      );
                    });
              }
            }, "Login", context),
            SizedBox(
              height: CompnentSize.getHeight(context, 0.01),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "If you not register as member??",
                  style: TextStyle(
                    fontFamily: 'MooliBold',
                    fontSize: CompnentSize.getFontSize(context, 0.04),
                    color: CompnentSize.textColor,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Get.off(() => SignupMember(iD: LoginMember.familyId));
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

  void logIn() async {
    memberId = await MemberCrud.LoginMembar(
      familyId: LoginMember.familyId,
      email: emailController.text.trim(),
      phoneNum: phoneController.text.trim(),
    ).toString();

    if (memberId != "") {
      Get.off(() => Home(familyId: LoginMember.familyId, memberId: memberId));
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text("There no Family with this information"),
            );
          });
    }
  }
}
