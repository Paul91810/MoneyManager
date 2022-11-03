import 'package:flutter/material.dart';
import 'package:money_app/DB/Category/category_db.dart';
import 'package:money_app/Screens/Category/expense_category_list.dart';
import 'package:money_app/Screens/Category/icome_category_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({super.key});

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController tabController1;

  @override
  void initState() {
    tabController1 = TabController(length: 2, vsync: this);
    CategoeyDB().refreshUi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            unselectedLabelColor: Colors.grey,
            controller: tabController1,
            tabs: const [
              Tab(
                text: "INCOME",
              ),
              Tab(
                text: "EXPENSE",
              )
            ]),
        Expanded(
          child: TabBarView(controller: tabController1, children: const [
            IncomeCategoryList(),
            ExpenceCategoryList(),
          ]),
        )
      ],
    );
  }
}
