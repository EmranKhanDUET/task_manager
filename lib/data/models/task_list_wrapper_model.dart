import 'package:task_manager/data/models/task_model.dart';

class TaskListWrapperModel {
  String? status;
  List<TaskModel>? data;

  TaskListWrapperModel({this.status, this.data});

  TaskListWrapperModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <TaskModel>[];
      json['data'].forEach((v) {
        data!.add(TaskModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

