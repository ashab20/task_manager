import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utilities/urls.dart';
import '../widget/profile_summary.dart';
import '../widget/task_item_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  TaskListModel taskListModel = TaskListModel();
  bool _taskListProgress = false;
  Future<void> getCancelledTask() async {
    _taskListProgress = true;
    if (mounted) {
      setState(() {});
    }
    final NetworkResponse response =
    await NetworkCaller().getRequest(Urls.cancelTaskList);
    if (response.isSuccess) {
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }
    _taskListProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
  @override
  void initState() {
    super.initState();
    getCancelledTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const ProfileSummary(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Visibility(
                  visible: _taskListProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: ListView.builder(
                    itemCount: taskListModel.taskList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskItemCard(
                        color: Colors.red,
                        task: taskListModel.taskList![index],
                        onDelete: () {
                          getCancelledTask();
                        },
                        onStatusChange: (){
                          getCancelledTask();
                        },
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }
}