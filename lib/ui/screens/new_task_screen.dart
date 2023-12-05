import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_count.dart';
import 'package:task_manager/data/models/task_list_model.dart';
import 'package:task_manager/data/models/task_summary_count_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/data/utilities/urls.dart';
import 'package:task_manager/ui/screens/add_new_tasks_screen.dart';
import 'package:task_manager/ui/widget/profile_summary.dart';
import 'package:task_manager/ui/widget/summary_card.dart';
import 'package:task_manager/ui/widget/task_item_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool getNewTaskInProgress = false;
  bool getTaskSummaryInProgress = false;
  TaskListModel taskListModel = TaskListModel();
  TaskSummaryCountModel taskSummaryCountModel = TaskSummaryCountModel();

  Future<void> getNewTaskList()async{
    getNewTaskInProgress = true;
    if(mounted){
        setState(() {});
    }

    final NetworkResponse response = await NetworkCaller().getRequest("${Urls.taskListStatus}/New");

    if(response.isSuccess){
      taskListModel = TaskListModel.fromJson(response.jsonResponse);
    }

    getNewTaskInProgress = false;
    if(mounted){
      setState(() {});
    }
  }

 Future<void> taskCountSummaryList()async{
   getTaskSummaryInProgress = true;
    if(mounted){
        setState(() {});
    }

    final NetworkResponse response = await NetworkCaller().getRequest(Urls.taskStatusCount);

    if(response.isSuccess){
      taskSummaryCountModel = TaskSummaryCountModel.fromJson(response.jsonResponse);
    }

   getTaskSummaryInProgress = false;
    if(mounted){
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    taskCountSummaryList();
    getNewTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> AddNewTaskScreen()));
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Column(
            children: [
              const ProfileSummary(),
              Visibility(
                visible: !getTaskSummaryInProgress && (taskSummaryCountModel.taskCountList?.isNotEmpty ?? false),
                replacement: const Center(
                  child: LinearProgressIndicator(),
                ),
                child: SizedBox(
                  height: 120,
                  child:ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: taskSummaryCountModel.taskCountList?.length ?? 0,
                  itemBuilder: (context,index){
                    TaskCount taskCount = taskSummaryCountModel.taskCountList![index];
                    return FittedBox(child:SummaryCard(count: taskCount.sum.toString() ,title: taskCount.sId.toString() ?? '',),);
                  },
                  ),
                ),
              ),
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
                    },),
              ),
              ),
            ],
        ),
      ),
    );
  }
}

