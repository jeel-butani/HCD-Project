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
        title: Text("Overview"),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Accounts"),
              ],
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Jeel"),
                      Text("-₹300.00"),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text("This month"),
                            SizedBox(height: 8.0),
                            Text("Income"),
                            Text("₹70.00"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("Kotak Bank"),
                            SizedBox(height: 8.0),
                            Text("₹0.00"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("Wallet"),
                            SizedBox(height: 8.0),
                            Text("₹0.00"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Home"),
                      Text("19°"),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text("Accounts"),
                            SizedBox(height: 8.0),
                            Text("Expense"),
                            Text("₹300.00"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text("Debts"),
                            SizedBox(height: 8.0),
                            Text("ⒸVO 4G+ A"),
                            Text("₹10.00"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
