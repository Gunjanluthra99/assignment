import 'package:flutter/material.dart';
import 'package:test_project/models/task.dart';
import 'package:test_project/widgets/TaskColumn.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Icon(
            Icons.search,
            color: Colors.black,
            size: 26,
          ),
          SizedBox(
            width: 16,
          ),
          Icon(
            Icons.settings_outlined,
            color: Colors.black,
            size: 26,
          ),
          SizedBox(
            width: 16,
          ),
          Icon(
            Icons.people_outline,
            color: Colors.black,
            size: 26,
          ),
          SizedBox(
            width: 16,
          ),
        ],
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Signy App",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black38,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Sprint #43",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            TaskColumn(
              columnTitle: "To Do",
              tasks: [
                Task(
                    title: "User Profile (view & editing)",
                    time: "2 Aug",
                    comments: 4)
              ],
            ),
            TaskColumn(
              columnTitle: "In Progress",
              tasks: [
                Task(
                    title: "Signy up / in screens", time: "28 Aug", comments: 2)
              ],
            ),
            TaskColumn(
              columnTitle: "In Review",
              tasks: [
                Task(title: "On-boarding Screens", time: "28 Aug", comments: 2),
                Task(title: "App Design", time: "28 Aug", comments: 1)
              ],
            )
          ],
        ),
      ),
    );
  }
}
