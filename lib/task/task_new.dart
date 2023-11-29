import 'package:flutter/material.dart';
import 'package:ynym_portal/model/db_helper.dart';
import 'package:ynym_portal/model/task.dart';
import 'package:uuid/uuid.dart';

class TaskNew extends StatefulWidget {
  const TaskNew({super.key});

  @override
  State<TaskNew> createState() => _TaskNewState();
}

class _TaskNewState extends State<TaskNew> {
  late String id;
  late String title;

  @override
  void initState() {
    super.initState();

    id = const Uuid().v4();
    title = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('タスク作成'),
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
    final Task newTask = Task(id: id, title: title);

    await DbHelper.instance.insert(newTask);
  }
}
