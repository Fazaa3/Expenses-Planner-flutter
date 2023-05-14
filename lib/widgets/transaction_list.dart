import 'package:expenses_planner/models/transaction.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetx;
  TransactionList(this.transactions, this.deletetx);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: ((context, constraints) {
            return Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                Text(
                  'No Transaction added yet !',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  height: 160,
                  width: 180,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 20,
                            offset: Offset(0, 1))
                      ],
                      border: Border.all(color: Colors.grey, width: 1.0),
                      borderRadius: BorderRadius.circular(0)),
                  child: Image.asset(
                    'assets/sands-of-time-in-water.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          }))
        :

        // Return an empty container if transactions list is empty

        Container(
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                      radius: 30,
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                              child: Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'D${transactions[index].amount}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ))),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                        DateFormat.yMMMMd().format(transactions[index].date)),
                    trailing: MediaQuery.of(context).size.width > 360
                        ? TextButton.icon(
                            onPressed: (() {
                              deletetx(transactions[index].id);
                            }),
                            icon: Icon(
                              Icons.delete,
                            ),
                            label: Text('Delete'))
                        : IconButton(
                            onPressed: () => deletetx(transactions[index].id),
                            icon: Icon(Icons.delete)),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
          );
  }
}
