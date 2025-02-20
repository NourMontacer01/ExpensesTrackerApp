// ====================================
//          EXPENSES CLASS
// ====================================
// 1. This is the main screen where the expense list is displayed.
// 2. It uses StatefulWidget to manage dynamic expense data.
// 3. The app bar contains an "Add" button to open a modal form for adding expenses.
// 4. The list of expenses is stored in `_registeredExpenses`.
// 5. `_openAddExpenseOverlay()` triggers a modal bottom sheet for adding a new expense.
// 6. `_addExpense(Expense expense)` adds a new expense to the list and updates the UI.
// 7. `_removeExpense(Expense expense)` removes an expense from the list and shows an undo option.
// 8. ExpensesList (a separate widget) is used to display expenses dynamically.
// 9. The app follows a clean UI with GoogleFonts for styling.
// 10. The `ScaffoldMessenger` is used to display a Snackbar when an expense is deleted.

import 'package:expensestrackerapp/widgets/expenses_list/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expensestrackerapp/model/expense.dart';
import 'package:expensestrackerapp/widgets/expenses_list/expenses_list.dart';
import 'package:google_fonts/google_fonts.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    // Dummy data to test the app
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

  /// Opens the modal bottom sheet to add a new expense.
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpense(onAddExpense: _addExpense);
      },
    );
  }

  /// Adds a new expense to the list.
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  /// Removes an expense with an Undo option.
  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });

    // Show Snackbar for Undo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${expense.name} removed'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.add(expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade700,
        title: Text(
          'Expenses List',
          style: GoogleFonts.openSans(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseOverlay,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ExpensesList(
              expenses: _registeredExpenses,
              onRemoveExpense: _removeExpense,
            ),
          ),
        ],
      ),
    );
  }
}
