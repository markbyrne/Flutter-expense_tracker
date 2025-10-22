import 'package:expense_tracker/utils/constants.dart';
import 'package:expense_tracker/utils/utilities.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense_modal/new_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Car Loan',
      date: DateTime(2025, 10, 1),
      amount: 450.00,
      category: Category.loan,
    ),
    Expense(
      title: 'Groceries',
      date: DateTime(2025, 10, 3),
      amount: 120.00,
      category: Category.food,
    ),
    Expense(
      title: 'Netflix',
      date: DateTime(2025, 10, 1),
      amount: 12.00,
      category: Category.leisure,
    ),
  ];

  List<Expense> get registeredExpenses {
    return _registeredExpenses;
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      constraints:BoxConstraints.expand(),
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo', 
          key: Key('undo-delete-expense-button'),
          onPressed: (){
            setState(() {
              _registeredExpenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final renderPortrait = screenWidth < Constants.kResponsiveThreshold;

    List<Widget> mainContent = [
      renderPortrait ? Chart(expenses: _registeredExpenses) : Expanded(child: Chart(expenses: _registeredExpenses)),
      Expanded(
        child: _registeredExpenses.isNotEmpty 
          ? ExpensesList(
              expenses: _registeredExpenses, 
              onRemoveExpense: _removeExpense,
            )
          : Center(child: Text('No Expenses Logged.'),)
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: Icon(
              Utilities.isIOS
              ? CupertinoIcons.add
              : Icons.add, 
              key: Key('add-new-expense-button'),
            ),
          ),
        ],
      ),
      body: SafeArea(child: renderPortrait ? Column(children: mainContent,) : Row(children: mainContent,) )
    );
  }
}
