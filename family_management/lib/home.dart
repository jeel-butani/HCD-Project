import 'package:family_management/budget/home_budget.dart';
import 'package:family_management/get_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CompnentSize.background,
          title: Text(
            'Dashbord',
            style: TextStyle(
                fontFamily: 'MooliBold',
                color: CompnentSize.boldTextColor,
                fontWeight: FontWeight.w900),
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: GestureDetector(
                      onTap: () {
                        Get.off(() => HomeBudget());
                      },
                      child: Container(
                        width: CompnentSize.getWidth(context, 0.43),
                        height: CompnentSize.getHeight(context, 0.25),
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/budget.png'),
                            SizedBox(height: 8),
                            Text(
                              "Budget",
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'MooliBold',
                                color: CompnentSize.background,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      width: CompnentSize.getWidth(context, 0.43),
                      height: CompnentSize.getHeight(context, 0.25),
                      decoration: BoxDecoration(
                        color: CompnentSize.background,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}