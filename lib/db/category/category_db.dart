import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_manager/models/category/category_model.dart';

const CATEGORY_DB_NAME = 'category-database';

abstract class CategoryDBFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String catrgoryID);
}

class CategoryDB implements CategoryDBFunctions {
  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();
  factory CategoryDB(){
    return instance;
  }
  ValueNotifier<List<CategoryModel>> incomeCategoryList = ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryList = ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.put(value.id,value);
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future<void> refreshUI() async {
    final _allCategories = await getCategories();
    incomeCategoryList.value.clear();
    expenseCategoryList.value.clear();
    await Future.forEach(
      _allCategories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryList.value.add(category);
        } else {
          expenseCategoryList.value.add(category);
        }
      },
    );
    incomeCategoryList.notifyListeners();
    expenseCategoryList.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String catrgoryID) async {
  final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
   _categoryDB.delete(catrgoryID);
   refreshUI();
  }
}
