// ====================================
//          EXPENSE MODEL
// ====================================
// 1. This file defines the Expense class, which represents an individual expense item.
// 2. The `uuid` package is used to generate unique IDs for each expense.
// 3. The `intl` package is used to format dates using `DateFormat.yMd()`.
// 4. The `Category` enum defines different types of expense categories.
// 5. The `categoryIcons` map associates icons with expense categories for UI representation.
// 6. The `Expense` class contains:
//    - `id`: A unique identifier for each expense.
//    - `name`: The name or title of the expense.
//    - `amount`: The amount spent.
//    - `date`: The date of the expense.
//    - `category`: The category of the expense.
// 7. The `formattedDate` getter returns a formatted string representation of the date.
// 8. The constructor initializes the expense details and automatically generates a unique ID.

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

final formatter = DateFormat.yMd();

final uuid = Uuid();

enum Category { food, transport, shopping, entertainement, others }

const categoryIcons = {
  Category.food: Icons.fastfood,
  Category.transport: Icons.flight_takeoff,
  Category.shopping: Icons.shopping_cart,
  Category.entertainement: Icons.movie,
  Category.others: Icons.attach_money,
};

class Expense {
  Expense({
    required this.name,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String name;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}
