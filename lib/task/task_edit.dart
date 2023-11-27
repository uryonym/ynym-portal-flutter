import 'package:flutter/material.dart';
import 'package:ynym_portal/model/db_helper.dart';
import 'package:ynym_portal/model/task.dart';

class TaskEdit extends StatefulWidget {
  final int id;

  const TaskEdit({super.key, required this.id});

  @override
  State<TaskEdit> createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {
  late Task task;
  bool isLoading = false;
  static const int textExpandedFlex = 1;
  static const int dataExpandedFlex = 4;

  @override
  void initState() {
    super.initState();

  }

  Future taskData() async {
    setState(() => isLoading = true);
    task = await DbHelper.instance.taskData(widget.id);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('タスク編集'),
      ),
    );
  }
}
