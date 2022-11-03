import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_app/DB/Category/category_db.dart';
import 'package:money_app/DB/Transactions/transaction_db.dart';
import 'package:money_app/Screens/Category/category_model.dart';
import '../../DB/Transaction/transaction_model.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoeyDB.instance.refreshUi();

    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (BuildContext context, List<TransactionModel> newList, widget) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final value = newList[index];
              return Slidable(
                key: Key(value.id!),
                startActionPane:
                    ActionPane(motion: const BehindMotion(), children: [
                  SlidableAction(
                    onPressed: (context) {
                      TransactionDB.instance.deleteTransaction(value.id!);
                    },
                    icon: Icons.delete,
                  )
                ]),
                child: Card(
                  elevation: 1,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 50,
                      backgroundColor: value.type == CategoryType.incopme
                          ? Colors.green
                          : Colors.red,
                      child: Text(
                        parseDate(value.date),
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ),
                    title: Text('RS ${value.amount}'),
                    subtitle: Text(value.purpose),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 10,
              );
            },
            itemCount: newList.length);
      },
    );
  }

  String parseDate(DateTime date) {
    final date1 = DateFormat.MMMd().format(date);
    final splitdate = date1.split('');
    return '${splitdate.last}\n${splitdate.first}';
  }
}
