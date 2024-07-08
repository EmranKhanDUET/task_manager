import 'package:flutter/material.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_wrapper_model.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utility/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_item.dart';

class InProgressTaskScreen extends StatefulWidget {
  const InProgressTaskScreen({super.key});

  @override
  State<InProgressTaskScreen> createState() => _InProgressTaskScreenState();
}

class _InProgressTaskScreenState extends State<InProgressTaskScreen> {
  bool _getInProgressTaskInProgress = false;
  List<TaskModel> inProgressTaskList = [];

  @override
  void initState() {
    super.initState();

    _getInProgressTask();
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
                  _getInProgressTask();
                },
                child: Visibility(
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  visible: _getInProgressTaskInProgress == false,
                  child: ListView.builder(
                    itemCount: inProgressTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel: inProgressTaskList[index],
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

  Future<void> _getInProgressTask() async {
    _getInProgressTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(Urls.inProgressTask);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseData);
      inProgressTaskList = taskListWrapperModel.data ?? [];
    } else {
      if (mounted) {
        snackBarMessage(
            context,
            response.errorMessage ?? ' Failed to load in progress task! Tray again',
            true);
      }
    }

    _getInProgressTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

}
