/*
-----------------------------------------------------------
### Chart Widget Documentation

#### **Purpose**:
The `Chart` widget visually represents categorized expenses using bars and corresponding icons.
It calculates expense totals for each category and normalizes them to fit within the available space.

#### **Main Features**:
- Categorizes expenses into predefined categories.
- Dynamically determines the maximum expense value to scale bars accordingly.
- Uses `ChartBar` to display each category’s proportion.
- Adapts colors and appearance based on light/dark mode.

-----------------------------------------------------------
### **Additional Widgets and Properties Used**:

1. **ExpenseBucket**  
   - Groups expenses based on their category.
   - `forCategory(expenses, Category.food)` → Creates a bucket for each category.

2. **maxTotalExpense**  
   - Determines the highest expense among all categories.
   - Used to normalize the height of the bars.

3. **Container**  
   - Provides the chart's base structure.
   - Uses `margin` and `padding` for spacing.
   - `decoration` applies a **gradient background** for visual appeal.

4. **LinearGradient**  
   - Creates a fading effect from **primary color** to **transparent**.
   - `begin: Alignment.bottomCenter` → Starts color at the bottom.
   - `end: Alignment.topCenter` → Fades towards the top.

5. **Row with Icons**  
   - Displays icons representing each category.
   - Icons adapt their color based on **light/dark mode**.

6. **Looping with `for` and `map()`**  
   - Uses `for (final bucket in buckets)` inside a `Row` to create bars dynamically.
   - Uses `.map().toList()` to generate icons for each category.

-----------------------------------------------------------
*/

import 'package:flutter/material.dart';
import 'package:expensestrackerapp/model/expense.dart';
import 'package:expensestrackerapp/widgets/chart/chart_bar.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  /// List of all expenses to be categorized and displayed.
  final List<Expense> expenses;

  /// Groups expenses into different categories.
  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.shopping),
      ExpenseBucket.forCategory(expenses, Category.transport),
      ExpenseBucket.forCategory(expenses, Category.entertainement),
      ExpenseBucket.forCategory(expenses, Category.others),
    ];
  }

  /// Computes the maximum total expense to scale bar heights correctly.
  double get maxTotalExpense {
    double maxTotalExpense = 0;
    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }
    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.6),
            Theme.of(context).colorScheme.primary.withOpacity(0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  ChartBar(
                    fill:
                        bucket.totalExpenses == 0
                            ? 0
                            : bucket.totalExpenses / maxTotalExpense,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children:
                buckets
                    .map(
                      (bucket) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            categoryIcons[bucket.category],
                            color:
                                isDarkMode
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(
                                      context,
                                    ).colorScheme.primary.withOpacity(0.7),
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
        ],
      ),
    );
  }
}
