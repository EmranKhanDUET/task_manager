import 'package:flutter/material.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_by_status_count.dart';
import 'package:task_manager/data/models/task_by_status_count_wrapper_model.dart';
import 'package:task_manager/data/models/task_list_wrapper_model.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/data/network_caller/network_caller.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/utility/app_colors.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

import '../../data/utility/urls.dart';
import '../widgets/task_item.dart';
import '../widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskInProgress = false;
  bool _getTaskCountByStatusInProgress = false;
  List<TaskModel> newTaskList = [];
  List<TaskByStatusCount> taskCountByStatusList = [];

  @override
  void initState() {
    super.initState();

    _getNewTask();
    _getTaskCountByStatusTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          children: [
            _buildSummarySection(),
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _getNewTask();
                  _getTaskCountByStatusTask();
                },
                child: Visibility(
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  visible: _getNewTaskInProgress == false,
                  child: ListView.builder(
                    itemCount: newTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel: newTaskList[index],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddButton,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.themeColor,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onTapAddButton() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
  }

  Widget _buildSummarySection() {
    return Visibility(
      visible: _getTaskCountByStatusInProgress==false,
      replacement: const SizedBox(height: 100,child: Center(child: CircularProgressIndicator(),),),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: taskCountByStatusList.map((e){
            return TaskSummaryCard(
              title: (e.sId ?? 'Unknown').toUpperCase(),
              count: e.sum.toString() ,
            );

          }).toList()
        ),
      ),
    );
  }

  Future<void> _getNewTask() async {
    _getNewTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(Urls.newTask);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
          TaskListWrapperModel.fromJson(response.responseData);
      newTaskList = taskListWrapperModel.data ?? [];
    } else {
      if (mounted) {
        snackBarMessage(
            context,
            response.errorMessage ?? ' Failed to load new task! Tray again',
            true);
      }
    }

    _getNewTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _getTaskCountByStatusTask() async {
    _getTaskCountByStatusInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(Urls.taskStatusCount);

    if (response.isSuccess) {
      TaskByStatusCountWrapperModel taskByStatusCountWrapperModel =
          TaskByStatusCountWrapperModel.fromJson(response.responseData);
      taskCountByStatusList = taskByStatusCountWrapperModel.taskCountByStatusList ?? [];
    } else {
      if (mounted) {
        snackBarMessage(
            context,
            response.errorMessage ?? ' Failed to get task count ! Tray again',
            true);
      }
    }

    _getTaskCountByStatusInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
