import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';

class IncomeCatgoryList extends StatelessWidget {
  const IncomeCatgoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: CategoryDB().incomeCategoryList,
        builder: (BuildContext ctx, List<CategoryModel> newList, Widget? _) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final category = newList[index];
              return ListTile(
                title: Text(category.name),
                trailing: IconButton(
                  onPressed: () {
                    CategoryDB.instance.deleteCategory(category.id);
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return SizedBox(height: 10);
            },
            itemCount: newList.length,
          );
        });
  }
}
