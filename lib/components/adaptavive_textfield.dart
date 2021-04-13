import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptativeTextField extends StatelessWidget {
  final String labelText;
  final Function(String) onSubmit;
  final TextInputType keyboardType;
  final TextEditingController controller;

  AdaptativeTextField(
      {this.labelText, this.onSubmit, this.controller, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(controller: controller)
        : TextField(
            onSubmitted: onSubmit,
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(labelText: labelText));
  }
}
