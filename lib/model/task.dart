class Task {
  late String id;
  late String title;

  Task({
    required this.id,
    required this.title,
  });

  static Task fromMap(Map<String, Object?> json) => Task(
        id: json["id"] as String,
        title: json["title"] as String,
      );

  Map<String, Object> toMap() => {
        "id": id,
        "title": title,
      };
}
