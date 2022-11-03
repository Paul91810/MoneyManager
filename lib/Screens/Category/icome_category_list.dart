import 'package:flutter/material.dart';

import 'package:money_app/DB/Category/category_db.dart';

import 'category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoeyDB().incomeCategoryList,
      builder: (BuildContext context, List<CategoryModel> newList, child) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final category1 = newList[index];
              return Card(
                child: ListTile(
                    title: Row(
                      children: [
                        Text(category1.name),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        CategoeyDB.instance.deleteCategory(category1.id);
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
