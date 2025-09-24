import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/time_entry.dart';
import '../storage_service.dart';
import 'add_entry_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TimeEntry> _entries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  void _loadEntries() async {
    final list = await StorageService.getEntries();
    setState(() {
      _entries = list;
    });
  }

  void _deleteEntry(int index) async {
    await StorageService.deleteEntry(index);
    _loadEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracker"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text("Menu", style: TextStyle(fontSize: 24)),
            ),
            ListTile(
              title: Text("Projects"),
              onTap: () {
                Navigator.pushNamed(context, "/projects");
              },
            ),
            ListTile(
              title: Text("Tasks"),
              onTap: () {
                Navigator.pushNamed(context, "/tasks");
              },
            ),
          ],
        ),
      ),
      body: _entries.isEmpty
          ? Center(child: Text("No time entries yet"))
          : ListView.builder(
        itemCount: _entries.length,
        itemBuilder: (context, index) {
          final entry = _entries[index];
          return Dismissible(
            key: ValueKey(index),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) {
              _deleteEntry(index);
            },
            child: ListTile(
              title: Text("${entry.project} - ${entry.task}"),
              subtitle: Text(
                  "${entry.notes} (${entry.hours}h on ${entry.date})"),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddEntryScreen()),
          );
          _loadEntries();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}