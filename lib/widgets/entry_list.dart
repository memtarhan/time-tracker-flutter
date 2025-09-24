import 'package:flutter/material.dart';
import '../models/time_entry.dart';

class EntryList extends StatelessWidget {
  final List<TimeEntry> entries;
  final Function(int) onDelete;

  EntryList({required this.entries, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Center(child: Text("No time entries yet"));
    }

    return ListView.builder(
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final entry = entries[index];
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
            onDelete(index);
          },
          child: ListTile(
            title: Text("${entry.project} - ${entry.task}"),
            subtitle: Text(
                "${entry.notes} (${entry.hours}h on ${entry.date})"),
          ),
        );
      },
    );
  }
}