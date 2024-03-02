import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:family_management/model/transaction.dart';
import '../model/response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FetchTransaction {
  static Future<List<TransactionData>> fetchTransactions({
    required String familyId,
    required String memberId,
  }) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Family')
          .doc(familyId)
          .collection('members')
          .doc(memberId)
          .collection('transactions')
          .get();

      List<TransactionData> transactions = querySnapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        return TransactionData(
          amount: data['amount'] ?? 0.0,
          date: data['date'] ?? '',
          name: data['name'] ?? '',
          time: data['time'] ?? '',
          type: data['type'] ?? '',
          isExpense: data['isExpense'] ?? true, // Include isExpense, default to true if not found
        );
      }).toList();

      return transactions;
    } catch (e) {
      print('Error fetching transactions: $e');
      return [];
    }
  }
}
