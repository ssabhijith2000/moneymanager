import 'package:flutter/material.dart';

class IncomeCatgoryList extends StatelessWidget {
  const IncomeCatgoryList({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (ctx,index){
         return ListTile(title: Text('Income Category $index'), trailing: const Icon(Icons.delete),);
      },
      separatorBuilder: (ctx,index) {
        return SizedBox(height: 10);
      },
      itemCount: 10,
      
    );
  }
}