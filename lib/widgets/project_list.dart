import 'package:flutter/material.dart';
import '../models/project.dart';

class ProjectList extends StatelessWidget {
  final List<Project> projects;

  ProjectList({required this.projects});

  @override
  Widget build(BuildContext context) {
    if (projects.isEmpty) {
      return Center(child: Text("No Projects"));
    }

    return ListView.builder(
      itemCount: projects.length,
      itemBuilder: (context, i) => ListTile(title: Text(projects[i].name)),
    );
  }
}