import 'package:flutter/material.dart';
import 'package:test_project/models/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  task.title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.black87),
                ),
                SizedBox(
                  width: 6,
                ),
                Icon(
                  Icons.label_important,
                  color: Colors.red,
                ),
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Icon(
                  Icons.access_time_outlined,
                  color: Colors.black45,
                  size: 18,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  task.time,
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: 14,
            ),
            Row(
              children: [
                Icon(
                  Icons.mode_comment_outlined,
                  color: Colors.black45,
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  task.comments.toString(),
                  style: TextStyle(
                      color: Colors.black45, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 6,
                ),
                Spacer(),
                Icon(
                  Icons.attach_file,
                  color: Colors.black45,
                ),
                SizedBox(
                  width: 6,
                ),
                Icon(
                  Icons.more_horiz,
                  color: Colors.black45,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
