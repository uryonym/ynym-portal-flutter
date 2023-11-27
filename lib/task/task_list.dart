import 'package:flutter/material.dart';
import 'package:ynym_portal/model/db_helper.dart';
import 'package:ynym_portal/model/task.dart';
import 'package:ynym_portal/task/task_new.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskList> {
  List<Task> taskList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getTasksList();
  }

  Future getTasksList() async {
    setState(() => isLoading = true);
    taskList = await DbHelper.instance.selectAllTasks();
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
                  itemCount: taskList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final task = taskList[index];
                    return ListTile(
                      leading: Text(task.title),
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
