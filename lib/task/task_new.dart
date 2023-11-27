import 'package:flutter/material.dart';
import 'package:ynym_portal/model/db_helper.dart';
import 'package:ynym_portal/model/task.dart';

class TaskNew extends StatefulWidget {
  const TaskNew({super.key});

  @override
  State<TaskNew> createState() => _TaskNewState();
}

class _TaskNewState extends State<TaskNew> {
  late int id;
  late String title;
  late bool isComplete;
  late DateTime createdAt;

  @override
  void initState() {
    super.initState();
    title = "";
    isComplete = false;
    createdAt = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('タスク作成'),
          actions: [TextButton(onPressed: createTask, child: const Text("保存"))],
        ),
        body: SafeArea(
          child: Column(
            children: [
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

  void createTask() async {
    final task =
        Task(title: title, isComplete: isComplete, createdAt: createdAt);
    await DbHelper.instance.insert(task);
  }
}
