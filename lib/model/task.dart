import 'package:uuid/uuid.dart';

class Task {
  late String id;
  late String title;

  Task({
    required this.id,
    required this.title,
  });

  Task.newTask() {
    id = const Uuid().v4();
    title = "";
  }

  static Task fromMap(Map<String, Object?> json) => Task(
        id: json["id"] as String,
        title: json["title"] as String,
      );

  Map<String, Object> toMap() => {
        "id": id,
        "title": title,
      };
}
