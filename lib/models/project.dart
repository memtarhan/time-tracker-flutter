class Project {
  String name;
  Project({required this.name});

  Map<String, dynamic> toJson() => {'name': name};
  factory Project.fromJson(Map<String, dynamic> json) => Project(name: json['name']);
}