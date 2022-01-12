import 'package:flutter/foundation.dart';
import 'package:sum/Models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionProvider with ChangeNotifier {
  List<Transaction> _transactions = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  List<Transaction> get transactions {
    return _transactions;
  }

  void addTransaction(
    Transaction newTransaction,
  ) {
    _transactions.add(newTransaction);
    notifyListeners();
  }

  void deleteTransaction(String id) {
    _transactions.removeWhere((tx) => tx.id == id);
    notifyListeners();
  }

  void clear() {
    _transactions = [];
    notifyListeners();
  }

  List<Transaction> get recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  List<Map<String, Object>> groupedTransactionValues(var recentTransactions) {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    }).reversed.toList();
  }

  double totalSpending(var recentTransactions) {
    return groupedTransactionValues(recentTransactions).fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }
}
