/*
### Documentation for Widgets and Properties Used:

1. **Card**  
   - Provides a container with elevation to create a shadow effect, improving UI aesthetics.
   - `elevation: 5` → Adds a slight shadow for depth.
   - `color: Color.fromARGB(255, 137, 193, 250)` → Sets the background color of the card.

2. **Padding**  
   - Adds internal spacing within the card.  
   - `EdgeInsets.symmetric(horizontal: 10, vertical: 5)` → Provides horizontal and vertical padding.

3. **Column**  
   - Arranges child widgets in a vertical layout.
   - `crossAxisAlignment: CrossAxisAlignment.start` → Aligns all child widgets to the left.

4. **Text (expense.name)**  
   - Displays the expense name.
   - `TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)` → Sets text size, bold style, and white color.
   - `overflow: TextOverflow.ellipsis` → Prevents overflow by truncating text if it's too long.

5. **SizedBox**  
   - Provides spacing between widgets.
   - `SizedBox(height: 5)` → Creates a 5-pixel space.

6. **Row**  
   - Arranges child widgets in a horizontal layout.

7. **Text (amount and date)**  
   - Displays the formatted amount and date.
   - `'\$${expense.amount.toStringAsFixed(2)}'` → Formats the amount to 2 decimal places.
   - `TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)` → Styles the text.

8. **Icon**  
   - Displays a money icon (`Icons.money`).
   - `color: Colors.white` → Matches the text color.

9. **Spacer**  
   - Pushes the date to the right by occupying available space in the row.

-----------------------------------------------------------
*/

import 'package:expensestrackerapp/model/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: theme.cardColor,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primary,
          child: Icon(categoryIcons[expense.category], color: Colors.white),
        ),
        title: Text(
          expense.name,
          style: theme.textTheme.titleMedium?.copyWith(
            overflow: TextOverflow.ellipsis,
            color: theme.colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          '\$${expense.amount.toStringAsFixed(2)} - ${expense.formattedDate}',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
