import 'package:flutter/material.dart';
import '../models/task.dart';
import '../storage_service.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  List<Task> _tasks = [];
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    final list = await StorageService.getTasks();
    setState(() {
      _tasks = list;
    });
  }

  void _addTask() async {
    if (_controller.text.isNotEmpty) {
      await StorageService.saveTask(Task(name: _controller.text));
      _controller.clear();
      Navigator.pop(context);
      _loadTasks();
    }
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Task"),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: "Task name"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(onPressed: _addTask, child: Text("Add")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tasks")),
      body: _tasks.isEmpty
          ? Center(child: Text("No Tasks"))
          : ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, i) => ListTile(title: Text(_tasks[i].name)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}