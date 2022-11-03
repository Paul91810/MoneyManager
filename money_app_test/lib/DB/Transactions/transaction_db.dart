import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';

import '../Transaction/transaction_model.dart';
import 'package:hive/hive.dart';

const tramsactionDB = 'Transaction';

abstract class TransactionDBFunctions {
  Future<void> addTransaction(TransactionModel data);
  Future<List<TransactionModel>> getAllTransaction();
  Future<void> deleteTransaction(String id);
}

class TransactionDB implements TransactionDBFunctions {
  TransactionDB.internal();

  static TransactionDB instance = TransactionDB.internal();

  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel data) async {
    final db = await Hive.openBox<TransactionModel>(tramsactionDB);
    await db.put(data.id, data);
  }

  Future<void> refresh() async {
    final list = await getAllTransaction();
    list.sort((first, second) {
      return second.date.compareTo(first.date);
    });
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransaction() async {
    final db = await Hive.openBox<TransactionModel>(tramsactionDB);
    return db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final db = await Hive.openBox<TransactionModel>(tramsactionDB);
    await db.delete(id);
    refresh();
  }
}
