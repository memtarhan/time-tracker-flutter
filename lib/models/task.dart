class Task {
  String name;
  Task({required this.name});

  Map<String, dynamic> toJson() => {'name': name};
  factory Task.fromJson(Map<String, dynamic> json) => Task(name: json['name']);
}