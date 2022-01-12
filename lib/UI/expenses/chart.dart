import 'package:flutter/material.dart';
import 'package:sum/providers/TransactionProvider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import './chart_bar.dart';

class Chart extends StatelessWidget {
  Chart();

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final recentTransactions = transactionProvider.recentTransactions;
    final totalSpending = transactionProvider.totalSpending(recentTransactions);

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: transactionProvider
              .groupedTransactionValues(recentTransactions)
              .map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'],
                data['amount'],
                totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) /
                        transactionProvider.totalSpending(recentTransactions),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
