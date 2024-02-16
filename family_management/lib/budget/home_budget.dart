import 'package:family_management/get_size.dart';
import 'package:flutter/material.dart';

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
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.attach_money),
                    title: Text('Total Budget'),
                    subtitle: Text('\$10,000'),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IncomeExpenseIndicator(
                        label: 'Income',
                        amount: '\$5,000',
                        icon: Icons.arrow_drop_up,
                        color: Colors.green,
                      ),
                      IncomeExpenseIndicator(
                        label: 'Expense',
                        amount: '\$3,000',
                        icon: Icons.arrow_drop_down,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                BudgetItemCard(
                  title: 'Food',
                  amount: '\$1,000',
                  icon: Icons.fastfood,
                ),
                BudgetItemCard(
                  title: 'Rent',
                  amount: '\$2,000',
                  icon: Icons.home,
                ),
                BudgetItemCard(
                  title: 'Transportation',
                  amount: '\$500',
                  icon: Icons.directions_car,
                ),
                BudgetItemCard(
                  title: 'Entertainment',
                  amount: '\$300',
                  icon: Icons.music_note,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle floating action button tap
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class BudgetItemCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;

  BudgetItemCard(
      {required this.title, required this.amount, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(amount),
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
        Icon(
          icon,
          color: color,
        ),
        SizedBox(height: 8.0),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          amount,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
