import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';

ValueNotifier<CategoryType> selectedCategory =
    ValueNotifier(CategoryType.income);
Future<void> showCategoryAddPopup(BuildContext context) async {
  final _nameEditingController = TextEditingController();
  showDialog(
      context: context,
      builder: (ctx) {
        return SimpleDialog(
          title: const Text('Add Catogry'),
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _nameEditingController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Category Name',
                ),
              ),
            ),
            Row(
              children: [
                RadioButton(title: 'Income', type: CategoryType.income),
                RadioButton(title: 'Expense', type: CategoryType.expense),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  final _name = _nameEditingController.text;
                  if (_name.isEmpty) {
                    return;
                  } else {
                    final _type = selectedCategory.value;
                   final _category = CategoryModel(
                        id: DateTime.now().microsecondsSinceEpoch.toString(),
                        name: _name,
                        type: _type);
                  CategoryDB.instance.insertCategory(_category);
                  CategoryDB().refreshUI();
                  Navigator.of(ctx).pop();
                  }
                },
                child: const Text('Add'),
              ),
            ),
          ],
        );
      });
}

class RadioButton extends StatelessWidget {
  final String title;
  final CategoryType type;
  const RadioButton({
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: selectedCategory,
          builder: (BuildContext context, CategoryType newCategory, Widget? _) {
            return Radio<CategoryType>(
              value: type,
              groupValue: selectedCategory.value,
              onChanged: (value) {
                if (value == null) {
                  return;
                }
                selectedCategory.value = value;
              },
            );
          },
        ),
        Text(title),
      ],
    );
  }
}
