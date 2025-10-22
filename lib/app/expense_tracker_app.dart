import 'package:expense_tracker/themes/main_theme.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';


class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense Tracker',
      darkTheme: MainTheme.dark,
      theme: MainTheme.light,
      themeMode: ThemeMode.system,
      home: Expenses(),
    );
  }
}
