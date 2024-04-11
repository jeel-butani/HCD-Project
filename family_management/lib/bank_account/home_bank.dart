import 'package:family_management/bank_account/add_bank_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeBankAccount extends StatefulWidget {
  static String familyId = "";
  static String memberId = "";
  HomeBankAccount(
      {Key? key, required String familyId, required String memberId}) {
    HomeBankAccount.familyId = familyId;
    HomeBankAccount.memberId = memberId;
  }

  @override
  State<HomeBankAccount> createState() => _HomeBankAccountState();
}

class _HomeBankAccountState extends State<HomeBankAccount> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Account List'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('Family/${HomeBankAccount.familyId}/bankInfo')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No bank accounts found'));
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var bankInfo = snapshot.data!.docs[index];
              return GestureDetector(
                onTap: () {
                  _showBankInfoDialog(context, bankInfo);
                },
                child: Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(bankInfo['bankName']),
                    subtitle: Text(bankInfo['accountType']),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade300,
        onPressed: () {
          Get.to(() => BankInfoPage(
                familyId: HomeBankAccount.familyId,
                memberId: HomeBankAccount.memberId,
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showBankInfoDialog(BuildContext context, DocumentSnapshot bankInfo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Bank Account Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bank Name: ${bankInfo['bankName']}'),
              Text('Branch Name: ${bankInfo['branchName']}'),
              Text('IFSC Code: ${bankInfo['ifscCode']}'),
              Text('Owner Name: ${bankInfo['ownerName']}'),
              Text('Account Name: ${bankInfo['accountName']}'),
              Text('Email: ${bankInfo['email']}'),
              Text('Phone Number: ${bankInfo['phoneNumber']}'),
              Text('Account Type: ${bankInfo['accountType']}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
    
    
    
//     Scaffold(
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blue.shade300,
//         onPressed: () {
//           Get.to(() => BankInfoPage(
//                 familyId: HomeBankAccount.familyId,
//                 memberId: HomeBankAccount.memberId,
//               ));
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
