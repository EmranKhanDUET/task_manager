import 'package:task_manager/data/models/task_by_status_count.dart';

class TaskByStatusCountWrapperModel {
  String? status;
  List<TaskByStatusCount>? taskCountByStatusList;

  TaskByStatusCountWrapperModel({this.status, this.taskCountByStatusList});

  TaskByStatusCountWrapperModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      taskCountByStatusList = <TaskByStatusCount>[];
      json['data'].forEach((v) {
        taskCountByStatusList!.add(TaskByStatusCount.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (taskCountByStatusList != null) {
      data['data'] = taskCountByStatusList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

