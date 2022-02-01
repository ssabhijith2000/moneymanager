import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';

class ScreenAddTransactions extends StatefulWidget {
  const ScreenAddTransactions({Key? key}) : super(key: key);
  static const routeName = 'add_transactions';

  @override
  State<ScreenAddTransactions> createState() => _ScreenAddTransactionsState();
}

class _ScreenAddTransactionsState extends State<ScreenAddTransactions> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategoryType;
  CategoryModel? _selectedCategoryModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Purpose',
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Amount',
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                final _selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(Duration(days: 60)),
                    lastDate: DateTime.now());
                if (_selectedDateTemp == null) {
                  return;
                } else {
                  setState(() {
                    _selectedDate = _selectedDateTemp;
                  });
                }
              },
              icon: Icon(Icons.calendar_today),
              label: _selectedDate == null
                  ? Text('Select Date')
                  : Text(
                      _selectedDate.toString(),
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio(
                      value: CategoryType.income,
                      groupValue: CategoryType.income,
                      onChanged: (newValue) {},
                    ),
                    Text('Income'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: CategoryType.expense,
                      groupValue: CategoryType.income,
                      onChanged: (newValue) {},
                    ),
                    Text('Expense'),
                  ],
                ),
              ],
            ),
            DropdownButton(
              hint: Text('Select Category'),
              items: CategoryDB.instance.incomeCategoryList.value.map((e) {
                return DropdownMenuItem(
                  child: Text(e.name),
                  value: e.id,
                );
              }).toList(),
              onChanged: (selectedValue) {},
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.check),
              label: Text('Add'),
            ),
          ],
        ),
      )),
    );
  }
}
