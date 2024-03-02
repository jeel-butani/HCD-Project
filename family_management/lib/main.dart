import 'package:family_management/budget/add_expanse.dart';
import 'package:family_management/budget/home_budget.dart';
import 'package:family_management/firebase_options.dart';
import 'package:family_management/signup_family.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
  init();
}

void init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddExpanse(
        familyId: 'TBmPjzN6DepMg6PJmnAT',
        memberId: 'vh7NdX3kI3jFG8rwl8fC',
      ),
    );
  }
}
