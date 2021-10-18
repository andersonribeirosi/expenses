import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_expenses/components/chart.dart';
import 'package:flutter_expenses/components/transaction_list.dart';

import 'components/transaction_form.dart';
import 'models/transaction.dart';

main() {
  runApp(MyExpenses());
}

class MyExpenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.portraitUp,
    // ]);
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        // cardColor: Colors.grey[300],
        textTheme: const TextTheme(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _transactions = [
    // Transaction(
    //     id: '1',
    //     title: 'Despesa #01',
    //     value: 310.76,
    //     date: DateTime.now().subtract(Duration(days: 3))),
    // Transaction(
    //     id: '2',
    //     title: 'Despesa #02',
    //     value: 211.30,
    //     date: DateTime.now().subtract(Duration(days: 4))),
    // Transaction(
    //     id: '3', title: 'Despesa #03', value: 211.30, date: DateTime.now()),
    // Transaction(
    //     id: '4', title: 'Despesa #04', value: 11.30, date: DateTime.now()),
    // Transaction(
    //     id: '5',
    //     title: 'Despesa #01',
    //     value: 310.76,
    //     date: DateTime.now().subtract(Duration(days: 3))),
    // Transaction(
    //     id: '6',
    //     title: 'Despesa #02',
    //     value: 211.30,
    //     date: DateTime.now().subtract(Duration(days: 4))),
    // Transaction(
    //     id: '7', title: 'Despesa #03', value: 211.30, date: DateTime.now()),
    // Transaction(
    //     id: '8', title: 'Despesa #04', value: 11.30, date: DateTime.now()),
  ];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      // date: DateTime.now());
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openModalTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Despesas pessoais'),
      actions: [
        if (isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(_showChart ? Icons.list : Icons.show_chart),
          ),
        IconButton(
            onPressed: () => _openModalTransaction(context),
            icon: Icon(Icons.add))
      ],
    );

    final availableHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // SizedBox(height: 20),
              // FlexibleExpanded()
              // if (isLandscape)
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Text('Exibir Gráfico'),
              //       Switch(
              //         value: _showChart,
              //         onChanged: (value) {
              //           setState(() {
              //             _showChart = value;
              //           });
              //         },
              //       ),
              //     ],
              //   ),
              SizedBox(
                height: 5,
              ),
              if (_showChart || !isLandscape)
                Container(
                  height: availableHeight * (isLandscape ? 0.7 : 0.3),
                  child: Chart(_recentTransactions),
                ),

              if (!_showChart || !isLandscape)
                Container(
                  height: availableHeight * (isLandscape ? 1 : 0.7),
                  child: TransactionList(_transactions, _removeTransaction),
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _openModalTransaction(context),
          child: Icon(Icons.add),
          // backgroundColor: Colors.blue,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
