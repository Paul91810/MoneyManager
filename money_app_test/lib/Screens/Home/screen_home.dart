import 'package:flutter/material.dart';
import 'package:money_app/DB/Category/category_add_popup.dart';
import 'package:money_app/Screens/Add%20transaction/add_transaction.dart';
import 'package:money_app/Screens/Home/widgets/bottom_navigation.dart';
import 'package:money_app/Screens/Transacttions/screen_category.dart';
import 'package:money_app/Screens/Transacttions/screen_transction.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  static ValueNotifier<int> updatedIntex = ValueNotifier(0);
  final pages = [const ScreenTransactions(), const ScreenCategory()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Money Manager"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (updatedIntex.value == 0) {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const AddTransaction(),
            ));
          } else {
            // final sample = CategoryModel(
            //     name: "travel",
            //     type: CategoryType.incopme,
            //     id: DateTime.now().microsecondsSinceEpoch.toString());
            // CategoeyDB().insertCategory(sample);
            showPopUp(context);
          }
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const BottomNavigation(),
      body: SafeArea(
          child: ValueListenableBuilder(
        valueListenable: updatedIntex,
        builder: (BuildContext context, int selectedIndex, _) {
          return pages[selectedIndex];
        },
      )),
    );
  }
}
