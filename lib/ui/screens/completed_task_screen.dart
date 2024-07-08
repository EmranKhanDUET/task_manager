import 'package:flutter/material.dart';
import 'package:task_manager/data/utility/urls.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_wrapper_model.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_item.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {

  bool _getCompletedTaskInProgress = false;
  List<TaskModel> completedTaskList = [];

  @override
  void initState() {
    super.initState();

    _getCompletedTask();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _getCompletedTask();
                },
                child: Visibility(
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  visible: _getCompletedTaskInProgress == false,
                  child: ListView.builder(
                    itemCount: completedTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel: completedTaskList[index],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getCompletedTask() async {
    _getCompletedTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(Urls.completedTask);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseData);
      completedTaskList = taskListWrapperModel.data ?? [];
    } else {
      if (mounted) {
        snackBarMessage(
            context,
            response.errorMessage ?? ' Failed to load completed task! Tray again',
            true);
      }
    }

    _getCompletedTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
