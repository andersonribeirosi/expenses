import 'package:flutter/material.dart';
import 'chart_bar.dart';
import 'package:flutter_expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

  List<Map<String, Object>> get _groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      final day = DateFormat.E().format(weekDay)[0];

      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        bool someDay = recentTransactions[i].date.day == weekDay.day;
        bool someMonth = recentTransactions[i].date.month == weekDay.month;
        bool someYear = recentTransactions[i].date.year == weekDay.year;

        if (someDay && someMonth && someYear) {
          totalSum += recentTransactions[i].value;
        }
      }

      return {
        'day': day,
        'value': totalSum.toStringAsFixed(2),
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return _groupedTransactions.fold(0.0, (sum, tr) {
      return sum + double.parse(tr['value'].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _groupedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr['day'].toString(),
                value: double.parse(tr['value'].toString()),
                percentage: _weekTotalValue == 0
                    ? 0
                    : double.parse(tr['value'].toString()) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
