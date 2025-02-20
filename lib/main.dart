/*
-----------------------------------------------------------
### Documentation for Widgets and Properties Used:

1. **MaterialApp**
   - The root widget of the Flutter app.
   - `theme: ThemeData(useMaterial3: true)` → Enables Material 3 design, providing an updated look and feel.

2. **ThemeData**
   - Defines the visual theme of the app.
   - `useMaterial3: true` → Activates Material 3, offering enhanced UI components and better animations.

3. **Expenses**
   - The home screen of the application.
   - Imported from `expenses_list/expenses.dart`, responsible for managing expense-related features.

### Tips for Improvement:
- Consider adding a `debugShowCheckedModeBanner: false` in `MaterialApp` to remove the debug banner during development.
- You can customize the theme further by defining colors, text styles, and other UI components.

-----------------------------------------------------------
*/
import 'package:flutter/material.dart';
import 'package:expensestrackerapp/widgets/expenses_list/expenses.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true, // Enables Material 3 for modern UI components
      ),
      home: Expenses(), // Main screen of the application
    ),
  );
}
