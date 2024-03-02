class TransactionData {
  final double amount;
  final String date;
  final String name;
  final String time;
  final String type;
  final bool isExpense; 

  TransactionData({
    required this.amount,
    required this.date,
    required this.name,
    required this.time,
    required this.type,
    required this.isExpense, 
  });

  factory TransactionData.fromMap(Map<String, dynamic> map) {
    return TransactionData(
      amount: map['amount'] ?? 0.0,
      date: map['date'] ?? '',
      name: map['name'] ?? '',
      time: map['time'] ?? '',
      type: map['type'] ?? '',
      isExpense: map['isExpense'] ?? true, // Include isExpense in the factory method
    );
  }
}
