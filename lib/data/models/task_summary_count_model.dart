import 'package:task_manager/data/models/task_count.dart';

class TaskSummaryCountModel {
  String? status;
  List<TaskCount>? taskCountList;

  TaskSummaryCountModel({this.status, this.taskCountList});

  TaskSummaryCountModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskCountList = <TaskCount>[];
      json['data'].forEach((v) {
        taskCountList!.add(TaskCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskCountList != null) {
      data['data'] = taskCountList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


