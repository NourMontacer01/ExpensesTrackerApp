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
// 11. The `showDialog` method displays an alert dialog with a platform-specific design (Material or Cupertino) based on the platform the app is running on.
// 12. The `LayoutBuilder` widget is used to adjust the layout based on the available space, ensuring the widget behaves as expected across different screen sizes and orientations.
// 13. The `Platform` class is used to check the platform the app is running on and display the appropriate dialog based on the platform.
// 14. The `showCupertinoDialog` method is used to display an iOS-styled dialog when the app is running on an iOS device.
// 15. The `Expanded` widget is used to ensure that widgets behave as expected across different screen sizes and orientations.
// 16. The `formatter` object is used to format the selected date in the date picker.
// 17. The `keyboardSpace` variable is used to adjust the padding of the widget based on the keyboard space to prevent the keyboard from overlapping the form fields.
// 18. The `SizedBox` and `SingleChildScrollView` widgets are used to ensure that the widget is scrollable when the keyboard is open.
// 19. The `Padding` widget is used to add padding to the widget to ensure proper spacing between the form fields and buttons.
// 20. The `TextField` widget is used to create input fields for the title and amount of the expense.
// 21. The `Row` widget is used to display the amount input field and the date picker button side by side.
// 22. The `IconButton` widget is used to create a button that opens the date picker when pressed.
// 23. The `DropdownButton` widget is used to create a dropdown menu for selecting the category of the expense.
// 24. The `TextButton` and `ElevatedButton` widgets are used to create buttons for canceling or saving the new expense.
// 25. The `Text` widget is used to display the selected date or a placeholder if no date is selected.
/* Building adaptive apps in Flutter means your UI can adjust to the platform on which it’s being displayed, whether it's Android or iOS. You can use the same widgets and styles across platforms, but sometimes, minor tweaks are necessary.

For example, Flutter automatically centers the title on iOS (default behavior), but you can customize it by setting centerTitle: false. The font may differ too, as Flutter uses a different default font on iOS.

You may also want platform-specific UI elements, like using iOS-styled dialogs. Flutter provides the showCupertinoDialog() method to implement iOS-specific dialog styling. You can use CupertinoAlertDialog for this and adjust it with title, content, and actions parameters, just like the regular Material dialog.

To decide which dialog to show based on the platform, use the Platform class from Dart. It’s essential to import dart:io and check Platform.isIOS to display the appropriate dialog.

For layout adaptation, Flutter provides the LayoutBuilder widget. This widget listens to the available space and dynamically adjusts the layout, unlike MediaQuery, which focuses on screen size. It uses the constraints object to determine how much space the widget has and can adjust its layout accordingly.

For example, in a responsive layout, you could conditionally display widgets using an if statement based on available width, like adding a Row if the width is greater than 600px. This lets you position widgets side by side on larger screens and in a single column on smaller ones.

For text fields in a row, you might use Expanded to avoid constraint issues, ensuring that widgets behave as expected across different screen sizes and orientations.

By using LayoutBuilder and Platform checks, you can create adaptive, platform-specific UIs while maintaining a consistent app experience across Android and iOS. */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expensestrackerapp/model/expense.dart'; // Import the expense.dart file
import 'dart:io';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) {
          return CupertinoAlertDialog(
            title: const Text('Invalid input'),
            content: const Text(
              'Please make sure a valid title, amount, date and category was entered.',
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text('Invalid input'),
              content: const Text(
                'Please make sure a valid title, amount, date and category was entered.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: const Text('Okay'),
                ),
              ],
            ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(
      _amountController.text,
    ); // tryParse('Hello') => null, tryParse('1.12') => 1.12
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      _showDialog();
      return;
    }

    widget.onAddExpense(
      Expense(
        name: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory!,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Title')),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixText: '\$ ',
                        label: Text('Amount'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'No date selected'
                              : formatter.format(_selectedDate!),
                        ),
                        IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(Icons.calendar_month),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    hint: Expanded(child: Text('Category')),

                    items:
                        Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category.name.toUpperCase()),
                              ),
                            )
                            .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                  const Spacer(),
                  const SizedBox(height: 20),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 200),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text('Save Expense'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
