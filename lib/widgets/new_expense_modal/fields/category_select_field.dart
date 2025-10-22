import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/utils/constants.dart';
import 'package:expense_tracker/utils/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CategorySelectField extends StatefulWidget {
  Category _selectedCategory;

  CategorySelectField({super.key})
    : _selectedCategory = Constants.kDefaultCategory;

  Category get selectedCategory {
    return _selectedCategory;
  }

  @override
  State<CategorySelectField> createState() {
    return _CategorySelectFieldState();
  }
}

class _CategorySelectFieldState extends State<CategorySelectField> {
  Widget cupertinoPicker() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(categoryIcons[widget._selectedCategory]),
          const SizedBox(width: 8),
          Text(
            widget._selectedCategory.name,
            style: CupertinoTheme.of(context).textTheme.textStyle,
          ),
          const Icon(CupertinoIcons.chevron_down, size: 16),
        ],
      ),
      onPressed: () {
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext context) => Container(
            height: 250,
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: CupertinoPicker(
                backgroundColor: CupertinoColors.systemBackground.resolveFrom(
                  context,
                ),
                itemExtent: 50,
                scrollController: FixedExtentScrollController(
                  initialItem: Category.values.indexOf(
                    widget._selectedCategory,
                  ),
                ),
                onSelectedItemChanged: (int index) {
                  setState(() {
                    widget._selectedCategory = Category.values[index];
                  });
                },
                children: Category.values.map((category) {
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(categoryIcons[category]),
                        const SizedBox(width: 16),
                        Text(
                          category.name,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget materialPicker() {
    return DropdownButton(
      value: widget._selectedCategory,
      items: Category.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Row(
                children: [
                  Icon((categoryIcons[category])),
                  SizedBox(width: 16),
                  Text(
                    category.name,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (Category? value) {
        if (value == null) {
          return;
        }
        setState(() {
          widget._selectedCategory = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Utilities.isIOS ? cupertinoPicker() : materialPicker();
  }
}
