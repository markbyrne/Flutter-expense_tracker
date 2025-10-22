import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();
const uuid = Uuid();

enum Category {food, travel, leisure, work, loan}

const categoryIcons = {
  Category.food : Icons.local_grocery_store_outlined,
  Category.leisure : Icons.sports_tennis,
  Category.loan : Icons.money_off,
  Category.travel : Icons.airplane_ticket,
  Category.work : Icons.work
};

class Expense {
  Expense({required this.title, required this.date, required this.amount, required this.category}) : uid = uuid.v4();

  final String uid;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return dateFormatter.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category) : expenses = allExpenses.where((expense) => expense.category == category).toList(); 

  double get totalExpenses {
    double sum = 0.0;

    for (final expense in expenses){
      sum += expense.amount;
    }

    return sum;
  }
}