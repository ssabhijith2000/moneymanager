import 'package:flutter/material.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/screens/category/category_add_popup.dart';
import 'package:money_manager/screens/category/screen_category.dart';
import 'package:money_manager/screens/home/widgets/bottom_navigation.dart';
import 'package:money_manager/screens/transactions/screen_transactions.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);
  final _pages = [ScreenTransactions(), ScreenCategory()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MONEY MANAGER'),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedIndexNotifier,
              builder: (BuildContext context, int updatedindex, _) {
                return _pages[updatedindex];
              })),
      bottomNavigationBar: const MoneyManagerBottomNavigation(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            
          } else {
            print('add catogories');
            showCategoryAddPopup(context);
          //   final _sample = CategoryModel(id: DateTime.now().millisecondsSinceEpoch.toString(), name: 'travel', type: CategoryType.expense);
          //   CategoryDB().insertCategory(_sample);
           }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
