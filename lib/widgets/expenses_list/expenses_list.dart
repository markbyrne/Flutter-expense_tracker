import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget{
  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  const ExpensesList({required this.expenses, required this.onRemoveExpense, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(top: 10),
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        background: Container(
          color: Theme.of(context).colorScheme.errorContainer,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete),
            ],
          ),
        ),
        onDismissed: (direction){
          onRemoveExpense(expenses[index]);
        },
        child: ExpenseItem(expense: expenses[index])
      )
    );
  }
}