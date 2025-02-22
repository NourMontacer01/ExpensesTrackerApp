/*
-----------------------------------------------------------
### ChartBar Widget Documentation

#### **Purpose**:
The `ChartBar` widget is a visual representation of a single bar in a bar chart. 
It dynamically adjusts its height based on a given `fill` value, representing a proportion 
of the total height.

#### **Main Features**:
- Displays a bar with a height proportional to the `fill` value.
- Adapts colors based on the system's light or dark mode.
- Uses rounded corners at the top for better UI aesthetics.
- Supports responsiveness with `FractionallySizedBox`.

-----------------------------------------------------------
### **Widgets and Properties Used**:

1. **Expanded**  
   - Ensures that the `ChartBar` takes up equal space within a `Row` or `Flex` layout.
   - Prevents layout overflow by evenly distributing available space.

2. **Padding**  
   - Adds spacing around the bar to avoid UI crowding.
   - `EdgeInsets.symmetric(horizontal: 4)` → Adds 4 pixels of horizontal padding.

3. **FractionallySizedBox**  
   - Adjusts its height dynamically relative to its parent’s available space.
   - `heightFactor: fill` → The height is set as a percentage of the maximum height.

4. **DecoratedBox**  
   - Provides decoration, including color and rounded borders.
   - Uses `BoxDecoration` to customize the bar’s appearance.

5. **BoxDecoration**  
   - `shape: BoxShape.rectangle` → Defines the shape as a rectangle.
   - `borderRadius: BorderRadius.vertical(top: Radius.circular(8))`  
     → Rounds only the top corners for a smooth bar effect.
   - `color`  
     - Uses `Theme.of(context).colorScheme.primary.withOpacity(0.65)` in light mode.
     - Uses `Theme.of(context).colorScheme.secondary` in dark mode for visibility.

6. **MediaQuery**  
   - Determines if the system is in **dark mode** using:  
     `MediaQuery.of(context).platformBrightness == Brightness.dark`
   - Helps adapt UI elements for different themes dynamically.

-----------------------------------------------------------
*/

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar({super.key, required this.fill});

  /// The height factor for the bar, ranging from 0.0 (empty) to 1.0 (full).
  final double fill;

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FractionallySizedBox(
          heightFactor: fill,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              color:
                  isDarkMode
                      ? Theme.of(context).colorScheme.secondary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.65),
            ),
          ),
        ),
      ),
    );
  }
}
