class Task {
  String title;
  bool isCompleted;
  bool isImportant;
  DateTime? dueDate;
  int priorty;

  Task({
    required this.title,
    this.isCompleted = false,
    this.isImportant = false,
    this.dueDate,
    this.priorty = 0,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      isCompleted: json['isCompleted'] ?? false,
      isImportant: json['isImportant'] ?? false,
      dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
      priorty: json['priorty'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'isImportant': isImportant,
      'dueDate': dueDate?.toIso8601String(),
      'priorty': priorty,
    };
  }
}
