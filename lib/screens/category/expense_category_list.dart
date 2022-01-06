import 'package:flutter/material.dart';

class ExpenseCategoryList extends StatelessWidget {
  const ExpenseCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (ctx, index) {
      return ListTile(title: Text('Expense Category $index'), trailing: const Icon(Icons.delete),);
    }, 
    separatorBuilder: (ctx, index) {
      return SizedBox(height: 10);
    }, itemCount: 10,);
  }
}
