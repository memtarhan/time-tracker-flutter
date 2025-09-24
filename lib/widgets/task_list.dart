import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;

  TaskList({required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return Center(child: Text("No Tasks"));
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, i) => ListTile(title: Text(tasks[i].name)),
    );
  }
}