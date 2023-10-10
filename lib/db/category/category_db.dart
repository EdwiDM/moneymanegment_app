

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:moneymanegment_app/models/category/category_model.dart';

const Category_Db_Name = 'category-database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryID);
}

class CategoryDb implements CategoryDbFunctions {
  CategoryDb._internal();

  static CategoryDb instance = CategoryDb._internal();

  factory CategoryDb() {
    return instance;
  }

  ValueNotifier<List<CategoryModel>> incomCategoryListlistener =
  ValueNotifier([]);
  ValueNotifier<List<CategoryModel>> expenseCategoryListlistener =
  ValueNotifier([]);

  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDb = await Hive.openBox<CategoryModel>(Category_Db_Name);
    await _categoryDb.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDb = await Hive.openBox<CategoryModel>(Category_Db_Name);
    return _categoryDb.values.toList();
  }

  Future<void> refreshUI() async {
    final _allCategories = await getCategories();
    incomCategoryListlistener.value.clear();
    expenseCategoryListlistener.value.clear();
    _allCategories.forEach((CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomCategoryListlistener.value.add(category);
      } else {
        expenseCategoryListlistener.value.add(category);
      }
    });
    incomCategoryListlistener.notifyListeners();
    expenseCategoryListlistener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryID) async {
    final _categoryDb = await Hive.openBox<CategoryModel>(Category_Db_Name);
    await _categoryDb.delete(categoryID);
    refreshUI();
  }
}




