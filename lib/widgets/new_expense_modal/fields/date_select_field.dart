import 'package:expense_tracker/utils/constants.dart';
import 'package:expense_tracker/utils/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();

// ignore: must_be_immutable
class DateSelectField extends StatefulWidget {
  DateTime? _selectedDate;

  DateSelectField({super.key});

  DateTime? get selectedDate {
    return _selectedDate;
  }

  @override
  State<DateSelectField> createState() {
    return _DateSelectFieldState();
  }
}

class _DateSelectFieldState extends State<DateSelectField> {
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = now;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    setState(() {
      widget._selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            widget._selectedDate == null
                ? Constants.kDefaultDateString
                : dateFormatter.format(widget._selectedDate!),
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.end,
          ),
        ),
        IconButton(
          onPressed: _presentDatePicker,
          key: Key('new-expense-date-select-button'),
          icon: Utilities.isIOS 
            ? const Icon(CupertinoIcons.calendar)
            : const Icon(Icons.calendar_month),
        ),
      ],
    );
  }
}
