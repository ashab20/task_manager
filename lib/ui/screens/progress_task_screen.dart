import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/widget/profile_summary_card.dart';
import 'package:task_manager/ui/widget/summary_card.dart';
import 'package:task_manager/ui/widget/task_item_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  bool getNewTaskInProgress = false;
  TaskListModel taskListModel = TaskListModel();

  Future<void> getNewTaskList()async{
    getNewTaskInProgress = true;
    if(mounted){
      setState(() {});
    }

    final NetworkResponse response = await NetworkCaller().getRequest("${Urls.taskListStatus}/inProgress");

    if(response.isSuccess){
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }

    getNewTaskInProgress = false;
    if(mounted){
      setState(() {});
    }
  }


  @override
  void initState() {
    super.initState();
    getNewTaskList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const profileSummaryCard(),
            Expanded(
              child:Visibility(
                visible: !getNewTaskInProgress,
                replacement: const Center(child: CircularProgressIndicator(),),
                child: ListView.builder(
                  itemCount: taskListModel.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return taskItemCard(
                        taskData:taskListModel.taskList![index]
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
