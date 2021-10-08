import 'dart:math';

import 'package:flutter/material.dart';
import 'components/transaction_form.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() {
  runApp(MyExpenses());
}

// class HexColor extends Color {
//   static int _getColorFromHex(String hexColor) {
//     hexColor = hexColor.toUpperCase().replaceAll("#", "");
//     if (hexColor.length == 6) {
//       hexColor = "FF" + hexColor;
//     }
//     return int.parse(hexColor, radix: 16);
//   }

//   HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
// }

class MyExpenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Roboto',
        cardColor: Colors.grey[300],
        textTheme: const TextTheme(
            // headline6: TextStyle(fontSize: 36.0, fontFamily: 'EphesisRegular'),
            ),
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
    //     id: '1', title: 'Tênis Nike', value: 300.65, date: DateTime.now()),
    // Transaction(
    //     id: '2', title: 'Despesa #01', value: 109.20, date: DateTime.now()),
    // Transaction(
    //     id: '3', title: 'Despesa #02', value: 85.20, date: DateTime.now()),
    // Transaction(
    //     id: '4', title: 'Despesa #03', value: 2.20, date: DateTime.now()),
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

    Navigator.of(context).pop();
  }

  _openModalTransaction(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(_addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Despesas pessoais'),
          actions: [
            IconButton(
                onPressed: () => _openModalTransaction(context),
                icon: Icon(Icons.add))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5, bottom: 5),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Gráfico',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
                  ),
                  elevation: 5,
                  color: Colors.green[600],
                ),
              ),
              TransactionList(_transactions),
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
