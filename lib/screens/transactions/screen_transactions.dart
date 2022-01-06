import 'package:flutter/material.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return const Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('12 \nDec',textAlign: TextAlign.center,)),
              title: Text('1000'),
              subtitle: Text('Travel'),
            ),
          elevation: 10,);
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 10);
        },
        itemCount: 10);
  }
}
