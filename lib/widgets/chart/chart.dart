import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Chart extends StatelessWidget{
  final List<Expense> expenses;

  const Chart({required this.expenses, super.key});

  List<ExpenseBucket> get buckets {
    List<ExpenseBucket> buckets = [];

    for (final category in Category.values){
      buckets.add(ExpenseBucket.forCategory(expenses, category));
    }

    return buckets;
  }

  double get maxTotalExpense {
    return buckets.map((bucket) => bucket.totalExpenses).toList().reduce(max);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withValues(alpha: .3),
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        categoryIcons[bucket.category],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: .7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}