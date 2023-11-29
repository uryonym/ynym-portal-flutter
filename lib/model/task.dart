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
}
