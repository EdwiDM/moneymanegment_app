

import 'package:flutter/material.dart';
import 'package:moneymanegment_app/db/category/category_db.dart';
import 'package:moneymanegment_app/models/category/category_model.dart';

class IncomeCategoryList extends StatelessWidget {
  const IncomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable:
        CategoryDb().incomCategoryListlistener = ValueNotifier([]),
        builder: (BuildContext ctx, List<CategoryModel> newlist, Widget?_) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final category = newlist[index];
                return Card(
                  child: ListTile(
                    title: Text(category.name),
                    trailing: IconButton(
                        onPressed: () {
                          CategoryDb.instance.deleteCategory(category.id);
                        },
                        icon: const Icon(Icons.delete)),
                  ),
                );
              },
              separatorBuilder: (ctx, intex) {
                return const SizedBox(height: 10);
              },
              itemCount: newlist.length);
        }
    );
  }
}
