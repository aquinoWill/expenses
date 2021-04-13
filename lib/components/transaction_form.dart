import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'adaptative_button.dart';
import 'adaptavive_textfield.dart';

class TransactionFrom extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionFrom(this.onSubmit);

  @override
  _TransactionFromState createState() => _TransactionFromState();
}

class _TransactionFromState extends State<TransactionFrom> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AdaptativeTextField(
            labelText: 'Título',
            onSubmit: _submitForm(),
            controller: _titleController,
          ),
          AdaptativeTextField(
            onSubmit: _submitForm(),
            labelText: 'Valor (R\$)',
            controller: _valueController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          Row(
            children: [
              Text(_selectedDate == null
                  ? 'Nenhuma data selecionada!'
                  : DateFormat('dd/MM/y').format(_selectedDate)),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                child: Text(
                  'Selecionar data',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: _showDatePicker,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AdataptiveButton(label: 'Nova Trasação', onPressed: _submitForm)
            ],
          ),
        ],
      ),
    );
  }
}
