import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utilities/urls.dart';
enum TaskStatus { New, Progress, Completed, Cancelled }

class TaskItemCard extends StatefulWidget {
  const TaskItemCard({
    super.key,
    required this.task,
    required this.onDelete,
    required this.color,
    required this.onStatusChange,
  });

  final Color color;
  final TaskData task;
  final VoidCallback onDelete;
  final VoidCallback onStatusChange;

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  Future<void> deleteTask() async {
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.deleteTask(widget.task.sId));
    if (response.isSuccess) {
      widget.onDelete();
    }
  }

  Future<void> updateTaskStatus(status) async {
    final response = await NetworkCaller()
        .getRequest(Urls.updateTaskStatus(widget.task.sId.toString(), status));
    if (response.isSuccess) {
      widget.onStatusChange();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(widget.task.description ?? ''),
            Text("Date: ${widget.task.createdDate}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task.status ?? 'New',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: widget.color,
                ),
                Wrap(
                  children: [
                    IconButton(
                        onPressed: showUpdateStatusModel,
                        icon: const Icon(
                          Icons.edit_note,
                          size: 30,
                          color: Colors.green,
                        )),
                    IconButton(
                        onPressed: showDeleteDialog,
                        icon: const Icon(
                          Icons.delete_forever_rounded,
                          color: Colors.red,
                        )),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> showUpdateStatusModel() async {
    List<ListTile> itmes = TaskStatus.values
        .map((e) => ListTile(
      title: Text(e.name),
      onTap: () {
        updateTaskStatus(e.name);
        Navigator.pop(context);
      },
    ))
        .toList();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Status"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: itmes,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          );
        });
  }

  void showDeleteDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Delete Task"),
            content: const Text("Do you want to delete task?"),
            actions: [
              TextButton(
                  onPressed: () {
                    deleteTask();
                    Navigator.pop(context);
                  },
                  child: const Text("Yes")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          );
        });
  }
}