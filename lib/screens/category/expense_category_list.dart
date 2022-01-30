import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: CategoryDB().incomeCategoryList, builder: ListView.separated(itemBuilder: (ctx, index) {
      return ListTile(title: Text('Expense Category $index'), trailing: const Icon(Icons.delete),);
    }, 
    separatorBuilder: (ctx, index) {
      return SizedBox(height: 10);
    }, itemCount: 10,);)
  }
}
