import 'package:flutter/material.dart';
import 'package:test_project/models/empData.dart';
import 'package:test_project/service/apiClient.dart';
import 'package:test_project/widget/SpinnerWidget.dart';

class EmployeeScreen extends StatelessWidget {


  // get Future<List<Items>> via the postService
  var items = ApiClient().getEmployeeList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Employees"),
        ),
        body: EmployeeList(
          items: items,
        ));
  }
}

class EmployeeList extends StatelessWidget {
  final Future<List<Data>> items;

  EmployeeList({required this.items});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: items,
      builder: (context, snapshot) {
        // operation for completed state
        if (snapshot.hasData) {
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var item = snapshot.data![index];
                return ListTile(item);
              });
        }

        // spinner for uncompleted state
        return SpninnerWidget();
      },
    );
  }
}

class ListRow extends StatelessWidget {
  Data item;
  ListRow(this.item);


  @override
  Widget build(BuildContext context) {
    return   Column(
      children: <Widget>[
        Divider(
          height: 12.0,
        ),
        ListTile(leading: CircleAvatar(
          radius: 24.0,
          backgroundImage: NetworkImage("https://i.pravatar.cc/150?u=${item.id}"),
        ),title: Column(
          children: <Widget>[
            Text(item.employeeName),
            SizedBox(
              width: 16.0,
            ),
            Text(
              item.employeeName,
              style: TextStyle(fontSize: 12.0),
            ),
          ],
        ),)

      ],
    );



}