class TimeEntry {
  String project;
  String task;
  String notes;
  String date;
  int hours;

  TimeEntry({
    required this.project,
    required this.task,
    required this.notes,
    required this.date,
    required this.hours,
  });

  Map<String, dynamic> toJson() => {
    'project': project,
    'task': task,
    'notes': notes,
    'date': date,
    'hours': hours,
  };

  factory TimeEntry.fromJson(Map<String, dynamic> json) => TimeEntry(
    project: json['project'],
    task: json['task'],
    notes: json['notes'],
    date: json['date'],
    hours: json['hours'],
  );
}