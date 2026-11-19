class Task {
  const Task({
    required this.id,
    required this.title,
    required this.isCompleted,
  });

  final String id;
  final String title;
  final bool isCompleted;

  Task copyWith({String? title, bool? isCompleted}) {
    return Task(
      id: id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, Object?> toJson() => {
        'id': id,
        'title': title,
        'isCompleted': isCompleted,
      };

  factory Task.fromJson(Map<String, Object?> json) => Task(
        id: json['id'] as String,
        title: json['title'] as String,
        isCompleted: json['isCompleted'] as bool? ?? false,
      );
}
