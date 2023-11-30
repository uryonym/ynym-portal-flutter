import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:ynym_portal/model/db_helper.dart';
import 'package:ynym_portal/model/task.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskList> {
  List<Task> tasks = [];
  bool isLoading = true;

  void refreshData() async {
    final response = await DbHelper.instance.getTasks();
    setState(() {
      tasks = response;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    refreshData();
  }

  Future<void> createTask() async {
    final Task newTask =
        Task(id: const Uuid().v4(), title: titleController.text);
    await DbHelper.instance.insert(newTask);
    refreshData();
  }

  Future<void> updateTask(String id) async {
    final Task updateTask = Task(id: id, title: titleController.text);
    await DbHelper.instance.update(updateTask);
    refreshData();
  }

  Future<void> deleteTask(String id) async {
    await DbHelper.instance.delete(id);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("削除しました")));
    refreshData();
  }

  final TextEditingController titleController = TextEditingController();

  void showBottomSheet(String? id) async {
    if (id != null) {
      final existingTask = tasks.firstWhere((element) => element.id == id);
      titleController.text = existingTask.title;
    }

    showModalBottomSheet(
        elevation: 5,
        isScrollControlled: true,
        context: context,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 30,
                left: 15,
                right: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom + 50,
              ),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), hintText: "Title"),
                    ),
                    const SizedBox(height: 20),
                    Center(
                        child: ElevatedButton(
                      child: const Text("保存"),
                      onPressed: () async {
                        if (id == null) {
                          await createTask();
                        } else {
                          await updateTask(id);
                        }

                        Navigator.pop(context);
                      },
                    ))
                  ]),
            )).whenComplete(() => titleController.text = "");
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
            : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => deleteTask(task.id)),
                    onTap: () => showBottomSheet(task.id),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showBottomSheet(null),
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
