import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/time_entry.dart';
import '../models/project.dart';
import '../models/task.dart';
import '../storage_service.dart';

class AddEntryScreen extends StatefulWidget {
  @override
  _AddEntryScreenState createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  int _hours = 0;
  String? _project;
  String? _task;
  String _notes = "";
  String _date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  List<Project> _projects = [];
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    final p = await StorageService.getProjects();
    final t = await StorageService.getTasks();
    setState(() {
      _projects = p;
      _tasks = t;
    });
  }

  void _saveEntry() async {
    if (_formKey.currentState!.validate() &&
        _project != null &&
        _task != null) {
      _formKey.currentState!.save();

      final entry = TimeEntry(
        project: _project!,
        task: _task!,
        notes: _notes,
        date: _date,
        hours: _hours,
      );

      await StorageService.saveEntry(entry);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Time Entry")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              DropdownButtonFormField<String>(
                hint: Text("Select Project"),
                value: _project,
                items: _projects
                    .map((p) =>
                    DropdownMenuItem(value: p.name, child: Text(p.name)))
                    .toList(),
                onChanged: (val) => setState(() => _project = val),
                validator: (val) =>
                val == null ? "Please select a project" : null,
              ),
              DropdownButtonFormField<String>(
                hint: Text("Select Task"),
                value: _task,
                items: _tasks
                    .map((t) =>
                    DropdownMenuItem(value: t.name, child: Text(t.name)))
                    .toList(),
                onChanged: (val) => setState(() => _task = val),
                validator: (val) =>
                val == null ? "Please select a task" : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Hours"),
                keyboardType: TextInputType.number,
                onSaved: (val) => _hours = int.parse(val ?? "0"),
                validator: (val) =>
                (val == null || val.isEmpty) ? "Enter hours" : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Notes"),
                onSaved: (val) => _notes = val ?? "",
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Date"),
                initialValue: _date,
                onSaved: (val) => _date = val ?? _date,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveEntry,
                child: Text("Save"),
              )
            ],
          ),
        ),
      ),
    );
  }
}