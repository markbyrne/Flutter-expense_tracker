import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/utils/constants.dart';
import 'package:expense_tracker/utils/utilities.dart';
import 'package:expense_tracker/widgets/adaptive/adaptive_elevated_button.dart';
import 'package:expense_tracker/widgets/new_expense_modal/fields/amount_field.dart';
import 'package:expense_tracker/widgets/new_expense_modal/fields/category_select_field.dart';
import 'package:expense_tracker/widgets/new_expense_modal/fields/date_select_field.dart';
import 'package:expense_tracker/widgets/new_expense_modal/fields/title_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class NewExpense extends StatefulWidget {
  void Function(Expense expense) onAddExpense;

  NewExpense({required this.onAddExpense, super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final _datePickerWidget = DateSelectField(key: Key('new-expense-date-select-field'));
  final _categorySelectWidget = CategorySelectField(key: Key('new-expense-category-select-field'));

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _showDialog(List<String> errorMessages){
    if (Utilities.isIOS){
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          key: Key('new-expense-bad-input-dialog'),
          title: Text(
            'Invalid Input',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(errorMessages.join('\n'), ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              icon: Icon(Icons.check, key: Key('new-expense-bad-input-dialog-dismiss-button'),),
            ),
          ],
        ),
      );

    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          key: Key('new-expense-bad-input-dialog'),
          title: Text(
            'Invalid Input',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          content: Text(errorMessages.join('\n')),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              icon: Icon(Icons.check, key: Key('new-expense-bad-input-dialog-dismiss-button')),
            ),
          ],
        ),
      );
    }
  }

  void _submitExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountInvalid = (enteredAmount == null || enteredAmount <= 0);

    if (_titleController.text.trim().isEmpty ||
        amountInvalid ||
        _datePickerWidget.selectedDate == null) {

      final List<String> errorMessages = [];

      _titleController.text.trim().isEmpty
          ? errorMessages.add('Title cannot be blank.')
          : null;
      amountInvalid
          ? errorMessages.add('Amount must be more than 0.')
          : null;
      _datePickerWidget.selectedDate == null
          ? errorMessages.add('Date must be selected.')
          : null;

      _showDialog(errorMessages);
      return;
    } else {
      widget.onAddExpense(
        Expense(
          title: _titleController.text.trim(),
          date: _datePickerWidget.selectedDate!,
          amount: enteredAmount,
          category: _categorySelectWidget.selectedCategory,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final double widthAvail = constraints.maxWidth;
        final bool renderPortrait = widthAvail < Constants.kResponsiveThreshold;

        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (renderPortrait)
                    TitleField(titleController: _titleController, key: Key('new-expense-title-field'),)
                  else // landscape
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: TitleField(
                              titleController: _titleController,
                              key: Key('new-expense-title-field')
                            ),
                          ),
                        ),
                        Expanded(child: Center(child: _categorySelectWidget)),
                        Expanded(child: Center(child: _datePickerWidget)),
                      ],
                    ),
                  if (renderPortrait)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: AmountField(
                            amountController: _amountController,
                            key: Key('new-expense-amount-field')
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(child: _datePickerWidget),
                      ],
                    )
                  else // landscape
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: widthAvail / 4,
                          child: AmountField(
                            amountController: _amountController,
                            key: Key('new-expense-amount-field')
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            AdaptiveElevatedButton(
                              onPressed: _submitExpense,
                              key: Key('new-expense-save-button'),
                              child: const Text('Save Expense'),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              key: Key('new-expense-cancel-button'),
                              icon: Utilities.isIOS
                              ? const Icon(CupertinoIcons.delete_left)
                              : const Icon(Icons.cancel_outlined),
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (renderPortrait) const SizedBox(height: 24),
                  if (renderPortrait)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _categorySelectWidget,
                        const Spacer(),
                        AdaptiveElevatedButton(
                          onPressed: _submitExpense,
                          key: Key('new-expense-save-button'),
                          child: const Text('Save Expense'),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          key: Key('new-expense-cancel-button'),
                          icon: Utilities.isIOS
                          ? const Icon(CupertinoIcons.delete_left)
                          : const Icon(Icons.cancel_outlined),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
