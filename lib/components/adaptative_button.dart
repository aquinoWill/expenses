import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdataptiveButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  AdataptiveButton({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(label),
            onPressed: onPressed,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            )
          )
        : RaisedButton(
            child: Text(label),
            onPressed: onPressed,
            color: Theme.of(context).primaryColor,
            textColor: Theme.of(context).textTheme.button.color,
          );
  }
}
