import 'package:flutter/material.dart';
class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: ListTile(
        title: const Text('Title will be here'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Description will be here'),
            const Text(
              'Date 12/2/2012',
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: const Text('New'),
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                  ),
                ),
                ButtonBar(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.delete)),
                    IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}