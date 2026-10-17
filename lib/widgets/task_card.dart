import 'package:flutter/material.dart';

import '../models/task.dart';
import '../utils/format.dart';
import 'priority_chip.dart';

/// Widget dipakai berulang untuk setiap tugas.
class TaskCard extends StatelessWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onToggle,
    required this.onTap,
  });

  final Task task;
  final VoidCallback onToggle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        leading: Checkbox(value: task.isDone, onChanged: (_) => onToggle()),
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text('Tenggat: ${formatDate(task.dueDate)}'),
        trailing: PriorityChip(priority: task.priority),
      ),
    );
  }
}
