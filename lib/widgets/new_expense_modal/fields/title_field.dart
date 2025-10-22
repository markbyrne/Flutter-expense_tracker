import 'package:expense_tracker/utils/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleField extends StatelessWidget{
  final TextEditingController titleController;

  const TitleField({super.key, required this.titleController});

  @override
  Widget build(BuildContext context) {
    const maxLength = 50;
    const label = Text('Title');
    const inputDecoration = InputDecoration(label: label);
    
    return Utilities.isIOS
    ? Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: CupertinoTextField(
        controller: titleController,
        maxLength: maxLength,
        placeholder: label.data,
      ),
    )
    : TextField(
      controller: titleController,
      maxLength: maxLength,
      decoration: inputDecoration,
    );
  }
}