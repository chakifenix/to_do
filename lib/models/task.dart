class Task {
  final String id;
  final String title;
  final String subtitle;
  DateTime createdTime;
  DateTime createdDate;
  bool isCompleted;

  Task(
      {required this.id,
      required this.title,
      required this.subtitle,
      required this.createdTime,
      required this.createdDate,
      required this.isCompleted});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'createdTime': createdTime.toIso8601String(),
      'createdDate': createdDate.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        id: json['id'],
        title: json['title'],
        subtitle: json['subtitle'],
        createdTime: DateTime.parse(json['createdTime']),
        createdDate: DateTime.parse(json['createdDate']),
        isCompleted: json['isCompleted']);
  }
}
