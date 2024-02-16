import 'package:family_management/firebase_api/member_api.dart';
import 'package:family_management/get_size.dart';
import 'package:family_management/home.dart';
import 'package:family_management/login_member.dart';
import 'package:family_management/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupMember extends StatefulWidget {
  static String familyId = "";
  SignupMember({super.key, required String iD}) {
    familyId = iD;
  }

  @override
  State<SignupMember> createState() => _SignupMemberState();
}

class _SignupMemberState extends State<SignupMember> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController emailController;
  String memberId = "";
  @override
  void initState() {
    nameController = TextEditingController();
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
          'Registration as Member',
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
                nameController, "Enter name", Icons.person, context),
            SizedBox(
              height: CompnentSize.getHeight(context, 0.015),
            ),
            UiHelper.customTextField(
                phoneController, "Phone number", Icons.phone, context),
            SizedBox(
              height: CompnentSize.getHeight(context, 0.025),
            ),
            UiHelper.customTextField(
                emailController, "Email", Icons.email, context),
            SizedBox(
              height: CompnentSize.getHeight(context, 0.025),
            ),
            UiHelper.customButton(() async {
              if (await checkUser()) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("This user already exists!"),
                      );
                    });
              } else {
                signUp();
              }
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
                    Get.off(() => LoginMember(SignupMember.familyId));
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
    if (nameController.text.trim() != "" &&
        emailController.text.trim() != "" &&
        phoneController.text.trim() != "") {
      var response = await MemberCrud.addMember(
          familyId: SignupMember.familyId,
          name: nameController.text.trim(),
          phoneNum: phoneController.text.trim(),
          email: emailController.text.trim(),
          isHead: false);
      if (response.code != 200) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(response.message.toString()),
              );
            });
      } else {
        memberId = response.id.toString();
        Get.off(
            () => Home(familyId: SignupMember.familyId, memberId: memberId));
      }
    }
  }

  Future<bool> checkUser() async {
    return await MemberCrud.checkMember(
        familyId: SignupMember.familyId,
        phoneNum: phoneController.text.trim(),
        email: emailController.text.trim());
  }
}
