import 'package:flutter/material.dart';

import '../models/task.dart';
import '../utils/format.dart';
import '../widgets/priority_chip.dart';

enum DetailAction { toggle, delete }

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Tugas')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title, style: Theme.of(context).textTheme.headlineSmall),
            if (task.description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(task.description),
            ],
            const SizedBox(height: 12),
            Text('Tenggat: ${formatDate(task.dueDate)}'),
            const SizedBox(height: 8),
            Row(
              children: [
                const Text('Level: '),
                PriorityChip(priority: task.priority),
              ],
            ),
            const SizedBox(height: 8),
            Text('Status: ${task.isDone ? 'Selesai' : 'Belum selesai'}'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context, DetailAction.toggle),
                child: Text(
                  task.isDone ? 'Tandai belum selesai' : 'Tandai selesai',
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context, DetailAction.delete),
                child: const Text('Hapus tugas'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
