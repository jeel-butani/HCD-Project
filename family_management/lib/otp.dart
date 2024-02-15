// import 'package:family_management/get_size.dart';
// import 'package:family_management/login_member.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class OtpVerify extends StatefulWidget {
//   const OtpVerify({super.key});

//   @override
//   State<OtpVerify> createState() => _OtpVerifyState();
// }

// class _OtpVerifyState extends State<OtpVerify> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: CompnentSize.boldTextColor,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Verification',
//                 style: TextStyle(
//                   fontFamily: 'Mooli',
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Text(
//                 "Enter your OTP code number",
//                 style: TextStyle(
//                   fontFamily: 'Mooli',
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black38,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 28,
//               ),
//               Container(
//                 padding: EdgeInsets.all(28),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         _textFieldOTP(first: true, last: false),
//                         _textFieldOTP(first: false, last: false),
//                         _textFieldOTP(first: false, last: false),
//                         _textFieldOTP(first: false, last: true),
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 25,
//                     ),
//                     Container(
//                       width: double.infinity,
//                       child: SizedBox(
//                         height: CompnentSize.getHeight(context, 0.058),
//                         width: CompnentSize.getWidth(context, 0.5),
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                               backgroundColor: CompnentSize.background),
//                           onPressed: () {
//                             Get.off(() => LoginMember());
//                           },
//                           child: Text(
//                             "Verify",
//                             style: TextStyle(
//                               fontFamily: 'MooliBold',
//                               fontSize: CompnentSize.getFontSize(context, 0.04),
//                               color: CompnentSize.boldTextColor,
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 18,
//               ),
//               const Text(
//                 "Didn't you receive any code?",
//                 style: TextStyle(
//                   fontFamily: 'Mooli',
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black38,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 18,
//               ),
//               Text(
//                 "Resend New Code",
//                 style: TextStyle(
//                   fontFamily: 'Mooli',
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: CompnentSize.background,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _textFieldOTP({required bool first, last}) {
//     return SizedBox(
//       height: 58,
//       child: AspectRatio(
//         aspectRatio: 1.0,
//         child: TextField(
//           autofocus: true,
//           onChanged: (value) {
//             if (value.length == 1 && last == false) {
//               FocusScope.of(context).nextFocus();
//             }
//             if (value.isEmpty && first == false) {
//               FocusScope.of(context).previousFocus();
//             }
//           },
//           showCursor: false,
//           readOnly: false,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             fontFamily: 'Mooli',
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//           keyboardType: TextInputType.number,
//           maxLength: 1,
//           decoration: InputDecoration(
//             counter: const Offstage(),
//             enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(width: 2, color: Colors.black12),
//                 borderRadius: BorderRadius.circular(12)),
//             focusedBorder: OutlineInputBorder(
//                 borderSide:
//                     BorderSide(width: 2, color: CompnentSize.background),
//                 borderRadius: BorderRadius.circular(12)),
//           ),
//         ),
//       ),
//     );
//   }
// }
