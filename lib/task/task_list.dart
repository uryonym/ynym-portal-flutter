import 'package:flutter/material.dart';
import 'package:ynym_portal/model/db_helper.dart';
import 'package:ynym_portal/model/task.dart';
import 'package:ynym_portal/task/task_edit.dart';
import 'package:ynym_portal/task/task_new.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskList> {
  List<Task> tasks = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    getTasks();
  }

  Future getTasks() async {
    setState(() => isLoading = true);
    tasks = await DbHelper.instance.getTasks();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('タスク一覧'),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    final task = tasks[index];
                    return ListTile(
                      leading: Text(task.title),
                      onTap: () async {
                        await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TaskEdit(task: task)));
                      },
                    );
                  },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const TaskNew()));
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
