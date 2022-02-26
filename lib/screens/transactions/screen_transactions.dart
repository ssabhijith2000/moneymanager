import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/db/category/category_db.dart';
import 'package:money_manager/db/transactions/transaction_db.dart';
import 'package:money_manager/models/category/category_model.dart';
import 'package:money_manager/models/transactions/transaction_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ScreenTransactions extends StatefulWidget {
  const ScreenTransactions({Key? key}) : super(key: key);

  @override
  State<ScreenTransactions> createState() => _ScreenTransactionsState();
}

class _ScreenTransactionsState extends State<ScreenTransactions> {
  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListNotifier,
        builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
          return ListView.separated(
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                final _value = newList[index];
                return Slidable(
                  key: Key(_value.id!),
                  startActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: [
                      SlidableAction(onPressed: (ctx){
                        TransactionDB.instance.deleteTransaction(_value.id!);
                      }, icon: Icons.delete,label: 'Delete',)
                    ],
                  ),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                          radius: 25,
                          backgroundColor: _value.type == CategoryType.income
                              ? Colors.red
                              : Colors.green,
                          child: Text(
                            parseDate(_value.date),
                            textAlign: TextAlign.center,
                          )),
                      title: Text('Rs ${_value.amount}'),
                      subtitle: Text(_value.category.name),
                    ),
                    elevation: 10,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: newList.length);
        });
  }

  String parseDate(DateTime date) {
    List<String> _data = DateFormat.MMMd().format(date).split(' ');
    return '${_data.last}\n${_data.first}';
    //return '${date.day}\n${date.month}';
  }
}
