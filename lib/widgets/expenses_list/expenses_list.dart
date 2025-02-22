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
  final List<Expense> expenses;
  final void Function(Expense) onRemove;

  const ExpensesList({Key? key, required this.expenses, required this.onRemove})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder:
          (ctx, index) => Dismissible(
            key: ValueKey(expenses[index].id),
            background: Container(
              color: Theme.of(context).colorScheme.error,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) => onRemove(expenses[index]),
            child: ExpenseItem(expense: expenses[index]),
          ),
    );
  }
}
