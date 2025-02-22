import 'package:flutter/material.dart';
import 'package:expensestrackerapp/widgets/expenses_list/expenses.dart';
import 'package:google_fonts/google_fonts.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 21, 255, 0),
);
var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 10, 2, 116),
  brightness: Brightness.dark,
);

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false, // Removes debug banner
      themeMode: ThemeMode.system, // Uses system theme mode
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: kColorScheme,

        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          titleLarge: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Color.fromARGB(255, 37, 37, 37), // Title text in white
          ),
          bodyLarge: const TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 37, 37, 37), // Title text in white
          ),
          bodyMedium: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 37, 37, 37), // Title text in white
          ),
        ),

        appBarTheme: AppBarTheme(
          backgroundColor: kColorScheme.primary,
          foregroundColor: kColorScheme.onPrimary,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: const Color.fromARGB(
            255,
            225,
            184,
            246,
          ), // Card background color
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
            foregroundColor: kColorScheme.onPrimaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          titleLarge: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white, // Title text in white
          ),
          bodyLarge: const TextStyle(
            fontSize: 16,
            color: Colors.white, // Normal text in white
          ),
          bodyMedium: const TextStyle(
            fontSize: 14,
            color: Colors.white, // Medium-sized text in white
          ),
        ),
        cardTheme: CardTheme(
          color: kDarkColorScheme.surface, // Card background color
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: kDarkColorScheme.primary,
          foregroundColor: kDarkColorScheme.onPrimary,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: Expenses(),
    ),
  );
}
