import 'package:flutter/material.dart';
import 'package:property_app/screens/custom_nav_bar/home_screen/tabs/tab_widgets/properties_page.dart';

class BudgetTab extends StatelessWidget {
  const BudgetTab({super.key});

  List<BudgetItem> generateBudgetItems(BuildContext context) {
    List<BudgetItem> budgetItems = [];
    int increment = 1000000;
    int maxBudget = 40000000;

    for (int budget = increment; budget <= maxBudget; budget += increment) {
      String budgetTitle;
      if (budget >= 10000000) {
        double croreValue = budget / 10000000;
        budgetTitle = "Above ${croreValue.toStringAsFixed(2)} crore";
      } else {
        int lakhValue = budget ~/ 100000;
        budgetTitle = "Above $lakhValue lakh";
      }

      budgetItems.add(
        BudgetItem(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TPropertiesPage(
                  selectedbudget: budget,
                  pageTitle: budgetTitle,
                ),
              ),
            );
          },
          budgetTitle: budgetTitle,
        ),
      );
    }

    return budgetItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
        child: GridView.count(
          scrollDirection: Axis.horizontal,
          crossAxisCount: 4,
          crossAxisSpacing: 0.0,
          childAspectRatio: 0.50,
          mainAxisSpacing: 10.0,
          children: generateBudgetItems(context),
        ),
      ),
    );
  }
}

class BudgetItem extends StatelessWidget {
  final String budgetTitle;
  final Function onTap;
  const BudgetItem({
    required this.onTap,
    super.key,
    required this.budgetTitle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap as VoidCallback?,
      child: Text(
        budgetTitle,
        style: const TextStyle(
          color: Color.fromARGB(255, 129, 125, 125),
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
