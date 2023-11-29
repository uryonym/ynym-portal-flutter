import 'package:flutter/material.dart';
import 'package:ynym_portal/model/db_helper.dart';
import 'package:ynym_portal/model/task.dart';

class TaskEdit extends StatefulWidget {
  final Task task;

  const TaskEdit({super.key, required this.task});

  @override
  State<TaskEdit> createState() => _TaskEditState();
}

class _TaskEditState extends State<TaskEdit> {
  late String id;
  late String title;

  @override
  void initState() {
    super.initState();

    id = widget.task.id;
    title = widget.task.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('タスク編集'),
          actions: [TextButton(onPressed: saveTask, child: const Text("保存"))],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Text(id),
              TextFormField(
                maxLines: 1,
                initialValue: title,
                decoration: const InputDecoration(hintText: "タスク"),
                onChanged: (title) => setState(() => this.title = title),
              )
            ],
          ),
        ));
  }

  void saveTask() async {
    final Task updateTask = Task(id: id, title: title);

    await DbHelper.instance.update(updateTask);
  }
}
