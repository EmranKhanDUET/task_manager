import 'package:flutter/material.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_list_wrapper_model.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utility/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_item.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskInProgress = false;
  List<TaskModel> cancelledTaskList = [];

  @override
  void initState() {
    super.initState();

    _getCancelledTask();
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
                  _getCancelledTask();
                },
                child: Visibility(
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  visible: _getCancelledTaskInProgress == false,
                  child: ListView.builder(
                    itemCount: cancelledTaskList.length,
                    itemBuilder: (context, index) {
                      return TaskItem(
                        taskModel: cancelledTaskList[index],
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

  Future<void> _getCancelledTask() async {
    _getCancelledTaskInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(Urls.cancelledTask);

    if (response.isSuccess) {
      TaskListWrapperModel taskListWrapperModel =
      TaskListWrapperModel.fromJson(response.responseData);
      cancelledTaskList = taskListWrapperModel.data ?? [];
    } else {
      if (mounted) {
        snackBarMessage(
            context,
            response.errorMessage ?? ' Failed to load completed task! Tray again',
            true);
      }
    }

    _getCancelledTaskInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }
}
