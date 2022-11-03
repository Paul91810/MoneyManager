import 'package:flutter/material.dart';
import 'package:money_app/DB/Category/category_db.dart';
import 'package:money_app/DB/Transaction/transaction_model.dart';

import 'package:money_app/DB/Transactions/transaction_db.dart';
import 'package:money_app/Screens/Category/category_model.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  DateTime? selctedDate;
  CategoryType? selectedcategoryType;
  CategoryModel? selectedcategoryModel;
  String? categoryId;
  final purpose = TextEditingController();
  final amount = TextEditingController();

  @override
  void initState() {
    selectedcategoryType = CategoryType.incopme;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: purpose,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Purpose"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: amount,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: "Amount"),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      final selectedDatetemp = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(const Duration(days: 30)),
                          lastDate: DateTime.now());

                      if (selectedDatetemp == null) {
                        return;
                      } else {
                        debugPrint(selectedDatetemp.toString());
                        setState(() {
                          selctedDate = selectedDatetemp;
                        });
                      }
                    },
                    child: const Icon(Icons.calendar_today),
                  ),
                  Text(selctedDate == null
                      ? 'Select Date'
                      : selctedDate!.toString())
                ],
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.incopme,
                        groupValue: selectedcategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            selectedcategoryType = CategoryType.incopme;
                            categoryId = null;
                          });
                        },
                      ),
                      const Text("Income"),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expence,
                        groupValue: selectedcategoryType,
                        onChanged: (newValue) {
                          setState(() {
                            selectedcategoryType = CategoryType.expence;
                            categoryId = null;
                          });
                        },
                      ),
                      const Text("Expense")
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 150, bottom: 20),
                child: DropdownButton<String>(
                  hint: const Text("Select category"),
                  value: categoryId,
                  items: (selectedcategoryType == CategoryType.incopme
                          ? CategoeyDB().incomeCategoryList
                          : CategoeyDB().expenseCategoryList)
                      .value
                      .map((e) {
                    return DropdownMenuItem(
                      value: e.id,
                      child: Text(e.name),
                      onTap: () {
                        selectedcategoryModel = e;
                      },
                    );
                  }).toList(),
                  onChanged: (aluev) {
                    setState(() {
                      debugPrint(aluev);
                      categoryId = aluev;
                    });
                  },
                  onTap: () {},
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      addtransaction();
                    });
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      )),
    );
  }

  Future<void> addtransaction() async {
    final purpose1 = purpose.text;
    final amount1 = amount.text;
    if (purpose1.isEmpty && amount1.isEmpty) {
      return;
    }

    if (categoryId == null) {
      return;
    }

    if (selctedDate == null) {
      return;
    }
    if (selectedcategoryModel == null) {
      return;
    }

    final parsedamount = double.tryParse(amount1);
    if (parsedamount == null) {
      return;
    }

    final transaction = TransactionModel(
        purpose: purpose1.toUpperCase(),
        amount: parsedamount,
        date: selctedDate!,
        type: selectedcategoryType!,
        category: selectedcategoryModel!);

    await TransactionDB.instance.addTransaction(transaction);

    Navigator.of(context).pop();
    await TransactionDB.instance.refresh();
  }
}
