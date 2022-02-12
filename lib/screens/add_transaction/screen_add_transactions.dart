import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/screens/category/category_add_popup.dart';

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
  String? _categoryID;
  @override
  void initState() {
    _selectedCategoryType = CategoryType.income;
    super.initState();
  }

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
                      groupValue: _selectedCategoryType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategoryType = CategoryType.income;
                          _categoryID = null;
                         });
                      },
                    ),
                    Text('Income'),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: CategoryType.expense,
                      groupValue: _selectedCategoryType,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedCategoryType = CategoryType.expense;
                          _categoryID = null;
                        });
                      },
                    ),
                    Text('Expense'),
                  ],
                ),
              ],
            ),
            DropdownButton<String?>(
              hint: Text('Select Category'),
              value: _categoryID,
              items: (_selectedCategoryType == CategoryType.income
                      ? CategoryDB.instance.incomeCategoryList
                      : CategoryDB().expenseCategoryList)
                  .value
                  .map((e) {
                return DropdownMenuItem(
                  child: Text(e.name),
                  value: e.id,
                );
              }).toList(),
              onChanged: (selectedValue) {
                setState(() {
                  _categoryID = selectedValue;
                });
 
              },
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
