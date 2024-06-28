import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/add_new_task_screen.dart';
import 'package:task_manager/ui/utility/app_colors.dart';

import '../widgets/task_item.dart';
import '../widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
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
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const TaskItem();
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddButton,
        child: const Icon(Icons.add),
        foregroundColor: Colors.white,
        backgroundColor: AppColors.themeColor,
      ),
    );


  }
  void _onTapAddButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AddNewTaskScreen()));
  }
  Widget _buildSummarySection() {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          TaskSummaryCard(
            title: 'New Task',
            count: '12',
          ),
          TaskSummaryCard(
            title: 'Completed',
            count: '12',
          ),
          TaskSummaryCard(
            title: 'In Progress',
            count: '12',
          ),
          TaskSummaryCard(
            title: 'Cancelled',
            count: '12',
          ),
        ],
      ),
    );
  }
}
