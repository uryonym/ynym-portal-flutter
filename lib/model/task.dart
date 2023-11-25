import 'db_helper.dart';
import 'package:intl/intl.dart';

class Task {
  int? id;
  String title;
  bool isComplete;
  DateTime createdAt;

  Task({
    this.id,
    required this.title,
    required this.isComplete,
    required this.createdAt,
  });

  Task copy({
    int? id,
    String? title,
    bool? isComplete,
    DateTime? createdAt,
  }) =>
      Task(
          id: id ?? this.id,
          title: title ?? this.title,
          isComplete: isComplete ?? this.isComplete,
          createdAt: createdAt ?? this.createdAt);

  static Task fromJson(Map<String, Object?> json) => Task(
        id: json[columnId] as int,
        title: json[columnTitle] as String,
        isComplete: json[columnIsComplete] as bool,
        createdAt: DateTime.parse(json[columnCreatedAt] as String),
      );

  Map<String, Object> toJson() => {
        columnTitle: title,
        columnIsComplete: isComplete,
        columnCreatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAt),
      };
}
