// ====================================
//           NEW EXPENSE WIDGET
// ====================================
// 1. This widget allows users to add a new expense to the list.
// 2. It contains form fields for the title, amount, date, and category of the expense.
// 3. The form is validated when the user submits it, checking for valid input (non-empty fields, positive amount, selected date, and category).
// 4. The `_submitdata` method collects the input values, validates them, and then calls the `onAddExpense` function passed from the parent widget.
// 5. If any input is invalid, an AlertDialog is shown to inform the user of the error.
// 6. The widget includes a date picker, allowing the user to select the date of the expense.
// 7. The `DropdownButton` widget is used for selecting the category from predefined categories.
// 8. The widget also includes buttons for discarding the entry or confirming the new expense.
// 9. The `dispose` method is overridden to clean up controllers when the widget is disposed of.
// 10. The `onAddExpense` function is called when the user confirms the new expense, passing the newly created `Expense` object.

import 'package:flutter/material.dart';
import 'package:expensestrackerapp/model/expense.dart'; // Import the expense.dart file

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // Controllers for text fields
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;

  void _submitdata() {
    final entredamount = double.tryParse(_amountController.text);
    final amountisInvalid = entredamount == null || entredamount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountisInvalid ||
        _selectedDate == null ||
        _selectedCategory == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Invalid Input'),
              content: Text(
                'Please enter a valid title,amount, select a date and category',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text('Okay'),
                ),
              ],
            ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        name: _titleController.text,
        amount: entredamount,
        date: _selectedDate!,
        category: _selectedCategory!,
      ),
    );
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    // Free memory when widget is disposed
    _categoryController.dispose();
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  // Function to show a date picker
  Future<void> _pickDate() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);
    final lastdate = DateTime(now.year + 1, now.month, now.day);
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstdate,
      lastDate: lastdate,
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          // Name input field
          TextField(
            controller: _titleController,
            maxLength: 20,
            decoration: const InputDecoration(labelText: 'Name'),
          ),

          // Row for amount and date selection
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    prefixText: '\$',
                    prefixStyle: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No date selected'
                            : formatter.format(
                              _selectedDate!,
                            ), // Use the imported formatter here
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_month_outlined),
                      onPressed: _pickDate,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Category input field
          DropdownButton<Category>(
            value: _selectedCategory,
            hint: const Text('Category'), // Default text before selection
            isExpanded: true, // Ensures it takes full width
            items:
                Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
            onChanged: (Category? value) {
              setState(() {
                _selectedCategory = value; // Update selected category
              });
            },
          ),
          const SizedBox(height: 90),

          // Action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.cancel, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
                label: const Text('Discard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
              const SizedBox(width: 20),
              ElevatedButton.icon(
                icon: const Icon(Icons.save, color: Colors.white),
                onPressed: _submitdata,
                label: const Text('Confirm'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
