// ====================================
//          EXPENSES LIST WIDGET
// ====================================
// 1. This widget displays a list of expense items.
// 2. It uses a `ListView.builder` to dynamically create the list.
// 3. The `Dismissible` widget allows users to swipe to remove an expense item from the list.
// 4. The `onRemoveExpense` function is passed as a callback to handle the removal of an expense.
// 5. The `ExpenseItem` widget is used to display each individual expense item.
// 6. The `key: ValueKey(expenses[index])` ensures that each item has a unique key for proper state management.
// 7. The widget is wrapped in a `Scaffold` which provides the basic layout structure.

import 'package:expensestrackerapp/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expensestrackerapp/model/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses; // List of expenses to display
  final void Function(Expense expense)
  onRemoveExpense; // Callback function to remove an expense

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: expenses.length, // Number of items in the list
        itemBuilder:
            (context, index) => Dismissible(
              key: ValueKey(
                expenses[index],
              ), // Unique key for each dismissible item
              onDismissed: (direction) {
                onRemoveExpense(
                  expenses[index],
                ); // Calls the remove function when swiped away
              },
              child: ExpenseItem(expenses[index]), // Displays the expense item
            ),
      ),
    );
  }
}
