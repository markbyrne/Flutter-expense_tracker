import 'package:expense_tracker/utils/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveElevatedButton extends StatelessWidget{
  final void Function() onPressed;
  final Widget child;

  const AdaptiveElevatedButton({required super.key, required this.onPressed, required this.child});


  @override
  Widget build(BuildContext context) {
    return Utilities.isIOS
      ? CupertinoButton(
        onPressed: onPressed,
        child: child,
      )
      : ElevatedButton(
        onPressed: onPressed,
        child: child,
      );
  }
}