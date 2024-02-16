import 'package:family_management/budget/add_expanse.dart';
import 'package:family_management/get_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBudget extends StatefulWidget {
  const HomeBudget({super.key});

  @override
  State<HomeBudget> createState() => _HomeBudgetState();
}

class _HomeBudgetState extends State<HomeBudget> {
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
              fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: Column(
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
                      '\$10,000',
                      style: TextStyle(
                        fontFamily: 'MooliBold',
                        fontSize: CompnentSize.getFontSize(context, 0.042),
                        color: CompnentSize.textColor,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: CompnentSize.getWidth(context, 0.05)),
                      IncomeExpenseIndicator(
                        label: 'Income',
                        amount: '+\$5,000',
                        icon: Icons.arrow_drop_down,
                        color: Colors.green,
                      ),
                      SizedBox(width: CompnentSize.getWidth(context, 0.3)),
                      IncomeExpenseIndicator(
                        label: 'Expense',
                        amount: '-\$3,000',
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
              child: ListView(
                children: <Widget>[
                  BudgetItemCard(
                    label: 'Food',
                    companyName: 'ABC Company',
                    date: '31-12',
                    time: '10:00 AM',
                    amount: '\$1,000',
                    icon: Icons.fastfood,
                    isIncome: true,
                  ),
                  BudgetItemCard(
                    label: 'Entertentment',
                    companyName: 'XYZ Company',
                    date: '16-02',
                    time: '2:00 PM',
                    amount: '\$2,000',
                    icon: Icons.home,
                    isIncome: false,
                  ),
                  BudgetItemCard(
                    label: 'Shopping',
                    companyName: 'PQR Company',
                    date: '12-12',
                    time: '4:00 PM',
                    amount: '\$500',
                    icon: Icons.directions_car,
                    isIncome: true,
                  ),
                  BudgetItemCard(
                    label: 'salary',
                    companyName: 'MNO Company',
                    date: '28-02',
                    time: '8:00 PM',
                    amount: '\$300',
                    icon: Icons.music_note,
                    isIncome: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade300,
        onPressed: () {
          Get.put(()=>AddExpanse());
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
  final IconData icon;
  final bool isIncome;

  BudgetItemCard({
    required this.label,
    required this.companyName,
    required this.date,
    required this.time,
    required this.amount,
    required this.icon,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
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
