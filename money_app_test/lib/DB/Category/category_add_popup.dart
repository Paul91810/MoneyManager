import 'package:flutter/material.dart';
import 'package:money_app/DB/Category/category_db.dart';
import 'package:money_app/Screens/Category/category_model.dart';

final category = TextEditingController();

Future<void> showPopUp(BuildContext context) async {
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text("Add Category"),
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    controller: category,
                    decoration: const InputDecoration(
                        hintText: "Type Category",
                        border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            Row(
              children: const [
                ShowRadio(title: "Income", type: CategoryType.incopme),
                ShowRadio(title: "Expence", type: CategoryType.expence)
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  final name = category.text.toUpperCase();
                  if (name.isEmpty) {
                    return;
                  }
                  final categoryModel = CategoryModel(
                      name: name,
                      type: selectedCategory.value,
                      id: DateTime.now().microsecondsSinceEpoch.toString());
                  CategoeyDB().insertCategory(categoryModel);
                  Navigator.of(ctx).pop();
                },
                child: const Text('Add'))
          ],
        );
      });
}

ValueNotifier<CategoryType> selectedCategory =
    ValueNotifier(CategoryType.incopme);

class ShowRadio extends StatelessWidget {
  const ShowRadio({super.key, required this.title, required this.type});

  final String title;
  final CategoryType type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
            valueListenable: selectedCategory,
            builder: (BuildContext context, CategoryType value, child) {
              return Radio<CategoryType>(
                value: type,
                groupValue: selectedCategory.value,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedCategory.value = value;
                  selectedCategory.notifyListeners();
                },
              );
            }),
        Text(title)
      ],
    );
  }
}
