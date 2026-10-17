enum Priority {
  rendah('Rendah'),
  sedang('Sedang'),
  tinggi('Tinggi');

  const Priority(this.label);
  final String label;
}

class Task {
  Task({
    required this.id,
    required this.title,
    required this.dueDate,
    this.description = '',
    this.priority = Priority.sedang,
    this.isDone = false,
  });

  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final Priority priority;
  bool isDone;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'dueDate': dueDate.toIso8601String(),
        'priority': priority.name,
        'isDone': isDone,
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json['id'] as String,
        title: json['title'] as String,
        description: json['description'] as String? ?? '',
        dueDate: DateTime.parse(json['dueDate'] as String),
        priority: Priority.values.byName(json['priority'] as String),
        isDone: json['isDone'] as bool? ?? false,
      );
}
