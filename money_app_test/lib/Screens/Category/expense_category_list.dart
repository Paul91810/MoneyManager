import 'package:flutter/material.dart';
import 'package:money_app/DB/Category/category_db.dart';
import 'package:money_app/Screens/Category/category_model.dart';

class ExpenceCategoryList extends StatelessWidget {
  const ExpenceCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoeyDB().expenseCategoryList,
      builder: (BuildContext context, List<CategoryModel> newList, child) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final category = newList[index];
              return Card(
                child: ListTile(
                    title: Row(
                      children: [
                        Text(category.name),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        CategoeyDB.instance.deleteCategory(category.id);
                      },
                      icon: const Icon(Icons.delete),
                    )),
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
}
