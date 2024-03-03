import 'package:family_management/budget/add_expanse.dart';
import 'package:family_management/firebase_api/fetch_transaction_api.dart';
import 'package:family_management/get_size.dart';
import 'package:family_management/model/transaction.dart';
import 'package:family_management/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBudget extends StatefulWidget {
  static String familyId = "";
  static String memberId = "";

  HomeBudget({super.key, required String familyId, required String memberId}) {
    HomeBudget.familyId = familyId;
    HomeBudget.memberId = memberId;
  }

  @override
  State<HomeBudget> createState() => _HomeBudgetState();
}

class _HomeBudgetState extends State<HomeBudget> {
  late Future<List<TransactionData>> _transactionDataFuture;

  @override
  void initState() {
    super.initState();
    _transactionDataFuture = FetchTransaction.fetchTransactions(
      familyId: HomeBudget.familyId,
      memberId: HomeBudget.memberId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompnentSize.background,
        title: Text(
          'Budget',
          style: TextStyle(
            fontFamily: 'MooliBold',
            color: CompnentSize.boldTextColor,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<TransactionData>>(
        future: _transactionDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            double totalIncome = 0;
            double totalExpense = 0;

            snapshot.data!.forEach((transaction) {
              if (transaction.isExpense) {
                totalExpense += transaction.amount;
              } else {
                totalIncome += transaction.amount;
              }
            });

            double totalBalance = totalIncome - totalExpense;

            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 2.0,
                    color: Colors.blue.shade100,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                            'Total balance',
                            style: TextStyle(
                              fontFamily: 'MooliBold',
                              fontSize: CompnentSize.getFontSize(context, 0.03),
                              color: CompnentSize.textColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '\$$totalBalance',
                            style: TextStyle(
                              fontFamily: 'MooliBold',
                              fontSize:
                                  CompnentSize.getFontSize(context, 0.042),
                              color:
                                  totalBalance >= 0 ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                                width: CompnentSize.getWidth(context, 0.05)),
                            IncomeExpenseIndicator(
                              label: 'Income',
                              amount: '\$$totalIncome',
                              icon: Icons.arrow_drop_down,
                              color: Colors.green,
                            ),
                            SizedBox(
                                width: CompnentSize.getWidth(context, 0.3)),
                            IncomeExpenseIndicator(
                              label: 'Expense',
                              amount: '\$$totalExpense',
                              icon: Icons.arrow_drop_up,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: CompnentSize.getHeight(context, 0.01),
                        )
                      ],
                    ),
                  ),
                ),
                Text(
                  "Transactions",
                  style: TextStyle(
                    fontFamily: 'MooliBold',
                    color: CompnentSize.textColor,
                    fontSize: CompnentSize.getFontSize(context, 0.035),
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Expanded(
                  child: FutureBuilder<List<TransactionData>>(
                    future: _transactionDataFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              TransactionData transaction =
                                  snapshot.data![index];
                              return BudgetItemCard(
                                label: transaction.name,
                                companyName: transaction.type,
                                date: transaction.date,
                                time: transaction.time,
                                amount: '\$${transaction.amount}',
                                isIncome: !transaction.isExpense,
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: Text('No transactions available'),
                        );
                      }
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade300,
        onPressed: () {
          Get.put(() => AddExpanse(
                familyId: HomeBudget.familyId,
                memberId: HomeBudget.memberId,
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class BudgetItemCard extends StatelessWidget {
  final String label;
  final String companyName;
  final String date;
  final String time;
  final String amount;
  final bool isIncome;

  BudgetItemCard({
    required this.label,
    required this.companyName,
    required this.date,
    required this.time,
    required this.amount,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          label,
          style: TextStyle(
            fontFamily: 'MooliBold',
            fontSize: CompnentSize.getFontSize(context, 0.03),
            color: CompnentSize.textColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        subtitle: Text(
          '$companyName   • $date    • $time',
          style: TextStyle(
            fontFamily: 'MooliBold',
            fontSize: CompnentSize.getFontSize(context, 0.026),
            color: CompnentSize.textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isIncome ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: isIncome ? Colors.green : Colors.red,
            ),
            Text(
              amount,
              style: TextStyle(
                fontFamily: 'MooliBold',
                fontSize: CompnentSize.getFontSize(context, 0.03),
                color: isIncome ? Colors.green : Colors.red,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IncomeExpenseIndicator extends StatelessWidget {
  final String label;
  final String amount;
  final IconData icon;
  final Color color;

  IncomeExpenseIndicator(
      {required this.label,
      required this.amount,
      required this.icon,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'MooliBold',
                fontSize: CompnentSize.getFontSize(context, 0.03),
                color: CompnentSize.textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Row(
          children: [
            SizedBox(
              width: 16,
            ),
            Text(
              amount,
              style: TextStyle(
                fontFamily: 'MooliBold',
                fontSize: CompnentSize.getFontSize(context, 0.035),
                color: CompnentSize.textColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
