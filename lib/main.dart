import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import './widgets/new_transactions.dart';
import 'package:expenses_planner/widgets/transaction_list.dart';
import 'models/transaction.dart';
import 'package:flutter/material.dart';
import 'widgets/chart.dart';
import 'package:intl/intl.dart';

import 'widgets/settingScreen.dart';
void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     theme: ThemeData(
  primarySwatch: Colors.brown,
  accentColor: Colors.brown[400],
  brightness: Brightness.light,
  // other light mode configurations
),
darkTheme: ThemeData(
  primarySwatch: Colors.brown,
  accentColor: Colors.brown[400],
  brightness: Brightness.dark,
  // other dark mode configurations
),
      title: 'Personal Expences',
      home: Scaffold(
        body: MyHomePage(),
      ),
      // utilise MyHomePage comme page d'accueil
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _openSettingsScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SettingsScreen(),
      ),
    );
  }

  final List<Transaction> _userTransactions = [
    /* Transaction(
        id: 'T1', title: 'New Shoes', amount: 69.99, date: DateTime.now()),
    Transaction(
        id: 'T2', title: 'New Shirt', amount: 49.99, date: DateTime.now())*/
  ];
  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewtransaction(
      String txtitle, double txamount, DateTime choosenDate) {
    final newTx = Transaction(
        title: txtitle,
        amount: txamount,
        date: choosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deletetransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: true,
        elevation: 10,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: newTransaction(_addNewtransaction)),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  bool showChart = false;

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
          style: TextStyle(
              fontFamily: 'Roboto', fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'settings') {
                _openSettingsScreen(context);
              }
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: 'settings',
                child: Text('Settings',style: TextStyle(fontWeight: FontWeight.bold),),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (isLandScape)
                Row(
                  children: [
                    Text('Show Chart'),
                    Switch(
                        value: showChart,
                        onChanged: (val) {
                          setState(() {
                            showChart = val;
                          });
                        })
                  ],
                ),
              Chart(_recentTransaction),
              TransactionList(_userTransactions, _deletetransaction),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onPressed: () => _startAddNewTransaction(context),
          child: Icon(Icons.add)),
    );
  }
}
