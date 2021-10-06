import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loja_virtual_pro/components/transaction_form.dart';
import 'package:loja_virtual_pro/components/transaction_list.dart';
import 'package:loja_virtual_pro/models/transaction.dart';

class TransactionUser extends StatefulWidget {
  @override
  _TransactionUserState createState() => _TransactionUserState();
}

class _TransactionUserState extends State<TransactionUser> {
  final _transactions = [
    Transaction(
        id: '1', title: 'Tênis Nike', value: 300.65, date: DateTime.now()),
    Transaction(
        id: '2', title: 'Mouse sem fio', value: 259.20, date: DateTime.now())
  ];

  _addTransaction(String title, double value) {
    final newTransaction = Transaction(
        id: Random().nextDouble().toString(),
        title: title,
        value: value,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TransactionForm(_addTransaction),
        TransactionList(_transactions),
      ],
    );
  }
}
