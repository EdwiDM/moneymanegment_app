

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanegment_app/models/transaction/transaction_model.dart';

const Transaction_Db_Name = 'transaction-Db';

abstract class TransactionDbFunctions {
  Future<void> addTransaction(TransactionModel obj);

  Future<List<TransactionModel>> getAllTransactions();

  Future<void> deleteTransaction(String id);
}

class TransactionDb implements TransactionDbFunctions {
  TransactionDb._internal();

  static TransactionDb instance = TransactionDb._internal();

  factory TransactionDb() {
    return instance;
  }

  // Notifier to update when transactions change
  ValueNotifier<List<TransactionModel>> transactionListNotifier =
  ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _Db = await Hive.openBox<TransactionModel>(Transaction_Db_Name);
    await _Db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _list = await getAllTransactions();
    _list.sort((first, second) => second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async {
    final _Db = await Hive.openBox<TransactionModel>(Transaction_Db_Name);
    return _Db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _Db = await Hive.openBox<TransactionModel>(Transaction_Db_Name);
    await _Db.delete(id);
    refresh();
  }
}
