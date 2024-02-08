import 'package:family_management/get_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiHelper {
  static customTextField(TextEditingController controller, String hint,
      IconData iconData, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontFamily: 'Mooli',
            color: Colors.grey[700],
            fontSize: CompnentSize.getFontSize(context, 0.045),
          ),
          suffix: Icon(iconData),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }

  static customButton(VoidCallback callback, String txt, BuildContext context) {
    return SizedBox(
      height: CompnentSize.getHeight(context, 0.05),
      width: CompnentSize.getWidth(context, 0.5),
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(backgroundColor: CompnentSize.background),
        onPressed: () {
          callback();
        },
        child: Text(
          txt,
          style: TextStyle(
            fontFamily: 'MooliBold',
            fontSize: CompnentSize.getFontSize(context, 0.04),
            color: CompnentSize.boldTextColor,
          ),
        ),
      ),
    );
  }

  static showMyDialog(BuildContext context, String msg) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  msg,
                  style: TextStyle(),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(
                  fontFamily: 'MooliBold',
                  fontSize: CompnentSize.getFontSize(context, 0.04),
                  color: CompnentSize.background,
                ),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
