import 'package:expenses_planner/models/transaction.dart';
import 'package:expenses_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(30, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: 29 - index));
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekDay));
      print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }); //.reversed.toList()
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
            children: groupedTransactionValues.map(
              (data) {
                return Row(
                  children: [
                    SizedBox(width: 17,),
                    Chartbar(
                        data['day'] as String,
                        data['amount'] as double,
                        totalSpending == 0.0
                            ? 0.0
                            : (data['amount'] as double) / totalSpending),
                  ],
                );
              },
            ).toList(),
            
          ),
        ),
      ),
    );
  }
}
