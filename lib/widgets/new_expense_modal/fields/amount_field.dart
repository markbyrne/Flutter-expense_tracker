import 'package:expense_tracker/utils/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AmountField extends StatelessWidget {
  final TextEditingController amountController;

  const AmountField({super.key, required this.amountController});

  @override
  Widget build(BuildContext context) {
    const inputType = TextInputType.numberWithOptions(decimal: true);
    const label = Text('Amount');
    const prefix = '\$ ';
    const inputDecoration = InputDecoration(
      prefixText: prefix,
      label: label,
    );

    return Utilities.isIOS
        ? CupertinoTextField(
            controller: amountController,
            keyboardType: inputType,
            placeholder: label.data,
            prefix: const Padding(
              padding: EdgeInsets.only(left: 6.0),
              child: Text(prefix),
            ),
          )
        : TextField(
            controller: amountController,
            keyboardType: inputType,
            decoration: inputDecoration,
          );
  }
}
