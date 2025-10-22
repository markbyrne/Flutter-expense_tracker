// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:expense_tracker/app/expense_tracker_app.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/utils/constants.dart';
import 'package:expense_tracker/widgets/new_expense_modal/fields/category_select_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

int defaultExpenseCount = Constants.kDemoExpenseCount;

List<Element> _findExpenseDismissibles(){
  return find.byType(Dismissible)
      .evaluate()
      .where((element) {
        final dismissible = element.widget as Dismissible;
        return dismissible.key is ValueKey && 
              (dismissible.key as ValueKey).value is Expense;
      })
      .toList();
}

void main(){
  testWidgets('Undo Delete Expense smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExpenseTrackerApp());

    // Verify that demo starts with default number of expenses displayed.
    expect(_findExpenseDismissibles().length, defaultExpenseCount);

    // Swipe to dismiss and trigger a frame.
    await tester.timedDrag(find.byType(Dismissible).first, Offset(500, 0), Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    // Verify we now have 1 less expense.
    expect(_findExpenseDismissibles().length, defaultExpenseCount-1);

    // tap the undo snackbar alert
    await tester.tap(find.byKey(Key('undo-delete-expense-button')));
    await tester.pumpAndSettle();

    // Verify we now have 1 less expense.
    expect(_findExpenseDismissibles().length, defaultExpenseCount);
  });

    testWidgets('Delete Expense smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExpenseTrackerApp());

    // Verify that demo starts with default number of expenses displayed.
    expect(_findExpenseDismissibles().length, defaultExpenseCount);

    // Swipe to dismiss and trigger a frame.
    await tester.timedDrag(find.byType(Dismissible).first, Offset(500, 0), Duration(milliseconds: 500));
    await tester.pumpAndSettle();

    // Verify we now have 1 less expense.
    expect(_findExpenseDismissibles().length, defaultExpenseCount-1);
  });

  testWidgets('New Expense modal display (Portrait) smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExpenseTrackerApp());

    // open the add expense modal
    await tester.tap(find.byKey(Key('add-new-expense-button')));
    await tester.pumpAndSettle();

    // ensure title field displays properly
    expect(find.byKey(const Key('new-expense-title-field')), findsOneWidget);
    // ensure amount field displays properly
    expect(find.byKey(const Key('new-expense-amount-field')), findsOneWidget);
    // ensure date select field displays properly
    expect(find.byKey(const Key('new-expense-date-select-button')), findsOneWidget);
    expect(find.text(Constants.kDefaultDateString), findsOneWidget);
    // ensure category select field displays
    expect(find.byKey(const Key('new-expense-category-select-field')), findsOneWidget);
    final categoryDropdown = find.byKey(const Key('new-expense-category-select-field')).evaluate().first.widget as CategorySelectField;
    expect(categoryDropdown.selectedCategory, Constants.kDefaultCategory);
    // ensure submit button is present
    expect(find.byKey(const Key('new-expense-save-button')), findsOneWidget);
    // ensure cancel button is present
    expect(find.byKey(const Key('new-expense-cancel-button')), findsOneWidget);
  });

  testWidgets('New Expense modal display (Landscape) smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExpenseTrackerApp());

    // Simulate rotate display, rebuild landscape
    await tester.binding.setSurfaceSize(Size(720, 480)); // landscape size
    await tester.pumpAndSettle();

    // open the add expense modal
    await tester.tap(find.byKey(Key('add-new-expense-button')));
    await tester.pumpAndSettle();

    // ensure title field displays properly
    expect(find.byKey(const Key('new-expense-title-field')), findsOneWidget);
    // ensure amount field displays properly
    expect(find.byKey(const Key('new-expense-amount-field')), findsOneWidget);
    // ensure date select field displays properly
    expect(find.byKey(const Key('new-expense-date-select-button')), findsOneWidget);
    expect(find.text(Constants.kDefaultDateString), findsOneWidget);
    // ensure category select field displays
    expect(find.byKey(const Key('new-expense-category-select-field')), findsOneWidget);
    final categoryDropdown = find.byKey(const Key('new-expense-category-select-field')).evaluate().first.widget as CategorySelectField;
    expect(categoryDropdown.selectedCategory, Constants.kDefaultCategory);
    // ensure submit button is present
    expect(find.byKey(const Key('new-expense-save-button')), findsOneWidget);
    // ensure cancel button is present
    expect(find.byKey(const Key('new-expense-cancel-button')), findsOneWidget);
  });
  
  testWidgets('Add Expense smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExpenseTrackerApp());

    // Verify that demo starts with default number of expenses displayed.
    expect(_findExpenseDismissibles().length, defaultExpenseCount);

    // open the add expense modal
    await tester.tap(find.byKey(Key('add-new-expense-button')));
    await tester.pumpAndSettle();

    //
    // add inputs
    //
    // add title
    await tester.enterText(find.byKey(const Key('new-expense-title-field')), 'Test Title');
    await tester.pump();

    // add amount
    await tester.enterText(find.byKey(const Key('new-expense-amount-field')), '169.00');
    await tester.pump();

    // click date select button
    await tester.tap(find.byKey(Key('new-expense-date-select-button')));
    await tester.pumpAndSettle();
    // The date picker dialog should be visible
    expect(find.byType(DatePickerDialog), findsOneWidget);
    // Tap OK button to select today's date
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    // Verify date is no longer "No date selected"
    expect(find.text(Constants.kDefaultDateString), findsNothing);

    // save expense
    await tester.tap(find.byKey(Key('new-expense-save-button')));
    await tester.pumpAndSettle();

    // Verify new expense was added.
    expect(_findExpenseDismissibles().length, defaultExpenseCount + 1);
  });

  testWidgets('Add Expense Bad Input smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ExpenseTrackerApp());

    // Verify that demo starts with default number of expenses displayed.
    expect(_findExpenseDismissibles().length, defaultExpenseCount);

    // open the add expense modal
    await tester.tap(find.byKey(Key('add-new-expense-button')));
    await tester.pumpAndSettle();

    // immediately try submit
    await tester.tap(find.byKey(Key('new-expense-save-button')));
    await tester.pumpAndSettle();

    // ensure error dialog displays
    expect(find.byKey(Key('new-expense-bad-input-dialog')), findsOneWidget);

    // dismiss alert
    await tester.tap(find.byKey(Key('new-expense-bad-input-dialog-dismiss-button')));
    await tester.pumpAndSettle();

    // cancel modal
    await tester.tap(find.byKey(Key('new-expense-cancel-button')));
    await tester.pumpAndSettle();

    // Verify no new expense was added.
    expect(_findExpenseDismissibles().length, defaultExpenseCount);
  });
}