import 'package:flutter/material.dart';
import 'package:sum/Models/transaction.dart';
import 'package:sum/UI/expenses/chart.dart';
import 'package:sum/UI/expenses/new_transaction.dart';
import 'package:sum/UI/expenses/transaction_list.dart';
import 'package:sum/providers/TransactionProvider.dart';
import 'package:provider/provider.dart';
import 'package:sum/providers/users.dart';

class MyHomePage extends StatefulWidget {
  static String tag = 'Home';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
     final transactionProvider = Provider.of<TransactionProvider>(context);
    List<Transaction> _userTransactions = transactionProvider.transactions;


    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personal Expenses',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Chart(),
            TransactionList(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
