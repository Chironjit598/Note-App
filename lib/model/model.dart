class Task {
  String title;
  bool isCompleted;
  bool isImportant;
  DateTime? dueTime;
  int priorty;

  Task({
    required this.title,
    this.isCompleted = false,
    this.isImportant = false,
    this.dueTime,
    this.priorty = 0,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      isCompleted: json['isCompleted'] ?? false,
      isImportant: json['isImportant'] ?? false,
      dueTime: json['dueTime'] != null ? DateTime.parse(json['dueTime']) : null,
      priorty: json['priorty'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'isImportant': isImportant,
      'dueTime': dueTime,
      'priorty': priorty,
    };
  }
}
