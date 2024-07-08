import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

import '../../data/models/network_response.dart';
import '../../data/models/task_model.dart';
import '../../data/network_caller/network_caller.dart';
import '../../data/utility/urls.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.taskModel});

  final TaskModel taskModel;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _deleteInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: Text(widget.taskModel.title ?? ' '),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.taskModel.description ?? ' '),
            Text(
              'Date ${widget.taskModel.createdDate}',
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(widget.taskModel.status ?? ''),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                ButtonBar(
                  children: [
                    Visibility(
                      visible: _deleteInProgress==false,
                      replacement: const Center(child: CircularProgressIndicator(),),
                      child: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.delete)),
                    ),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> _deleteTask() async {
    _deleteInProgress = true;
    if (mounted) {
      setState(() {});
    }

    NetworkResponse response = await NetworkCaller.getRequest(Urls.deleteTask(widget.taskModel.sId!));

    if (response.isSuccess) {

    } else {
      if (mounted) {
        snackBarMessage(
            context,
            response.errorMessage ?? ' Failed to load new task! Tray again',
            true);
      }
    }

    _deleteInProgress = false;
    if (mounted) {
      setState(() {});
    }
  }

}
