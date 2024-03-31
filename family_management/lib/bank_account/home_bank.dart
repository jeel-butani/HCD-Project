import 'package:flutter/material.dart';

class HomeBankAccount extends StatefulWidget {
  static String familyId = "";
  static String memberId = "";
  HomeBankAccount({Key? key, required String familyId, required String memberId}) {
    HomeBankAccount.familyId = familyId;
    HomeBankAccount.memberId = memberId;
  }

  @override
  State<HomeBankAccount> createState() => _HomeBankAccountState();
}

class _HomeBankAccountState extends State<HomeBankAccount> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}