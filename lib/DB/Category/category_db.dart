import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_app/Screens/Category/category_model.dart';

abstract class CategoryDBFunctions {
  Future<List<CategoryModel>> getCategory();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryId);
}

const categorydbname = "category";

class CategoeyDB implements CategoryDBFunctions {
  CategoeyDB.internal();

  factory CategoeyDB() {
    return instance;
  }

  static CategoeyDB instance = CategoeyDB.internal();

  ValueNotifier<List<CategoryModel>> incomeCategoryList = ValueNotifier([]);

  ValueNotifier<List<CategoryModel>> expenseCategoryList = ValueNotifier([]);
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final categoryDb = await Hive.openBox<CategoryModel>(categorydbname);
    categoryDb.put(value.id, value);
    refreshUi();
  }

  @override
  Future<List<CategoryModel>> getCategory() async {
    final categoryDb = await Hive.openBox<CategoryModel>(categorydbname);
    return categoryDb.values.toList();
  }

  Future<void> refreshUi() async {
    final category = await getCategory();
    incomeCategoryList.value.clear();
    expenseCategoryList.value.clear();

    Future.forEach(category, (CategoryModel category) {
      if (category.type == CategoryType.incopme) {
        incomeCategoryList.value.add(category);
      } else {
        expenseCategoryList.value.add(category);
      }
    });
    incomeCategoryList.notifyListeners();
    expenseCategoryList.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    final categoryDb = await Hive.openBox<CategoryModel>(categorydbname);
    await categoryDb.delete(categoryId);
    refreshUi();
  }
}
