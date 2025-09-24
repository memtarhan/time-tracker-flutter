import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/project.dart';
import 'models/task.dart';
import 'models/time_entry.dart';

class StorageService {
  static const String _projectsKey = 'projects';
  static const String _tasksKey = 'tasks';
  static const String _entriesKey = 'entries';

  static Future<List<Project>> getProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_projectsKey) ?? [];
    return data.map((e) => Project.fromJson(jsonDecode(e))).toList();
  }

  static Future<void> saveProject(Project project) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_projectsKey) ?? [];
    list.add(jsonEncode(project.toJson()));
    await prefs.setStringList(_projectsKey, list);
  }

  static Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_tasksKey) ?? [];
    return data.map((e) => Task.fromJson(jsonDecode(e))).toList();
  }

  static Future<void> saveTask(Task task) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_tasksKey) ?? [];
    list.add(jsonEncode(task.toJson()));
    await prefs.setStringList(_tasksKey, list);
  }

  static Future<List<TimeEntry>> getEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList(_entriesKey) ?? [];
    return data.map((e) => TimeEntry.fromJson(jsonDecode(e))).toList();
  }

  static Future<void> saveEntry(TimeEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_entriesKey) ?? [];
    list.add(jsonEncode(entry.toJson()));
    await prefs.setStringList(_entriesKey, list);
  }

  static Future<void> deleteEntry(int index) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_entriesKey) ?? [];
    list.removeAt(index);
    await prefs.setStringList(_entriesKey, list);
  }
}