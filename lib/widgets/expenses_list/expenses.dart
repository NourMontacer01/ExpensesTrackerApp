// ====================================
//          EXPENSES CLASS
// ====================================
// 1. This is the main screen where the expense list is displayed.
// 2. It uses StatefulWidget to manage dynamic expense data.
// 3. The app bar contains an "Add" button to open a modal form for adding expenses.
// 4. The list of expenses is stored in _registeredExpenses.
// 5. _openAddExpenseOverlay() triggers a modal bottom sheet for adding a new expense.
// 6. _addExpense(Expense expense) adds a new expense to the list and updates the UI.
// 7. _removeExpense(Expense expense) removes an expense from the list and shows an undo option.
// 8. ExpensesList (a separate widget) is used to display expenses dynamically.
// 9. The app follows a clean UI with GoogleFonts for styling.
// 10. The ScaffoldMessenger is used to display a Snackbar when an expense is deleted.

import 'package:flutter/material.dart';
import 'package:expensestrackerapp/model/expense.dart';
import 'package:expensestrackerapp/widgets/expenses_list/new_expense.dart';
import 'package:expensestrackerapp/widgets/expenses_list/expenses_list.dart';
import 'package:expensestrackerapp/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  _ExpensesState createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _expenses = [
    Expense(
      name: 'Groceries',
      amount: 100.0,
      date: DateTime.parse('2021-10-10'),
      category: Category.food,
    ),
    Expense(
      name: 'Transport',
      amount: 50.0,
      date: DateTime.parse('2021-10-10'),
      category: Category.transport,
    ),
    Expense(
      name: 'Shopping',
      amount: 200.0,
      date: DateTime.parse('2024-06-15'),
      category: Category.shopping,
    ),
    Expense(
      name: 'Entertainment',
      amount: 150.0,
      date: DateTime.parse('2025-02-28'),
      category: Category.entertainement,
    ),
    Expense(
      name: 'Others',
      amount: 300.0,
      date: DateTime.parse('2022-09-15'),
      category: Category.others,
    ),
  ];

  void _addExpense(Expense expense) {
    setState(() => _expenses.add(expense));
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _expenses.indexOf(expense);
    setState(() => _expenses.remove(expense));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${expense.name} removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() => _expenses.insert(expenseIndex, expense));
          },
        ),
      ),
    );
  }

  void _openNewExpenseModal() {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final theme = Theme.of(context);
    Widget mainContent = const Center(child: Text('No expenses added yet!'));

    if (_expenses.isNotEmpty) {
      mainContent = ExpensesList(expenses: _expenses, onRemove: _removeExpense);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses Tracker'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openNewExpenseModal,
          ),
        ],
      ),
      body:
          width < 600
              ? Column(
                children: [
                  Chart(expenses: _expenses),
                  Expanded(child: mainContent),
                ],
              )
              : Row(
                children: [
                  Expanded(child: mainContent),
                  Expanded(child: Chart(expenses: _expenses)),
                ],
              ),
    );
  }
}
