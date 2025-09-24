import 'package:flutter/material.dart';
import '../models/project.dart';
import '../storage_service.dart';

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  List<Project> _projects = [];
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  void _loadProjects() async {
    final list = await StorageService.getProjects();
    setState(() {
      _projects = list;
    });
  }

  void _addProject() async {
    if (_controller.text.isNotEmpty) {
      await StorageService.saveProject(Project(name: _controller.text));
      _controller.clear();
      Navigator.pop(context);
      _loadProjects();
    }
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Add Project"),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: "Project name"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(onPressed: _addProject, child: Text("Add")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Projects")),
      body: _projects.isEmpty
          ? Center(child: Text("No Projects"))
          : ListView.builder(
        itemCount: _projects.length,
        itemBuilder: (context, i) => ListTile(title: Text(_projects[i].name)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}