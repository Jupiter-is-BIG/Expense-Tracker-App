import 'package:intl/intl.dart';

import 'package:expense_app/models/transaction.dart';
import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function fun;

  NewTransaction(this.fun);

  State<StatefulWidget> createState() {
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredAmount = double.parse(_amountController.text);

    if (enteredAmount <= 0 || enteredTitle.isEmpty || _selectedDate == null) {
      return;
    }
    widget.fun(enteredTitle, enteredAmount, _selectedDate);
    Navigator.of(context)
        .pop(); // removes the top content from the scree ie it removes the add tx menu
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                TextField(
                  // cursorColor: Colors.purple,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    // labelStyle: TextStyle(color: Colors.purple),
                  ),
                  controller: _titleController,
                  onSubmitted: (_) => _submitData(),
                ),
                TextField(
                  // cursorColor: Colors.purple,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    // labelStyle: TextStyle(color: Colors.purple)
                  ),
                  // onChanged: (val) => amountInput = val,
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submitData(),
                ),
                Container(
                    height: 70,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                            fit: FlexFit.tight,
                            child: Text(_selectedDate == null
                                ? 'No Date Chosen!'
                                : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate as DateTime)}')),
                        FlatButton(
                            onPressed: _presentDatePicker,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor),
                            ))
                      ],
                    )),
                RaisedButton(
                  onPressed: _submitData,
                  child: Text('Add Transaction'),
                  color: Theme.of(context).primaryColor,
                  textColor: Colors.white,
                )
              ],
            )));
  }
}
