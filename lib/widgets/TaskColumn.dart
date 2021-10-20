import 'package:flutter/material.dart';
import 'package:test_project/models/task.dart';
import 'package:test_project/widgets/TaskCard.dart';

class TaskColumn extends StatelessWidget {
  final String columnTitle;
  final List<Task> tasks;

  const TaskColumn({Key? key, required this.columnTitle, required this.tasks})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Text(
                  columnTitle,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(width: 6,),
              Text(
                tasks.length.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.black38),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          ...tasks.map((e) => TaskCard(task: e)),

        ],
      ),
    );
  }
}
